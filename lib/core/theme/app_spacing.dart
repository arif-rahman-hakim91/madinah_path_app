import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;

  static const double sm = 8;

  static const double md = 16;

  static const double lg = 24;

  static const double xl = 32;

  static const EdgeInsets page =
  EdgeInsets.all(md);

  static const EdgeInsets card =
  EdgeInsets.all(md);

  static const SizedBox verticalXs =
  SizedBox(height: xs);

  static const SizedBox verticalSm =
  SizedBox(height: sm);

  static const SizedBox verticalMd =
  SizedBox(height: md);

  static const SizedBox verticalLg =
  SizedBox(height: lg);

  static const SizedBox horizontalSm =
  SizedBox(width: sm);

  static const SizedBox horizontalMd =
  SizedBox(width: md);

  static const SizedBox horizontalLg =
  SizedBox(width: lg);
}