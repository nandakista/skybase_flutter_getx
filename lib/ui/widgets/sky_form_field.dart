import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';

class SkyFieldForm extends StatelessWidget {
  final String? label, hint, endText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData? icon;
  final Widget? endIcon;
  final int? maxLength, maxLines;
  final VoidCallback? onPress;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final bool readOnly;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool validate;
  final String? initialValue;
  final TextStyle? style;

  const SkyFieldForm({
    Key? key,
    required this.label,
    required this.hint,
    this.maxLength,
    this.maxLines = 1,
    this.onPress,
    this.endIcon,
    required this.validator,
    this.controller,
    this.keyboardType,
    this.icon,
    this.backgroundColor,
    this.textColor = AppColors.primary,
    this.hintColor = Colors.grey,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.validate = false,
    this.endText,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<TextInputFormatter> formatters = [];
    formatters.add(LengthLimitingTextInputFormatter(maxLength));
    if (inputFormatters != null) {
      formatters.addAll(inputFormatters!);
    }

    /// Make controller and initial value can initialize in the same time
    if(controller != null && controller?.text == '' && initialValue != null) {
      controller?.text = initialValue.toString();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor ?? Colors.grey.withOpacity(0.1),
      ),
      child: TextFormField(
        onTap: onPress,
        readOnly: readOnly,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        initialValue: (controller == null) ? initialValue : null,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: (icon != null) ? Icon(icon) : null,
          suffixIcon: (endText == null)
              ? endIcon
              : Align(
            widthFactor: 1,
            alignment: Alignment.centerRight,
            child: Text(
              endText.toString(),
              style: AppStyle.subtitle4.copyWith(
                color: AppColors.systemDarkGrey,
              ),
            ),
          ),
          errorText: validate ? 'Field cannot be empty!' : null,
          hintText: label,
          labelText: hint,
          floatingLabelStyle: TextStyle(color: textColor),
          labelStyle: TextStyle(color: hintColor),
          hintStyle: TextStyle(color: hintColor),
        ),
        style: style,
        validator: validator,
        inputFormatters: formatters,
      ),
    );
  }
}

class CustomPasswordFieldForm extends StatelessWidget {
  final String? label, hint, endText;
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? endIcon;
  final VoidCallback? onPress;
  final int? maxLength;
  final String? Function(String?)? validator, onSaved, onChanged, onSubmit;
  final String? errorText;
  final bool hiddenText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final String? initialValue;
  final TextStyle? style;

  const CustomPasswordFieldForm({
    Key? key,
    required this.label,
    required this.hint,
    this.onPress,
    this.endIcon,
    this.errorText,
    this.hiddenText = true,
    this.onSaved,
    this.onChanged,
    required this.validator,
    required this.controller,
    this.icon,
    this.backgroundColor,
    this.textColor = AppColors.primary,
    this.hintColor = Colors.grey,
    this.maxLength,
    this.onSubmit,
    this.endText,
    this.initialValue,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Create
    if(controller != null && controller?.text == '' && initialValue != null) {
      controller?.text = initialValue.toString();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor ?? Colors.grey.withOpacity(0.1),
      ),
      child: TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: controller,
        initialValue: (controller == null) ? initialValue : null,
        decoration: InputDecoration(
          errorText: errorText,
          border: InputBorder.none,
          prefixIcon: (icon != null) ? Icon(icon) : null,
          suffixIcon: (endText == null)
              ? endIcon
              : Align(
            widthFactor: 1,
            alignment: Alignment.centerRight,
            child: Text(
              endText.toString(),
              style: AppStyle.subtitle4,
            ),
          ),
          hintText: hint,
          labelText: label,
          floatingLabelStyle: TextStyle(color: textColor),
          labelStyle: TextStyle(color: hintColor),
          hintStyle: TextStyle(color: hintColor),
        ),
        obscureText: hiddenText,
        maxLength: maxLength,
        onChanged: onChanged,
        onSaved: onSaved,
        onTap: onPress,
        onFieldSubmitted: onSubmit,
        validator: validator,
        style: style,
      ),
    );
  }
}

class RegisterPasswordRequirement extends StatelessWidget {
  final bool isValid;
  final String message;
  const RegisterPasswordRequirement(
      {Key? key, required this.isValid, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (isValid)
            ? const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              )
            : const Icon(
                Icons.close,
                color: AppColors.systemDarkGrey,
              ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(message,
              style: TextStyle(color: (isValid) ? Colors.green : Colors.grey)),
        )
      ],
    );
  }
}
