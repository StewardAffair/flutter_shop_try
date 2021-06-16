import 'package:cooker/service/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food food;

  FoodDetailsScreen(this.food);

  @override
  FoodDetailsScreenState createState() => FoodDetailsScreenState(food);
}

class FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final Food food;

  FoodDetailsScreenState(this.food);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: Center(
      child: Text(food.name),
    ));
  }
}
