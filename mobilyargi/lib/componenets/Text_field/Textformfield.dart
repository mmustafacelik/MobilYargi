import 'package:flutter/cupertino.dart';

class GeneralTextFormField extends StatefulWidget
{
   final Color backgroundColor;
  final Color alertColor;
  final Color warningColor;
  final Color successColor;
  final bool autoFocus;
  final TextEditingController textEditingController;
  final String label;
  final EdgeInsets contentPadding;
  final bool passwordText;
  final double height;
  final bool enabled;
  final TextInputType keyboardType;

const GeneralTextFormField({
     
    Key key,
    this.backgroundColor = TernegoStatic.themeTextFieldBackgroundColor,
    this.alertColor = TernegoStatic.themeTextFieldAlertColor,
    this.warningColor = TernegoStatic.themeTextFieldWarningColor,
    this.successColor = TernegoStatic.themeTextFieldSuccessColor,
    this.textEditingController,
    this.autoFocus = false,
    this.label,
    this.value,
    this.contentPadding = const EdgeInsets.all(12),
    this.passwordText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.height,
  })
}