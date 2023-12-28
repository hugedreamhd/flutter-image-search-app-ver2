import 'package:image_search_app_01/data/data_source/pixabay_api.dart';
import 'package:image_search_app_01/data/mapper/image_mapper.dart';
import 'package:image_search_app_01/data/model/image_item.dart';

abstract interface class ImageItemRepository {
  Future<List<ImageItem>> getImageItems(String query);
}

class PixabayImageItemRepository implements ImageItemRepository {
  final _api = PixabayApi();

  @override
  Future<List<ImageItem>> getImageItems(String query) async {
   final dto = await _api.getImageResult(query);

   if (dto.hits == null) {
     return [];
   }
   return dto.hits!.map((e) => e.toImageItem()).toList();
  }
}

// class MockImageItemRepository {
//
//
//   Future<List<ImageItem>> getImageItems(String query) async {
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (query == 'yellow flower') {
//       return [
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2018/01/05/16/24/rose-3063284_150.jpg',
//             tags: ''),
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2015/08/13/20/06/flower-887443_150.jpg',
//             tags: ''),
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2017/05/08/13/15/spring-bird-2295434_150.jpg',
//             tags: ''),
//       ];
//     } else {
//       return [
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2015/03/14/19/45/suit-673697_150.jpg',
//             tags: ''),
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2015/08/20/20/07/cereal-898073_150.jpg',
//             tags: ''),
//         ImageItem(
//             imageUrl:
//             'https://cdn.pixabay.com/photo/2016/01/03/17/59/bananas-1119790_150.jpg',
//             tags: ''),
//       ];
//     }
//   }
// }
