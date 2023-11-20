import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/logic/providers/settings.dart';
import 'package:flutter_template/ui/common/custom_card.dart';
import 'package:flutter_template/ui/common/form/custom_switch.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsService = ref.read(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ReactiveForm(
        formGroup: settingsService.formGroup,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomCard(
            headerLabel: "ABC",
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dark Mode"),
                    CustomSwitch(
                      formControlName: 'isDarkModeEnabled',
                      onChanged: (value) =>
                          settingsService.enableDarkMode(value),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
