import 'package:brillo_connetz/presentation/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput(
      {Key? key,
      required this.controller,
      this.autovalidateMode,
      required this.validator,
      this.labelText,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.onTap,
      this.inputFormatters,
      this.enabled,
      this.textLength,
      this.isColor = Colors.black,
      this.readOnly = false,
      // required this.capitalization,

      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Color isColor;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?) validator;
  // final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? textLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      cursorColor: isColor,
      readOnly: readOnly,
      // maxLength: textLength,
      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
      autovalidateMode: autovalidateMode,

      textCapitalization: TextCapitalization.words,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.captionColor,
          fontSize: 15,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500),
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,

      onChanged: onChanged,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        errorStyle: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: Colors.red, letterSpacing: 0.5, fontSize: 12),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        iconColor: Colors.grey,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.0),
          borderSide:
              const BorderSide(width: 0.5, color: Colors.black), //<-- SEE HERE
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.grey.shade300,
          ), //<-- SEE HERE
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: labelText,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade400, fontSize: 13, letterSpacing: 0.0),
        // border: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(20.0),
        //   ),
        // )
      ),
      validator: validator,
      onTap: onTap,
    );
  }
}
