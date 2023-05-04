import 'package:flutter_template/common_libs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomCheckbox extends ReactiveFormField<bool, bool> {
  CustomCheckbox({
    Key? key,
    required String formControlName,
    String? label,
    Color? activeColor,
    TextStyle? labelStyle,
    void Function(bool value)? onChanged,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (field) {
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5.w,
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: ReactiveCheckbox(
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
                  )
              ],
            );
          },
        );
}
