import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/app_logic.dart';
import 'package:flutter_template/src/presentation/common/custom_card.dart';
import 'package:flutter_template/src/presentation/common/form/custom_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
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
                        settingsLogic.enableDarkModeEnabled(value),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
