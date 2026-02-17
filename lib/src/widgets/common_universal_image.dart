// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Central image widget for the `common_ui` package.
/// Supports multiple sources with clear precedence and consistent
/// placeholder/error behavior.
class CommonUniversalImage extends StatefulWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? file;
  final ImageProvider? imageProvider;
  final double height;
  final double width;
  final BoxFit fit;
  final bool isShowLoader;
  final double borderRadius;
  final Alignment? alignment;
  final Widget? errorWidget;

  const CommonUniversalImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.file,
    this.imageProvider,
    this.height = 100,
    this.width = 100,
    this.fit = BoxFit.cover,
    this.isShowLoader = true,
    this.borderRadius = 12,
    this.alignment,
    this.errorWidget,
  });

  @override
  State<CommonUniversalImage> createState() => _CommonUniversalImageState();
}

class _CommonUniversalImageState extends State<CommonUniversalImage> {
  late BorderRadius _cachedBorderRadius;
  late Widget? _cachedPlaceholder;

  @override
  void initState() {
    super.initState();
    _updateCache();
  }

  @override
  void didUpdateWidget(CommonUniversalImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.borderRadius != widget.borderRadius ||
        oldWidget.isShowLoader != widget.isShowLoader) {
      _updateCache();
    }
  }

  void _updateCache() {
    _cachedBorderRadius = BorderRadius.circular(widget.borderRadius);
    _cachedPlaceholder = widget.isShowLoader ? _buildPlaceholder() : null;
  }

  Widget? _buildPlaceholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: _cachedBorderRadius,
        color: Colors.grey.shade200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.imageProvider;
    if (provider != null) return _buildFromImageProvider(provider);

    if (widget.file != null) {
      return ClipRRect(
        borderRadius: _cachedBorderRadius,
        child: Image.file(
          widget.file!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          alignment: widget.alignment ?? Alignment.center,
          errorBuilder: (context, error, stackTrace) => _errorChild(),
        ),
      );
    }

    if (widget.assetPath != null) {
      return ClipRRect(
        borderRadius: _cachedBorderRadius,
        child: Image.asset(
          widget.assetPath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          alignment: widget.alignment ?? Alignment.center,
          errorBuilder: (context, error, stackTrace) => _errorChild(),
        ),
      );
    }

    final imageUrl = widget.imageUrl ?? '';
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: ImageCacheManager(),
      fadeInDuration: Duration.zero,
      memCacheWidth: widget.width.toInt(),
      memCacheHeight: widget.height.toInt(),
      imageBuilder: (context, imageProvider) {
        return ClipRRect(
          borderRadius: _cachedBorderRadius,
          child: Image(
            image: imageProvider,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            alignment: widget.alignment ?? Alignment.center,
          ),
        );
      },
      placeholder: _cachedPlaceholder != null
          ? (context, url) => _cachedPlaceholder!
          : (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: widget.errorWidget ??
                    Image.asset(
                      'assets/images/placeholder.webp',
                      package: 'common_ui',
                      height: widget.height,
                      width: widget.width,
                      fit: widget.fit,
                      alignment: widget.alignment ?? Alignment.center,
                    ),
              ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: widget.errorWidget ?? _errorChild(),
      ),
    );
  }

  Widget _buildFromImageProvider(ImageProvider provider) {
    return ClipRRect(
      borderRadius: _cachedBorderRadius,
      child: Image(
        image: provider,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        alignment: widget.alignment ?? Alignment.center,
        errorBuilder: (context, error, stackTrace) => _errorChild(),
      ),
    );
  }

  Widget _errorChild() {
    return widget.errorWidget ??
        Image.asset(
          'assets/images/placeholder.webp',
          package: 'common_ui',
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          alignment: widget.alignment ?? Alignment.center,
        );
  }
}

class ImageCacheManager extends CacheManager {
  static const key = 'productImageCache';
  static final ImageCacheManager _instance = ImageCacheManager._();

  factory ImageCacheManager() {
    return _instance;
  }

  ImageCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 30),
            maxNrOfCacheObjects: 500,
          ),
        );

}
