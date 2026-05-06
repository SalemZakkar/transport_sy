// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/Cairo-Black.ttf
  String get cairoBlack => 'assets/font/Cairo-Black.ttf';

  /// File path: assets/font/Cairo-Bold.ttf
  String get cairoBold => 'assets/font/Cairo-Bold.ttf';

  /// File path: assets/font/Cairo-ExtraBold.ttf
  String get cairoExtraBold => 'assets/font/Cairo-ExtraBold.ttf';

  /// File path: assets/font/Cairo-ExtraLight.ttf
  String get cairoExtraLight => 'assets/font/Cairo-ExtraLight.ttf';

  /// File path: assets/font/Cairo-Light.ttf
  String get cairoLight => 'assets/font/Cairo-Light.ttf';

  /// File path: assets/font/Cairo-Medium.ttf
  String get cairoMedium => 'assets/font/Cairo-Medium.ttf';

  /// File path: assets/font/Cairo-Regular.ttf
  String get cairoRegular => 'assets/font/Cairo-Regular.ttf';

  /// File path: assets/font/Cairo-SemiBold.ttf
  String get cairoSemiBold => 'assets/font/Cairo-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    cairoBlack,
    cairoBold,
    cairoExtraBold,
    cairoExtraLight,
    cairoLight,
    cairoMedium,
    cairoRegular,
    cairoSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow.png
  AssetGenImage get arrow => const AssetGenImage('assets/icons/arrow.png');

  /// File path: assets/icons/bus-marker.png
  AssetGenImage get busMarker =>
      const AssetGenImage('assets/icons/bus-marker.png');

  /// File path: assets/icons/example.svg
  SvgGenImage get example => const SvgGenImage('assets/icons/example.svg');

  /// List of all assets
  List<dynamic> get values => [arrow, busMarker, example];
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/fail.mp3
  String get fail => 'assets/sounds/fail.mp3';

  /// File path: assets/sounds/success.mp3
  String get success => 'assets/sounds/success.mp3';

  /// List of all assets
  List<String> get values => [fail, success];
}

class Assets {
  const Assets._();

  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
