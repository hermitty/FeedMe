import 'package:feed_me/service/food_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void setup(){
  injector.registerLazySingleton(() => FoodService());
}