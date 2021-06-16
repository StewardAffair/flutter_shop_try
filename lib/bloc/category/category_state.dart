import 'package:cooker/service/api_service.dart';

class CategoryState {
  CategoryState();
}

class CategoryStateLoading extends CategoryState {}

class CategoryStateData extends CategoryState {
  final List<Category> categories;

  CategoryStateData(this.categories);
}

class CategoryStateError extends CategoryState {
  final Error error;

  CategoryStateError(this.error);

}
