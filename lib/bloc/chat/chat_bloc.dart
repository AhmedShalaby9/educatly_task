import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:api/services/chat/chat_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc(this.chatService) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<FetchMessagesEvent>(_onFetchMessages);
    on<UpdateTypingStatusEvent>(_onUpdateTypingStatus);
    on<UpdateOnlineStatusEvent>(_onUpdateOnlineStatus);
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await chatService.sendMessage(event.receiverId, event.message);
    } catch (e) {
      emit(ChatError("Failed to send message"));
    }
  }

  Future<void> _onFetchMessages(
      FetchMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      Stream<QuerySnapshot> messages =
      chatService.getMessages(event.userId, event.otherUserId);
      await emit.forEach(
        messages,
        onData: (data) => ChatLoaded(data),
        onError: (error, stackTrace) => ChatError(error.toString()),
      );
    } catch (e) {
      emit(ChatError("Failed to fetch messages"));
    }
  }

  Future<void> _onUpdateTypingStatus(
      UpdateTypingStatusEvent event, Emitter<ChatState> emit) async {
    try {
      await chatService.updateTypingStatus(event.chatRoomId, event.isTyping);
      emit(TypingStatusUpdated(event.isTyping));
    } catch (e) {
      emit(ChatError("Failed to update typing status"));
    }
  }

  Future<void> _onUpdateOnlineStatus(
      UpdateOnlineStatusEvent event, Emitter<ChatState> emit) async {
    try {
      await chatService.updateOnlineStatus(event.isOnline);
      emit(OnlineStatusUpdated(event.isOnline));
    } catch (e) {
      emit(ChatError("Failed to update online status"));
    }
  }
}
