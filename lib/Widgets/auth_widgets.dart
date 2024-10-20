import 'package:flutter/material.dart';
import 'package:video_conference_app/constants/colors.dart';
import 'package:video_conference_app/constants/validations.dart';

Widget customTextField(TextEditingController controller, String iconPath,
    {Widget? emailOrNumberWidget,
    String? text,
    bool isPasswordField = false,
    bool viewPassword = false,
    bool isNameField = false,
    bool isEmailField = false,
    bool isNumberField = false,
    bool isOtpField = false,
    String errorText = "",
    Widget? suffixIcon,
    String? hintText}) {
  RegExp regex = RegExp("");
  if (isNameField) {
    regex = nameValidationRegex;
  }
  if (isEmailField) {
    regex = emailValidationRegex;
  }
  if (isNumberField) {
    regex = phoneNumValidationRegex;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      (isEmailField || isNumberField)
          ? emailOrNumberWidget ?? const SizedBox()
          : Text(
              text ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 20),
        child: TextFormField(
          controller: controller,
          keyboardType: (isEmailField)
              ? TextInputType.emailAddress
              : (isPasswordField)
                  ? TextInputType.visiblePassword
                  : (isNameField)
                      ? TextInputType.name
                      : (isNumberField)
                          ? TextInputType.number
                          : null,
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
              hintText: hintText ?? ""),
          obscureText: viewPassword,
          validator: (value) {
            if (!isOtpField) {
              RegExp nameRegExp = regex;
              if (value!.isEmpty) {
                return 'Please enter valid information';
              } else if (!nameRegExp.hasMatch(value)) {
                return errorText;
              }
            }
            return null;
          },
        ),
      ),
    ],
  );
}

Widget emailOrNumberOption({
  required void Function(bool) onClickEmail,
  required void Function(bool) onClickNumber,
  required bool isSelectedEmail,
  required bool isSelectedNumber,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ChoiceChip(
        label: const Text("Email"),
        selected: isSelectedEmail,
        onSelected: onClickEmail,
      ),
      const SizedBox(width: 10),
      ChoiceChip(
        label: const Text("Phone Number"),
        selected: isSelectedNumber,
        onSelected: onClickNumber,
      ),
    ],
  );
}

Widget sendOtpWidget(String text, void Function() onTap, bool isLoading) {
  return Container(
    margin: const EdgeInsets.only(
      top: 5,
      bottom: 5,
      right: 5,
    ),
    child: ElevatedButton(
      onPressed: onTap,
      child: isLoading
          ? const CircularProgressIndicator.adaptive()
          : Text(
              text,
              style: TextStyle(color: primaryColor),
            ),
    ),
  );
}

Widget authButton(
  String buttonName,
  void Function() ontap,
  bool loadingIndicator,
) {
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
  BuildContext context,
  String text,
  Widget gotoWidget,
  String gotoText,
) {
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
