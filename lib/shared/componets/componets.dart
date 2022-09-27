
import 'package:firebase1/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


PreferredSizeWidget defaultAppar({
required BuildContext context,
  String? title,
  Icon? leading ,
  VoidCallback? onPressed,
  List<Widget>? action ,
}) => AppBar(
  title: Text(
    title??'',
  ),
  actions: action,
  leading: IconButton(
    onPressed:onPressed,
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
);

Widget defaultTextFormField({
  required TextEditingController controller,
  required ValueChanged? submitted,
  required FormFieldValidator? validator,
  required String? lapel,
  IconButton? suffixIcon,
  bool? notShowPassword ,
  Icon? prefixIcon,
  TextInputType? keyboardType,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: submitted,
      keyboardType: keyboardType,
      obscureText: notShowPassword == true ? true : false ,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(
          lapel.toString(),
        ),
        border: const OutlineInputBorder(),
      ),
    );


Widget defaultMaterialButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    MaterialButton(
      onPressed: onPressed,
      color: Colors.blue,
      minWidth: double.infinity,
      height: 50,
      child: Text(
        text.toString(),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );


Widget defaultTextButton(
    {required String? text, required VoidCallback? onPressed}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toString(),
      ),
    );


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String message,
  required ToastStates toastState,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColorToast(toastState),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color choseColorToast(ToastStates state) {
  Color? color;

  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.SUCCESS:
      color = Colors.blue;
      break;

    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }

  return color;
}
