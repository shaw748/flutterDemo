import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutterdemo/common/utils/log_utils.dart';
import 'package:flutterdemo/routes/app_routes.dart';

import '../controllers/user.dart';

/// 登录认证
class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    logger.d("是否登录${UserStore.to.isLogin}");
    if (UserStore.to.isLogin) {
      return null;
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
