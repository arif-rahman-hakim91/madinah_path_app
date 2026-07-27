import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double xs = 6;

  static const double sm = 10;

  static const double md = 16;

  static const double lg = 20;

  static const double xl = 24;

  static BorderRadius get xsRadius =>
      BorderRadius.circular(xs);

  static BorderRadius get smRadius =>
      BorderRadius.circular(sm);

  static BorderRadius get mdRadius =>
      BorderRadius.circular(md);

  static BorderRadius get lgRadius =>
      BorderRadius.circular(lg);

  static BorderRadius get xlRadius =>
      BorderRadius.circular(xl);
}