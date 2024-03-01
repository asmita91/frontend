import 'package:crimson_cycle/config/constants/hive_table_constant.dart';
import 'package:crimson_cycle/features/auth/data/model/auth_hive_model.dart';
import 'package:crimson_cycle/features/category/data/model/category_hive_model.dart';
import 'package:crimson_cycle/features/healthInfo/data/model/health_info_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(HealthInfoHiveModelAdapter());
  }

  // ======================== User Queries ========================
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }
  // for category

  // ======================== Categories Queries ========================
  Future<void> addCategory(CategoryHiveModel category) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(category.categoryId, category);
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    var categories = box.values.toList();
    box.close();
    return categories;
  }
  // ======================== HealthInfo Queries ========================

  Future<void> addOrUpdateHealthInfo(
      String userId, HealthInfoHiveModel healthInfo) async {
    var box = await Hive.openBox<HealthInfoHiveModel>(
        HiveTableConstant.healthInfoBox);
    String uniqueKey = '$userId-${healthInfo.id}';
    await box.put(uniqueKey, healthInfo);
  }

  Future<HealthInfoHiveModel?> getHealthInfoById(String id) async {
    var box = await Hive.openBox<HealthInfoHiveModel>(
        HiveTableConstant.healthInfoBox);
    HealthInfoHiveModel? healthInfo = box.get(id);
    await box.close();
    return healthInfo;
  }

  // ======================== Delete All Data ========================
  Future<void> deleteAllData() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.clear();
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);

    await Hive.deleteFromDisk();
  }
}
