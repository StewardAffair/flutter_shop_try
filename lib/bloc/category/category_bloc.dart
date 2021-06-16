

import 'package:bloc/bloc.dart';
import 'package:cooker/bloc/category/category_event.dart';
import 'package:cooker/bloc/category/category_state.dart';
import 'package:cooker/repository/food_repo.dart';
import 'package:cooker/service/api_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final FoodRepository foodRepository;

  CategoryBloc(this.foodRepository) : super(CategoryStateLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    switch(event) {
      case CategoryEvent.start:
        try {
            final List<Category> categories = await foodRepository.getCategories();
            yield CategoryStateData(categories);
        } catch(error) {
          yield CategoryStateError(error);
        }
        break;
    }
  }

}