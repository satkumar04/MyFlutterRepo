// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchImageResponse _$SearchImageResponseFromJson(Map<String, dynamic> json) =>
    SearchImageResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchImageResponseToJson(
        SearchImageResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
