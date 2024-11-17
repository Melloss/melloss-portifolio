/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/dart_logo.png
  AssetGenImage get dartLogo =>
      const AssetGenImage('assets/images/dart_logo.png');

  /// File path: assets/images/figma_logo.png
  AssetGenImage get figmaLogo =>
      const AssetGenImage('assets/images/figma_logo.png');

  /// File path: assets/images/firefox_logo.png
  AssetGenImage get firefoxLogo =>
      const AssetGenImage('assets/images/firefox_logo.png');

  /// File path: assets/images/folder_icon.png
  AssetGenImage get folderIcon =>
      const AssetGenImage('assets/images/folder_icon.png');

  /// File path: assets/images/github_logo.png
  AssetGenImage get githubLogo =>
      const AssetGenImage('assets/images/github_logo.png');

  /// File path: assets/images/linkedIn_logo.png
  AssetGenImage get linkedInLogo =>
      const AssetGenImage('assets/images/linkedIn_logo.png');

  /// File path: assets/images/melloss_pic.jpg
  AssetGenImage get mellossPic =>
      const AssetGenImage('assets/images/melloss_pic.jpg');

  /// File path: assets/images/terminal.png
  AssetGenImage get terminal =>
      const AssetGenImage('assets/images/terminal.png');

  /// File path: assets/images/ubuntu_wallpaper.png
  AssetGenImage get ubuntuWallpaper =>
      const AssetGenImage('assets/images/ubuntu_wallpaper.png');

  /// File path: assets/images/wikipedia_logo.png
  AssetGenImage get wikipediaLogo =>
      const AssetGenImage('assets/images/wikipedia_logo.png');

  /// File path: assets/images/youtube_logo.png
  AssetGenImage get youtubeLogo =>
      const AssetGenImage('assets/images/youtube_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        dartLogo,
        figmaLogo,
        firefoxLogo,
        folderIcon,
        githubLogo,
        linkedInLogo,
        mellossPic,
        terminal,
        ubuntuWallpaper,
        wikipediaLogo,
        youtubeLogo
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/am.json
  String get am => 'assets/translations/am.json';

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// List of all assets
  List<String> get values => [am, enUS];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
