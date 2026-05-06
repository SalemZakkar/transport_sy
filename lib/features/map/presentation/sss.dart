import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transport_sy/features/line/domain/entity/line.dart';
import 'package:transport_sy/generated/generated_assets/assets.gen.dart';

const List<Color> _lineColors = [
  Color(0xFF1565C0),
  Color(0xFF2E7D32),
  Color(0xFFC62828),
];

const List<String> _manufacturers = [
  'Mercedes-Benz',
  'Volvo',
  'MAN',
  'Scania',
  'Isuzu',
  'Yutong',
  'King Long',
  'Higer',
];

// ─── Bus static info (randomised once at creation) ────────────────────────────

class _BusInfo {
  final String manufacturer;
  final int seats;
  final String busNumber; // 6-digit string

  _BusInfo({
    required this.manufacturer,
    required this.seats,
    required this.busNumber,
  });

  factory _BusInfo.random(Random rng) => _BusInfo(
    manufacturer: _manufacturers[rng.nextInt(_manufacturers.length)],
    seats: 14 + rng.nextInt(17), // 14..30
    busNumber: (100000 + rng.nextInt(900000)).toString(), // 100000..999999
  );
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

double _bearing(LatLng from, LatLng to) {
  final lat1 = from.latitude * pi / 180;
  final lat2 = to.latitude * pi / 180;
  final dLng = (to.longitude - from.longitude) * pi / 180;
  final y = sin(dLng) * cos(lat2);
  final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLng);
  return (atan2(y, x) * 180 / pi + 360) % 360;
}

