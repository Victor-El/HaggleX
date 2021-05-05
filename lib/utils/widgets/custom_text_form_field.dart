import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String floatingText;
  final bool isPasswordField;
  final Color enabledBorderColor;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final Color hintColor;
  final Color textColor;
  final TextEditingController controller;

  CustomTextFormField({
    @required this.hintText,
    @required this.floatingText,
    @required this.isPasswordField,
    @required this.enabledBorderColor,
    @required this.validator,
    @required this.keyboardType,
    @required this.hintColor,
    @required this.textColor,
    @required this.controller,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = false;
  FocusNode _focusNode;
  bool _showLabel = false;

  @override
  void initState() {
    _showPassword = widget.isPasswordField == null ? false : !widget.isPasswordField;
    _focusNode = FocusNode();
    _showLabel = false;
    _focusNode.addListener(() {
      setState(() {
        _showLabel = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      onTap: _requestFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: TextStyle(color: widget.textColor),
      obscureText: !_showPassword,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              )
            : null,
        hintText: _showLabel ? null : widget.hintText,
        hintStyle: TextStyle(color: widget.hintColor),
        labelText: _showLabel ? widget.floatingText : null,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.enabledBorderColor)),
      ),
    );
  }
}
