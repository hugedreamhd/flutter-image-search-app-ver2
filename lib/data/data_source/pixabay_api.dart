import 'dart:convert';

import 'package:image_search_app_01/data/dto/Pixabay_dto.dart';

class PixabayApi {

  Future<PixabayDto> getImageResult(String query) async {
    final response =
    await http.get(Uri.parse('https://pixabay.com/api/?key=41486583-a8bebcb5b3331340ec13d3579&q=$query&image_type=photo&pretty=true'));
    return PixabayDto.fromJson(jsonDecode(response.body));
  }
}