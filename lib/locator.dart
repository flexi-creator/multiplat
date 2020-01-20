import 'package:get_it/get_it.dart';
import 'package:multiplat/core/service/data_item_service.dart';
import 'package:multiplat/core/service/pane_interaction_service.dart';
import 'package:multiplat/core/util/multiplat_shared_prefs.dart';
import 'package:multiplat/core/viewmodel/chart_viewmodel.dart';
import 'package:multiplat/core/viewmodel/item_detail_viewmodel.dart';
import 'package:multiplat/core/viewmodel/items_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  // Utilities
  locator.registerSingleton(MultiplatSharedPrefs());

  // Services
  locator.registerSingleton(DataItemService());
  locator.registerSingleton(PaneInteractionService());

  // View models
  locator.registerFactory(() => ItemsViewModel());
  locator.registerFactory(() => ChartViewModel());
  locator.registerFactory(() => ItemDetailViewModel());
}
