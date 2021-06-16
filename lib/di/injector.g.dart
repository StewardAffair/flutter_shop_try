// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => CategoryBloc(c<FoodRepository>()));
    container.registerFactory((c) => FoodRepository(c<RestClient>()));
    container.registerFactory((c) => RestClient(c<Dio>()));
  }
}
