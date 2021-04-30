import 'package:flutter/material.dart';
import 'package:haggle_x/utils/constants.dart';

class FormPadding extends StatelessWidget {
  final double scaleFactor;

  FormPadding([this.scaleFactor = 1]);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(FORM_PADDING * scaleFactor));
  }
}
