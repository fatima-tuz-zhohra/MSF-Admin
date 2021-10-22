import 'package:flutter/material.dart';

Color getRoleColor(String? role) {
  if (role == "Doctor") {
    return Colors.green;
  } else if (role == "Regular User") {
    return Colors.red;
  } else if (role == "Blood Donor") {
    return Colors.blueAccent;
  } else if (role == "Oxygen Supplier") {
    return Colors.amberAccent;
  }
  return Colors.black38;
}
