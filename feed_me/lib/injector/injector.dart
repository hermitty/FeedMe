import 'package:feed_me/client/api_client.dart';
import 'package:feed_me/service/food_service.dart';
import 'package:feed_me/service/tag_service.dart';
import 'package:feed_me/view/side_menu/side_menu.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void setup(){
  injector.registerLazySingleton(() => ApiClient());
  injector.registerLazySingleton(() => FoodService());
  injector.registerLazySingleton(() => TagService());
  injector.registerLazySingleton(() => SideMenu());
}