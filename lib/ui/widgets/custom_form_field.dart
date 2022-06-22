import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

class CustomFieldForm extends StatelessWidget {
  final String? label, hint, endText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData icon;
  final IconData? endIcon;
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

  const CustomFieldForm({
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
    required this.icon,
    this.backgroundColor,
    this.textColor = AppColors.primary,
    this.hintColor = Colors.grey,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onChanged,
    this.readOnly = false,
    this.validate = false,
    this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> formatters = [];
    formatters.add(LengthLimitingTextInputFormatter(maxLength));
    if (inputFormatters != null) {
      formatters.addAll(inputFormatters!);
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
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          suffixIcon: (endText == null)
              ? Icon(endIcon)
              : Align(
            widthFactor: 1,
            alignment: Alignment.centerRight,
            child: Text(
              endText.toString(),
              style: AppStyle.subtitle4,
            ),
          ),
          errorText: validate ? 'Field cannot be empty!' : null,
          hintText: label,
          labelText: hint,
          floatingLabelStyle: TextStyle(color: textColor),
          labelStyle: TextStyle(color: hintColor),
          hintStyle: TextStyle(color: hintColor),
        ),
        validator: validator,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

class CustomPasswordFieldForm extends StatelessWidget {
  final String? label, hint, endText;
  final TextEditingController controller;
  final IconData icon;
  final Widget? endIcon;
  final VoidCallback? onPress;
  final int? maxLength;
  final String? Function(String?)? validator, onSaved, onChanged, onSubmit;
  final String? errorText;
  final bool hiddenText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;

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
    required this.icon,
    this.backgroundColor,
    this.textColor = AppColors.primary,
    this.hintColor = Colors.grey,
    this.maxLength,
    this.onSubmit,
    this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor ?? Colors.grey.withOpacity(0.1),
      ),
      child: TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: controller,
        decoration: InputDecoration(
          errorText: errorText,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
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
