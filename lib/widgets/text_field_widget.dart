import 'package:audio_book/components/app_style.dart';
import 'package:flutter/material.dart';
 
class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key, required this.hintText, this.validatorTextField, this.onChanged, this.obscureText, this.controller, this.erroText, this.onFieldSubmitted});

  final String hintText;
  final bool? obscureText;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final Function(String? value)? validatorTextField;
  final TextEditingController? controller;
  final String? erroText;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: appStyle.hintStyle,
        errorText: widget.erroText,
        filled: true,
        fillColor: themeData.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (widget.validatorTextField != null) {
          return widget.validatorTextField!(value!);
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}

