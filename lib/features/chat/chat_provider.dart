import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  ChatState({required this.messages, required this.isLoading});

  ChatState copyWith({List<ChatMessage>? messages, bool? isLoading}) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatNotifier extends Notifier<ChatState> {
  late ChatRepository _repository;

  @override
  ChatState build() {
    _repository = ref.watch(chatRepositoryProvider);
    return ChatState(
      messages: [
        ChatMessage(
          text: 'Hello! I am the VoterFlow Concierge. How can I assist you with your election journey today?',
          isUser: false,
        )
      ],
      isLoading: false,
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    state = state.copyWith(
      messages: [...state.messages, ChatMessage(text: text, isUser: true)],
      isLoading: true,
    );
    
    try {
      final response = await _repository.sendMessage(text);
      state = state.copyWith(
        messages: [...state.messages, ChatMessage(text: response, isUser: false)],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }
}

final chatProvider = NotifierProvider<ChatNotifier, ChatState>(() {
  return ChatNotifier();
});
