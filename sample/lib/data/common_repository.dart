import 'package:flutter_blood_belfry/constant/app_constant.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///通用 请求
class CommonRepository {
  ///检查网络是否可用--真正可用
  static Future<bool> checkNetwork() async {
    Response response = await FastNetwork.getInstance().get(
      AppConstant.checkNetworkPath,
    );
    return null != response.data;
  }

}
