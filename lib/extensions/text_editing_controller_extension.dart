import 'package:flutter/material.dart';

extension TextEditingControllerExtension on TextEditingController?{
  bool get isEmpty => (this?.value.text .isEmpty ?? true);

}