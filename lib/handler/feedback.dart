import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supapet/config.dart';

class FeedbackHandler {
  static void showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: kCardColor,
      fontSize: kFontSize,
      textColor: kFontColor,
      gravity: ToastGravity.CENTER,
    );
  }

  static void showLoading() {
    EasyLoading.show();
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }
}
