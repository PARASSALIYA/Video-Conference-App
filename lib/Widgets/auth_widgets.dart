import 'package:flutter/material.dart';
import 'package:video_conference_app/constants/colors.dart';
import 'package:video_conference_app/constants/validations.dart';

Widget customTextField(
  TextEditingController controller,
  String text,
  String iconPath, {
  bool isPasswordField = false,
  bool isNameField = false,
  bool isEmailField = false,
  String errorText = "",
  Widget? suffixIcon,
}) {
  RegExp regex = RegExp("");
  if (isNameField) {
    regex = nameValidationRegex;
  } else if (isEmailField) {
    regex = emailValidationRegex;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 45,
              minHeight: 45,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                color: primaryColor,
                image: AssetImage(
                  iconPath,
                ),
              ),
            ),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: isPasswordField,
          validator: (value) {
            RegExp nameRegExp = regex;
            if (value!.isEmpty) {
              return 'Please enter valid information';
            } else if (!nameRegExp.hasMatch(value)) {
              return errorText;
            }
            return null;
          },
        ),
      ),
    ],
  );
}

Widget authButton(
    String buttonName, void Function() ontap, bool loadingIndicator) {
  return InkWell(
    onTap: ontap,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: (loadingIndicator)
          ? const CircularProgressIndicator.adaptive()
          : Text(
              buttonName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
    ),
  );
}

PreferredSizeWidget customAppbar(
    BuildContext context, String text, Widget gotoWidget, String gotoText) {
  return AppBar(
    title: Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    actions: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => gotoWidget),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        child: Text(
          gotoText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      const SizedBox(width: 20),
    ],
  );
}
