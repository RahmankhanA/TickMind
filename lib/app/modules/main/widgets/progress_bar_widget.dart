import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 200.0,
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
