import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/vehicle/data/model/vehicle.dart';

class Line {
  final int id;
  final String name;
  final int amount;
  final List<LatLng> points;

  Line({
    required this.id,
    required this.name,
    this.points = const [],
    required this.amount,
  });

  @override
  String toString() =>
      'Line($name, ${points.length} stops)';
}

/// ─── Real bus lines in Homs, Syria ───────────────────────────────────────────
///
/// Line 1: الوعر ← وسط المدينة (Al-Waer ↔ City Centre)
///   Starts at حي الوعر (west, ~36.680E) and heads east along the main
///   Damascus road through حي الإنشاءات → ساحة الساعة (Clock Square) → وسط المدينة
///
/// Line 2: الزهراء ← وسط المدينة (Al-Zahra ↔ City Centre)
///   Starts at حي الزهراء (east, ~36.760E) and heads west through
///   جب الجندلي → الخالدية → ساحة الساعة
///
/// Line 3: عكرمة ← وسط المدينة (Ekrama ↔ City Centre)
///   Starts at حي عكرمة (south, ~34.700N) and heads north through
///   النزهة → باب السباع → وسط المدينة

final List<Line> lines = [
  // ── Line 1: الوعر ↔ وسط المدينة ─────────────────────────────────────────
  Line(
    id: 1,
    name: 'الوعر - وسط المدينة',
    amount: 1000,
    points: [
      LatLng(34.7285, 36.6810), // حي الوعر (start, west)
      LatLng(34.7280, 36.6870), // الوعر / شارع الأهرام
      LatLng(34.7278, 36.6930), // مدخل الإنشاءات
      LatLng(34.7275, 36.6985), // حي الإنشاءات
      LatLng(34.7272, 36.7040), // شارع المحطة
      LatLng(34.7270, 36.7085), // الحمراء
      LatLng(34.7268, 36.7120), // القصور - شارع الجمهورية
      LatLng(34.7265, 36.7150), // ساحة الشهداء
      LatLng(34.7262, 36.7175), // شارع الدبلان
      LatLng(34.7260, 36.7195), // ساحة الساعة (Clock Square - city centre)
    ],
  ),

  // ── Line 2: الزهراء ↔ وسط المدينة ──────────────────────────────────────
  Line(
    id: 2,
    name: 'الزهراء - وسط المدينة',
    amount: 5000,
    points: [
      LatLng(34.7310, 36.7610), // حي الزهراء (start, east)
      LatLng(34.7305, 36.7560), // الزهراء الغربية
      LatLng(34.7298, 36.7510), // جب الجندلي الشرقي
      LatLng(34.7290, 36.7460), // جب الجندلي
      LatLng(34.7282, 36.7410), // طريق الخالدية الشرقي
      LatLng(34.7275, 36.7365), // حي الخالدية
      LatLng(34.7270, 36.7320), // الخالدية الغربية
      LatLng(34.7265, 36.7280), // شارع خالد بن الوليد
      LatLng(34.7262, 36.7240), // جامع خالد بن الوليد
      LatLng(34.7260, 36.7195), // ساحة الساعة (City Centre)
    ],
  ),

  // ── Line 3: عكرمة ↔ وسط المدينة ────────────────────────────────────────
  Line(
    id: 3,
    name: 'عكرمة - وسط المدينة',
    amount: 40000,
    points: [
      LatLng(34.7020, 36.7210), // حي عكرمة الجنوبية (start, south)
      LatLng(34.7060, 36.7210), // عكرمة القديمة
      LatLng(34.7100, 36.7208), // شارع الحضارة
      LatLng(34.7140, 36.7205), // حي النزهة الجنوبي
      LatLng(34.7175, 36.7205), // حي النزهة
      LatLng(34.7205, 36.7202), // باب السباع
      LatLng(34.7225, 36.7200), // المريجة
      LatLng(34.7240, 36.7198), // شارع قوتلي
      LatLng(34.7252, 36.7196), // ساحة باب تدمر
      LatLng(34.7260, 36.7195), // ساحة الساعة (City Centre)
    ],
  ),
];