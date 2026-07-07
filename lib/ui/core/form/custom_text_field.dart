import 'package:flutter/services.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField<T> extends ReactiveFormField<T, T> {
  CustomTextField({
    super.key,
    required String super.formControlName,
    String? label,
    String? suffixText,
    String? hintText,
    bool? filled = false,
    Color? fillColor,
    Color? labelColor,
    Color? placeholderColor,
    Color? enabledBorderColor,
    TextStyle? floatingLabelStyle,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Map<String, ValidationMessageFunction>? validationMessages,
    int? maxLength,
    int? maxLines = 1,
    bool obscureText = false,
    bool showTooltipIcon = false,
    Widget? tooltipIcon,
    void Function(T? value)? onChanged,
  }) : super(
          builder: (field) {
            final borderRadius = $styles.corners.xs;
            final colors = field.context.colors;
            return ReactiveTextField(
              formControlName: formControlName,
              cursorColor: colors.primary,
              style: TextStyle(color: labelColor),
              obscureText: obscureText,
              maxLines: maxLines,
              onChanged: (_) {
                if (onChanged != null) onChanged(field.value);
              },
              showErrors: (control) =>
                  control.invalid && control.touched && control.dirty,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validationMessages: validationMessages,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                filled: filled,
                fillColor: fillColor,
                floatingLabelStyle: floatingLabelStyle,
                label: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: $styles.horizontalInsets.xs,
                  children: [
                    Text(
                      label ?? "",
                      style: TextStyle(
                        color: field.touched && field.errorText != null
                            ? colors.error
                            : colors.onSurface,
                      ),
                    ),
                    if (showTooltipIcon)
                      Tooltip(
                        message: label,
                        triggerMode: TooltipTriggerMode.tap,
                        preferBelow: true,
                        verticalOffset: 0,
                        child: tooltipIcon ?? const Icon(Icons.info_outline),
                      ),
                  ],
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixText: suffixText,
                hintText: hintText,
                labelStyle: TextStyle(
                  color: placeholderColor ?? colors.onSurfaceVariant,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? colors.outline,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.primary),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.error),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.error),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            );
          },
        );
}
