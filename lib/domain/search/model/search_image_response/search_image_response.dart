import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'search_image_response.g.dart';

@JsonSerializable()
class SearchImageResponse {
  List<SearchResult>? results;

  SearchImageResponse({
    this.results,
  });

  factory SearchImageResponse.fromJson(Map<String, dynamic> json) {
    return _$SearchImageResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchImageResponseToJson(this);
}
