// Deprecated wrapper to preserve existing public API. Use
// `CommonUniversalImage` from `common_universal_image.dart` instead.
import 'common_universal_image.dart';

@Deprecated('Use CommonUniversalImage from common_universal_image.dart instead')
class UniversalImage extends CommonUniversalImage {
  const UniversalImage({
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
