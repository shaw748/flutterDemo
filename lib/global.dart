import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutterdemo/data/provider/api/api_client.dart';
import 'package:path_provider/path_provider.dart';

import 'common/constants.dart';
import 'data/provider/api/api_config.dart';
import 'data/repositories/flutterdemo_repository.dart';
import 'getx/controllers/user.dart';
import 'getx/services/storage_service.dart';

/// 初始化配置,可供全局使用
class Global {
  // 初始化
  static Future<void> init() async {

    //强制竖屏
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    //创建缓存目录
    String? cachePath;
    if (!GetPlatform.isWeb) {
      // 当前文件路径不支持web端
      var cache = await getTemporaryDirectory();
      cachePath = cache.path;
    }
    //网络组件初始化
    ApiConfig config = ApiConfig(
        showLog:false,
        baseUrl: Constants.BASE_URL,
        headers: {"course-flag": Constants.COURSE_FLAG},
        cachePath: cachePath);
    ApiClient client = ApiClient(config);
    //创建数据仓库
    Get.lazyPut(() => BiliRepository(client));
    //持久化存储服务
    await Get.putAsync<StorageService>(() => StorageService().init());
    //初始化用户配置
    Get.lazyPut<UserStore>(() => UserStore());
  }
}
