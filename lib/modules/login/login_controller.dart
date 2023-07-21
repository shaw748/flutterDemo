import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutterdemo/routes/app_routes.dart';

import '../../common/utils/loading.dart';
import '../../getx/controllers/user.dart';

class LoginController extends GetxController {
  String? userName;
  String? password;

  final protect = false.obs; //是否保护
  final loginEnable = false.obs; //登录按钮是否可用

  void checkInput() {
    bool enable;
    if (GetUtils.isNullOrBlank(userName)! ||
        GetUtils.isNullOrBlank(password)!) {
      enable = false;
    } else {
      enable = true;
    }
    loginEnable.value = enable;
  }

  VoidCallback? loginClick() {
    UserStore.to.saveLogin();
    AppRoutes.toMain();
  }
}
