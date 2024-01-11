import 'package:flutter/material.dart';
import 'package:kompen/constants.dart';

import 'widgets.dart';

class RoundedInputField extends StatelessWidget {
  RoundedInputField(
      {Key? key,
      this.hintText,
      this.validator,
      this.icon = Icons.person,
      this.isObscure = false,
      this.hasSuffix = false,
      this.onPressed,
      required this.textInputType,
      required this.controller,
      required this.textInputAction})
      : super(key: key);

  final String? hintText, validator;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool isObscure;
  final bool hasSuffix;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        controller: controller,
        obscureText: isObscure,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            suffixIcon: hasSuffix
                ? IconButton(
                    onPressed: onPressed,
                    color: kPrimaryColor,
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            hintText: hintText,
            labelText: validator,
            hintStyle: const TextStyle(fontFamily: 'OpenSans'),
            border: InputBorder.none),
        validator: (value) {
          if (value!.isEmpty) {
            return "{$validator} Masih Kosong";
          }
          return null;
        },
      ),
    );
  }
}
