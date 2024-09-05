import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String receiverId;
  final String message;

  const SendMessageEvent({required this.receiverId, required this.message});

  @override
  List<Object> get props => [receiverId, message];
}

class FetchMessagesEvent extends ChatEvent {
  final String userId;
  final String otherUserId;

  const FetchMessagesEvent({required this.userId, required this.otherUserId});

  @override
  List<Object> get props => [userId, otherUserId];
}

class UpdateTypingStatusEvent extends ChatEvent {
  final String chatRoomId;
  final bool isTyping;

  const UpdateTypingStatusEvent({required this.chatRoomId, required this.isTyping});

  @override
  List<Object> get props => [chatRoomId, isTyping];
}

class UpdateOnlineStatusEvent extends ChatEvent {
  final bool isOnline;

  const UpdateOnlineStatusEvent({required this.isOnline});

  @override
  List<Object> get props => [isOnline];
}
