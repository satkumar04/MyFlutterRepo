import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'discover_response.g.dart';

@JsonSerializable()
class DiscoverResponse {
  int? page;
  List<Result>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  DiscoverResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory DiscoverResponse.fromJson(Map<String, dynamic> json) {
    return _$DiscoverResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DiscoverResponseToJson(this);
}
