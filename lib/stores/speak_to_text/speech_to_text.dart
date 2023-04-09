import 'package:mobx/mobx.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'speech_to_text.g.dart';

class SpeechToTextStore = _SpeechToTextBase with _$SpeechToTextStore;

abstract class _SpeechToTextBase with Store {
  SpeechToText _speechToText = SpeechToText();
  Function? _onSpeechResultCallback;

  void setOnSpeechResultCallback(Function callback) {
    _onSpeechResultCallback = callback;
  }

  _SpeechToTextBase() {
    _initSpeech();
  }

  @readonly
  bool _speechEnabled = false;

  @readonly
  String _lastWords = '';

  @readonly
  bool _isListening = false;

  @action
  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  @action
  Future<void> startListening() async {
    _isListening = true;
    print("Start Listening");
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  @action
  Future<void> stopListening() async {
    print("Stop Listening");
    await _speechToText.stop();
    _isListening = _speechToText.isListening;
  }

  @action
  void _onSpeechResult(SpeechRecognitionResult result) {
    _isListening = _speechToText.isListening;
    _lastWords = result.recognizedWords;
    if (_onSpeechResultCallback != null) {
      _onSpeechResultCallback!();
    }
  }
}
