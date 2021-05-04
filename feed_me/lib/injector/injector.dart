import 'package:feed_me/service/food_service.dart';
import 'package:feed_me/view/side_menu/side_menu.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void setup(){
  injector.registerLazySingleton(() => FoodService());
  injector.registerLazySingleton(() => SideMenu());
}