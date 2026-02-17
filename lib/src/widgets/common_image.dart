// Backwards-compatible wrapper for the new `CommonUniversalImage`.
// This keeps the old symbol `CommonImage` available while the
// package transitions to the preferred `CommonUniversalImage` API.
import 'common_universal_image.dart';

/// Deprecated alias. Use `CommonUniversalImage` instead.
@Deprecated('Use CommonUniversalImage from common_universal_image.dart instead')
class CommonImage extends CommonUniversalImage {
  const CommonImage({
    super.key,
    super.imageUrl,
    super.assetPath,
    super.file,
    super.imageProvider,
    super.height,
    super.width,
    super.fit,
    super.isShowLoader,
    super.borderRadius,
    super.alignment,
    super.errorWidget,
  });
}
