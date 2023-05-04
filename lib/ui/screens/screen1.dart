import 'package:flutter_template/common_libs.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen 1"),
      ),
      body: const Center(
        child: Text("Screen 1"),
      ),
    );
  }
}
