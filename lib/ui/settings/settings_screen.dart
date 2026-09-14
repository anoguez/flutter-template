import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/app_service.dart';
import 'package:flutter_template/ui/core/custom_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: CustomCard(
          headerLabel: "Appearance",
          child: Column(
            children: [
              ValueListenableBuilder<String>(
                valueListenable: settingsLogic.themeMode,
                builder: (context, themeMode, _) =>
                    DropdownButtonFormField<String>(
                      initialValue: themeMode,
                      decoration: const InputDecoration(labelText: 'Theme'),
                      items: const [
                        DropdownMenuItem(
                          value: 'system',
                          child: Text('System default'),
                        ),
                        DropdownMenuItem(value: 'light', child: Text('Light')),
                        DropdownMenuItem(value: 'dark', child: Text('Dark')),
                      ],
                      onChanged: (value) {
                        if (value != null) settingsLogic.setThemeMode(value);
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
