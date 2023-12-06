
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  bool isPassword = false,
  ValueChanged? onChanged,
  GestureTapCallback? onTap,
  FormFieldValidator<String>? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  // bool underLine = true,
  // required var context,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


