// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required String? Function(dynamic value) validatorValue,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: ,
      decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint),
    );
  }
}
