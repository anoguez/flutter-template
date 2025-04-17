import 'package:flutter_template/common_libs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDropdownField<T, V> extends ReactiveFormField<T, V> {
  CustomDropdownField({
    super.key,
    super.formControlName,
    super.formControl,
    super.valueAccessor,
    required List<DropdownMenuItem<V>> items,
    super.validationMessages,
    ShowErrorsFunction? super.showErrors,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    VoidCallback? onTap,
    InputDecoration decoration = const InputDecoration(),
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool readOnly = false,
    double? itemHeight,
    Color? dropdownColor,
    Color? focusColor,
    Widget? underline,
    bool autofocus = false,
    double? menuMaxHeight,
    bool? enableFeedback,
    AlignmentDirectional alignment = AlignmentDirectional.centerStart,
    BorderRadius? borderRadius,
    String? suffixText,
    String? hintText,
    Color? placeholderColor,
    Color? enabledBorderColor,
    String? label,
    bool showTooltipIcon = false,
    Widget? tooltipIcon,
  })  : assert(itemHeight == null || itemHeight > 0),
        super(
          builder: (field) {
            final borderRadiusValue = $styles.corners.xs;

            final state = field as _ReactiveDropdownFieldState<T, V>;

            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            var effectiveValue = field.value;
            if (effectiveValue != null &&
                !items.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            final isDisabled = readOnly || field.control.disabled;
            var effectiveDisabledHint = disabledHint;
            if (isDisabled && disabledHint == null) {
              final selectedItemIndex =
                  items.indexWhere((item) => item.value == effectiveValue);
              if (selectedItemIndex > -1) {
                effectiveDisabledHint = selectedItemBuilder != null
                    ? selectedItemBuilder(field.context)
                        .elementAt(selectedItemIndex)
                    : items.elementAt(selectedItemIndex).child;
              }
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: !isDisabled,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixText: suffixText,
                hintText: hintText,
                label: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: $styles.horizontalInsets.xs,
                  children: [
                    Text(
                      label ?? "",
                      style: TextStyle(
                        color: field.errorText != null
                            ? AppColors.error
                            : Colors.black,
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
                labelStyle: TextStyle(
                  color: placeholderColor ?? AppColors.midnightGreen,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledBorderColor ??
                        AppColors.midnightGreen.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.midnightGreen),
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                ),
              ),
              isEmpty: effectiveValue == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<V>(
                  value: effectiveValue,
                  items: items,
                  selectedItemBuilder: selectedItemBuilder,
                  hint: hint,
                  onChanged: isDisabled ? null : field.didChange,
                  onTap: onTap,
                  disabledHint: effectiveDisabledHint,
                  elevation: elevation,
                  style: style,
                  icon: icon,
                  iconDisabledColor: iconDisabledColor,
                  iconEnabledColor: iconEnabledColor,
                  iconSize: iconSize,
                  isDense: isDense,
                  isExpanded: isExpanded,
                  itemHeight: itemHeight,
                  focusNode: state._focusController.focusNode,
                  dropdownColor: dropdownColor,
                  focusColor: focusColor,
                  underline: underline,
                  autofocus: autofocus,
                  menuMaxHeight: menuMaxHeight,
                  enableFeedback: enableFeedback,
                  alignment: alignment,
                  borderRadius: borderRadius,
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveDropdownFieldState<T, V>();
}

class _ReactiveDropdownFieldState<T, V> extends ReactiveFormFieldState<T, V> {
  final _focusController = FocusController();

  @override
  void subscribeControl() {
    control.registerFocusController(_focusController);
    super.subscribeControl();
  }

  @override
  void dispose() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
    super.dispose();
  }
}
