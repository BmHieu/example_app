import 'package:flutter/material.dart';

const semiBold = FontWeight.w600;
const medium = FontWeight.w500;
const _nhn = "NaN-Hyena-Noon";

class AppTextStyle {
  final TextStyle nhnSebo32;

  AppTextStyle({
    required this.nhnSebo32,
  });
}

final appTextStyle = AppTextStyle(
  nhnSebo32: const TextStyle(
    fontFamily: _nhn,
    fontWeight: semiBold,
    fontSize: 32,
  ),
);
