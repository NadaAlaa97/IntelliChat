import 'package:bloc/bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final SpeechToText speechToText;
  final FlutterTts flutterTts;

  AiCubit(this.speechToText, this.flutterTts) : super(SpeechInitial());

  Future<void> initSpeechToText() async {
    try {
      final speechEnabled = await speechToText.initialize();
      if (!speechEnabled) {
        emit(SpeechError("Speech recognition not enabled or not supported on this device."));
      } else {
        emit(SpeechReady());
      }
    } catch (e) {
      emit(SpeechError("Error initializing speech recognition: $e"));
    }
  }

  Future<void> startListening() async {
    if (state is SpeechReady && await speechToText.hasPermission && !speechToText.isListening) {
      await speechToText.listen(onResult: onSpeechResult);
      emit(SpeechListening());
    }
  }

  Future<void> stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
      emit(SpeechReady());
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    emit(SpeechRecognized(result.recognizedWords));
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }}
