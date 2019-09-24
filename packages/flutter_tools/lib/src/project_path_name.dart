import 'dart:convert';

import 'package:flutter_tools/src/base/common.dart';
import 'package:flutter_tools/src/base/file_system.dart';

class AndroidProjectPathName {
  factory AndroidProjectPathName() => _getInstance();

  static AndroidProjectPathName get instance => _getInstance();

  static AndroidProjectPathName _instance;

  //默认值，选择flutter原来的值：app
  String _projectName = 'app';

  AndroidProjectPathName._internal() {}

  Future<void> init(Directory androidRoot) async {
    if (!await androidRoot.exists()) {
      throwToolExit("cant find android Root!!!");
    }

    File fp = fs.file(fs.path.join(androidRoot.path, "fbConfig.project.json"));
    String cont = await fp.readAsString(encoding: utf8);
    Map map = jsonDecode(cont);
    if (map.containsKey('appName')) {
      this._projectName = map['appName'];
    }
  }

  String get projectName {
    return _projectName;
  }

  static AndroidProjectPathName _getInstance() {
    _instance ??= AndroidProjectPathName();
    return _instance;
  }
}