Future<BitmapDescriptor> _rotatedBitmap(
    String assetPath,
    double degrees, {
      int size = 80,
    }) async {
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(
    bytes,
    targetWidth: size,
    targetHeight: size,
  );
  final frame = await codec.getNextFrame();
  final srcImage = frame.image;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final center = Offset(size / 2, size / 2);

  canvas.translate(center.dx, center.dy);
  canvas.rotate(degrees * pi / 180);
  canvas.translate(-center.dx, -center.dy);
  canvas.drawImage(srcImage, Offset.zero, Paint());

  final picture = recorder.endRecording();
  final img = await picture.toImage(size, size);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

// ─── Bus state ────────────────────────────────────────────────────────────────

class _BusState {
  final int lineIndex;
  final int busIndex;
  final _BusInfo info; // randomised static data
  int segmentIndex;
  double t;
  bool forward;

  _BusState({
    required this.lineIndex,
    required this.busIndex,
    required this.info,
    required this.segmentIndex,
    required this.t,
    required this.forward,
  });

  MarkerId get markerId => MarkerId('bus_${lineIndex}_$busIndex');
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class MapPage extends StatefulWidget {
  static String path = "/MapPage";
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  int? _selectedLineId;

  final Set<Polyline> _polylines = {};
  final Map<MarkerId, Marker> _markers = {};
  final List<_BusState> _buses = [];

  Timer? _animTimer;
  Timer? _locationTimer;

  BitmapDescriptor? _busIconBase;

  LatLng? _myLocation;
  double _myBearing = 0;
  static const MarkerId _myLocId = MarkerId('my_location');

  static const double _speed = 0.01;
  static const Duration _tickInterval = Duration(milliseconds: 200);

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(34.7308, 36.7090),
    zoom: 13,
  );

  final _rng = Random();

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadBaseIcon().then((_) {
      _buildPolylines();
      _initBuses();
    });
    _startLocationTracking();
  }

  @override
  void dispose() {
    _animTimer?.cancel();
    _locationTimer?.cancel();
    super.dispose();
  }

  // ── Asset icon ─────────────────────────────────────────────────────────────

  Future<void> _loadBaseIcon() async {
    _busIconBase = await _rotatedBitmap(
      Assets.icons.busMarker.path,
      0,
      size: 80,
    );
  }

  // ── Live location ──────────────────────────────────────────────────────────

  Future<void> _startLocationTracking() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.deniedForever) return;

    await _updateLocation();
    _locationTimer = Timer.periodic(
      const Duration(seconds: 3),
          (_) => _updateLocation(),
    );
  }

  Future<void> _updateLocation() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final newLatLng = LatLng(pos.latitude, pos.longitude);

      double newBearing = _myBearing;
      if (_myLocation != null) newBearing = _bearing(_myLocation!, newLatLng);

      final icon = await _rotatedBitmap(
        Assets.icons.arrow.path,
        newBearing,
        size: 128,
      );

      if (!mounted) return;
      setState(() {
        _myLocation = newLatLng;
        _myBearing = newBearing;
        _markers[_myLocId] = Marker(
          markerId: _myLocId,
          position: newLatLng,
          icon: icon,
          anchor: const Offset(0.5, 0.5),
          flat: true,
          zIndex: 10,
          infoWindow: const InfoWindow(title: 'موقعي'),
        );
      });
    } catch (_) {}
  }

  // ── Polylines ──────────────────────────────────────────────────────────────

  void _buildPolylines() {
    _polylines.clear();
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (_selectedLineId != null && line.id != _selectedLineId) continue;
      _polylines.add(
        Polyline(
          polylineId: PolylineId('line_${line.id}'),
          points: line.points,
          color: _lineColors[i % _lineColors.length],
          width: 4,
        ),
      );
    }
  }

  // ── Bus init ───────────────────────────────────────────────────────────────

  void _initBuses() {
    _buses.clear();
    for (int i = 0; i < lines.length; i++) {
      final n = lines[i].points.length;
      if (n < 2) continue;
      final mid = (n / 2).floor().clamp(0, n - 2);
      _buses.add(
        _BusState(
          lineIndex: i,
          busIndex: 0,
          info: _BusInfo.random(_rng),
          segmentIndex: 0,
          t: 0,
          forward: true,
        ),
      );
      _buses.add(
        _BusState(
          lineIndex: i,
          busIndex: 1,
          info: _BusInfo.random(_rng),
          segmentIndex: mid,
          t: 0.5,
          forward: false,
        ),
      );
    }
    _syncMarkersFromBuses();
    _startAnimation();
  }

  // ── Animation ──────────────────────────────────────────────────────────────

  void _startAnimation() {
    _animTimer?.cancel();
    _animTimer = Timer.periodic(_tickInterval, (_) => _tick());
  }

  void _tick() {
    if (!mounted) return;

    final updatedMarkers = <MarkerId, Marker>{..._markers};

    for (final bus in _buses) {
      final line = lines[bus.lineIndex];
      final pts = line.points;

      if (bus.forward) {
        bus.t += _speed;
        if (bus.t >= 1.0) {
          bus.t = 0;
          bus.segmentIndex++;
          if (bus.segmentIndex >= pts.length - 1) {
            bus.segmentIndex = pts.length - 2;
            bus.forward = false;
          }
        }
      } else {
        bus.t -= _speed;
        if (bus.t <= 0.0) {
          bus.t = 1.0;
          bus.segmentIndex--;
          if (bus.segmentIndex < 0) {
            bus.segmentIndex = 0;
            bus.forward = true;
          }
        }
      }

      final fromPt = pts[bus.segmentIndex];
      final toPt = pts[(bus.segmentIndex + 1).clamp(0, pts.length - 1)];
      final lat = fromPt.latitude + (toPt.latitude - fromPt.latitude) * bus.t;
      final lng =
          fromPt.longitude + (toPt.longitude - fromPt.longitude) * bus.t;
      final pos = LatLng(lat, lng);

      final visible = _selectedLineId == null || _selectedLineId == line.id;
      if (!visible) {
        updatedMarkers.remove(bus.markerId);
        continue;
      }

      updatedMarkers[bus.markerId] = _buildBusMarker(bus, pos);
    }

    setState(() {
      _markers
        ..clear()
        ..addAll(updatedMarkers);
    });
  }

  // ── Marker builder (shared between tick & sync) ────────────────────────────

  Marker _buildBusMarker(_BusState bus, LatLng pos) {
    final line = lines[bus.lineIndex];
    return Marker(
      markerId: bus.markerId,
      position: pos,
      icon: _busIconBase ?? BitmapDescriptor.defaultMarker,
      anchor: const Offset(0.5, 0.5),
      onTap: () => _showBusDialog(bus, line),
    );
  }

  void _syncMarkersFromBuses() {
    for (final bus in _buses) {
      final pts = lines[bus.lineIndex].points;
      final pos = pts[bus.segmentIndex.clamp(0, pts.length - 1)];
      _markers[bus.markerId] = _buildBusMarker(bus, pos);
    }
  }

  // ── Bus dialog ─────────────────────────────────────────────────────────────

  void _showBusDialog(_BusState bus, Line line) {
    final color = _lineColors[bus.lineIndex % _lineColors.length];

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header strip ──
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      line.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Details ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                children: [
                  _dialogRow(
                    Icons.confirmation_number,
                    'رقم الحافلة',
                    bus.info.busNumber,
                  ),
                  // const Divider(height: 20),
                  // _dialogRow(Icons.build, 'الصانع', bus.info.manufacturer),
                  const Divider(height: 20),
                  _dialogRow(
                    Icons.event_seat,
                    'المقاعد',
                    '${bus.info.seats} مقعد',
                  ),
                  const Divider(height: 20),
                  _dialogRow(
                    Icons.attach_money,
                    'الأجرة',
                    '${line.amount} ل.س',
                  ),
                ],
              ),
            ),

            // ── Close button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'إغلاق',
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }

  // ── Filter ─────────────────────────────────────────────────────────────────

  void _onChipSelected(int? lineId) {
    setState(() {
      _selectedLineId = lineId;
      _buildPolylines();
      _syncVisibleMarkers();
    });
  }

  void _syncVisibleMarkers() {
    final updated = <MarkerId, Marker>{};
    if (_markers.containsKey(_myLocId)) updated[_myLocId] = _markers[_myLocId]!;
    for (final entry in _markers.entries) {
      if (entry.key == _myLocId) continue;
      final bus = _buses.firstWhere(
            (b) => b.markerId == entry.key,
        orElse: () => _buses.first,
      );
      final visible =
          _selectedLineId == null || lines[bus.lineIndex].id == _selectedLineId;
      if (visible) updated[entry.key] = entry.value;
    }
    _markers
      ..clear()
      ..addAll(updated);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الخريطة'), centerTitle: true),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCamera,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            rotateGesturesEnabled: false,
            polylines: _polylines,
            markers: Set<Marker>.of(_markers.values),
            onMapCreated: (c) => _mapController = c,
          ),

          Positioned(top: 12, left: 0, right: 0, child: _buildFilterChips()),

          Positioned(
            bottom: 24,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              tooltip: 'موقعي',
              onPressed: _goToMyLocation,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  void _goToMyLocation() {
    if (_myLocation == null || _mapController == null) return;
    _mapController!.animateCamera(CameraUpdate.newLatLngZoom(_myLocation!, 15));
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              label: const Text('الكل'),
              selected: _selectedLineId == null,
              onSelected: (_) => _onChipSelected(null),
              selectedColor: Colors.blueAccent.withOpacity(0.85),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: _selectedLineId == null ? Colors.white : null,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white.withOpacity(0.92),
              elevation: 2,
            ),
          ),
          for (int i = 0; i < lines.length; i++) ...[
            const SizedBox(width: 8),
            FilterChip(
              label: Text(lines[i].name),
              selected: _selectedLineId == lines[i].id,
              onSelected: (_) => _onChipSelected(lines[i].id),
              selectedColor: _lineColors[i % _lineColors.length].withOpacity(
                0.85,
              ),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: _selectedLineId == lines[i].id ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.white.withOpacity(0.92),
              elevation: 2,
            ),
          ],
        ],
      ),
    );
  }
}
