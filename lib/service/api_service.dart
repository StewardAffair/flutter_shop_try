import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dart:io';
import 'package:http_parser/http_parser.dart' show MediaType;

part 'api_service.g.dart';

@RestApi(baseUrl: "https://my-json-server.typicode.com/StewardAffair/fake_repo/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/categoties")
  Future<List<Category>> getCategories();
}

@JsonSerializable()
class Category {
  String id;
  String name;
  List<Food> items;

  Category({this.id, this.name, this.items});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Food {
  String id;
  String name;
  String picture;

  Food(this.id, this.name, this.picture);

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}