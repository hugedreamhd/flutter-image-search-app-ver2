import 'package:image_search_app_01/data/dto/Pixabay_dto.dart';
import 'package:image_search_app_01/data/model/image_item.dart';

extension DtoToModel on Hits {
  ImageItem toImageItem() {
    return ImageItem(
      imageUrl: previewURL ??
          'data:image/jpeg;base64,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',
      tags: tags ?? '',
    );
  }
}
