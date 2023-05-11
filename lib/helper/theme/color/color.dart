import 'dart:ui';

class AppColor {
  const AppColor({
    required this.primary,
    required this.secondary,
  });

  final PrimaryColor primary;
  final SecondaryColor secondary;
}

class PrimaryColor {
  final Color white;
  final Color black;
  final Color grey;
  final Color yellow;

  PrimaryColor({
    required this.white,
    required this.black,
    required this.grey,
    required this.yellow,
  });
}

class SecondaryColor {
  final Color green;
  final Color red;
  final Color yellow;
  final Color orange;
  final Color blue;

  SecondaryColor({
    required this.green,
    required this.red,
    required this.yellow,
    required this.orange,
    required this.blue,
  });
}
