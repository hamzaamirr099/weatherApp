import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  String? Function(String?)? onFieldSubmitted;
  String? hintText;

  DefaultFormField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          suffixIcon: const Icon(Icons.search, color: Colors.white,),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
          ),
          hintStyle: TextStyle(color: Colors.grey[300]),
        ),
      ),
    );
  }
}
