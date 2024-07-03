part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}
class SpeechInitial extends AiState {}

class SpeechReady extends AiState {}

class SpeechListening extends AiState {}

class SpeechRecognized extends AiState {
  final String recognizedWords;
  SpeechRecognized(this.recognizedWords);
}

class SpeechError extends AiState {
  final String message;
  SpeechError(this.message);
}