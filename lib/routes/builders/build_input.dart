import 'package:flutter/material.dart';

Padding buildInput(String _hint, Size _size, TextEditingController controller,{IconButton? icon}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: _size.height * 0.01),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return 'required!';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: icon,
        hintText: _hint,
      ),
    ),
  );
}
