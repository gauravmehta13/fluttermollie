/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/applepay.png
  AssetGenImage get applepay => const AssetGenImage('assets/icons/applepay.png');

  /// File path: assets/icons/ideal.png
  AssetGenImage get ideal => const AssetGenImage('assets/icons/ideal.png');

  /// File path: assets/icons/klarna-rechnung-alt.png
  AssetGenImage get klarnaRechnungAlt => const AssetGenImage('assets/icons/klarna-rechnung-alt.png');

  /// File path: assets/icons/klarna-sofort.png
  AssetGenImage get klarnaSofort => const AssetGenImage('assets/icons/klarna-sofort.png');

  /// File path: assets/icons/mastercard.png
  AssetGenImage get mastercard => const AssetGenImage('assets/icons/mastercard.png');

  /// File path: assets/icons/paypal.png
  AssetGenImage get paypal => const AssetGenImage('assets/icons/paypal.png');

  /// File path: assets/icons/sepa.png
  AssetGenImage get sepa => const AssetGenImage('assets/icons/sepa.png');

  /// List of all assets
  List<AssetGenImage> get values => [applepay, ideal, klarnaRechnungAlt, klarnaSofort, mastercard, paypal, sepa];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
