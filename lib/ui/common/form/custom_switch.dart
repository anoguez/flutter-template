import 'package:flutter_template/common_libs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomSwitch extends ReactiveFormField<bool, bool> {
  CustomSwitch({
    super.key,
    required String super.formControlName,
    String? label,
    Color? activeColor,
    TextStyle? labelStyle,
    void Function(bool value)? onChanged,
  }) : super(
          builder: (field) {
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5.w,
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: ReactiveSwitch(
                    formControlName: formControlName,
                    activeColor: activeColor,
                    onChanged: (control) {
                      if (onChanged != null) onChanged(control.value!);
                    },
                  ),
                ),
                if (label != null)
                  Text(
                    label,
                    style: $styles.text.body.merge(labelStyle),
                  ),
              ],
            );
          },
        );
}
