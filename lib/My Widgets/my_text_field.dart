import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool hasError;
  final String errorText;
  final TextInputType? textInputType;
  final bool enabled;
  final bool obscureText;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final Icon? suffixIcon;
  final String? label;
  final Color? color;
  final int? maxLength;
  final int? maxLines;
  final Icon? prefixIcon;
  final List<TextInputFormatter>? textInputFormatter;

  const MyTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.hasError = false,
    this.errorText = '',
    this.textInputType,
    this.enabled = true,
    this.obscureText = false,
    this.isPasswordField = false,
    this.validator,
    this.suffixIcon,
    this.label,
    this.color,
    this.maxLength,
    this.prefixIcon,
    this.maxLines = 1,
    this.textInputFormatter,
  }) : super (key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obsTxt = true;
  InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
          color: Colors.grey,
          width: 1
      )
  );

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return SizedBox(
      width: s.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 5),
        child: TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.isPasswordField
              ? widget.enabled
                  ? obsTxt
                  : true
              : widget.obscureText,
          inputFormatters: widget.textInputFormatter,
          decoration: InputDecoration(
              fillColor: widget.color ?? Colors.white,
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(15),
              //     borderSide: BorderSide.none),
              hintText: widget.hintText,
              labelText: widget.label,
              counterText: '',
              disabledBorder: inputBorder,
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              errorBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              hintStyle: const TextStyle(color: Colors.grey),
              errorText: widget.hasError ? widget.errorText : null,
              filled: true,
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                  icon: obsTxt
                      ? const Icon(
                    Icons.visibility,
                  )
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obsTxt = !obsTxt;
                    });
                  })
                  : widget.suffixIcon,
              prefixIcon: widget.prefixIcon),
          validator: widget.validator,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
        ),
      ),
    );
  }
}
