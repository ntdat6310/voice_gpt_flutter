import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/shared/enum.dart';
import 'package:voice_gpt_flutter/stores/auto_speak/auto_speak.dart';
import 'package:voice_gpt_flutter/ui/setting/components/auto_speak_dialog.dart';

import '../../shared/styles/background.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final AutoSpeakStore _autoSpeakStore = AutoSpeakStore();

  @override
  Widget build(BuildContext context) {
    print("AutoSpeak: ${_autoSpeakStore.isAutoSpeak.toString()}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
          backgroundColor: Background.botBackgroundColor,
        ),
        body: Container(
          color: Background.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.dark_mode, color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "Dark mode",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.language_outlined,
                          color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "Language",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () async {
                    AutoSpeakStatus? result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AutoSpeakDialog(
                              initialStatus: _autoSpeakStore.isAutoSpeak);
                        });
                    if (result != null) {
                      _autoSpeakStore.changeAutoSpeak(
                          result == AutoSpeakStatus.enable ? true : false);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.record_voice_over,
                          color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "Auto speak",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
