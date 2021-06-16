
import 'package:cooker/service/api_service.dart';

class FoodRepository {

  final RestClient restApi;

  FoodRepository(this.restApi);

  Future<List<Category>> getCategories() {
    return restApi.getCategories();
  }
}