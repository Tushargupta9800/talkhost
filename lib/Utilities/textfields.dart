import 'package:flutter/material.dart';

TextField authTextField({
  required String title,
  required TextEditingController controller,
  bool visible = false,
  Function? onPressed
}) {
  return TextField(
    controller: controller,
    obscureText: visible,
    decoration: InputDecoration(
      hintText: title,
      filled: true,
      fillColor: Colors.blueGrey[50],
      suffixIcon: (title == "Password")
          ? IconButton(
              onPressed: ()=> onPressed!(),
              icon: const Icon(Icons.visibility_off_outlined),
              color: Colors.grey,
            )
          : null,
      labelStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.only(left: 30),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey[50]!),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey[50]!),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
