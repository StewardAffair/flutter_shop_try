
import 'package:cooker/bloc/category/category_bloc.dart';
import 'package:cooker/repository/food_repo.dart';
import 'package:cooker/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(CategoryBloc)
  @Register.factory(FoodRepository)
  @Register.factory(RestClient)
  void configure();
}

class Di {
  static void setup() {
    final kiwiContainer = KiwiContainer();
    kiwiContainer..registerInstance(Dio());
    var injector = _$Injector();
    injector.configure();
  }
}