import 'package:flutter/material.dart';

class AppShadow {
  AppShadow._();

  static const BoxShadow card = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 16,
    offset: Offset(0, 6),
  );

  static const BoxShadow light = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
}
