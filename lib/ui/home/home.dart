import 'package:flutter_template/common_libs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Home Screen',
            style: $styles.text.body,
          ),
        ],
      ),
    );
  }
}
