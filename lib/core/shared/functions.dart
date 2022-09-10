import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage({required String message})
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
  );

}