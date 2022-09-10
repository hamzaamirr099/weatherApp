import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage({required String message})
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      // backgroundColor: toastColor,
      // textColor: Colors.white,
      fontSize: 16.0
  );

}