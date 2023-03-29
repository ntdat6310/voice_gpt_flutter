import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

class RegenerateResponseWidget extends StatelessWidget {
  const RegenerateResponseWidget(
      {Key? key, required this.isResponseSuccess, required this.onPressed})
      : super(key: key);
  final bool isResponseSuccess;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isResponseSuccess,
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Background.backgroundColor,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              onPressed();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.refresh),
                SizedBox(width: 10),
                Text("Regenerate Response.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
