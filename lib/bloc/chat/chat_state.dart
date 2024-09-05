import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final QuerySnapshot messages;

  const ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class TypingStatusUpdated extends ChatState {
  final bool isTyping;

  const TypingStatusUpdated(this.isTyping);

  @override
  List<Object> get props => [isTyping];
}

class OnlineStatusUpdated extends ChatState {
  final bool isOnline;

  const OnlineStatusUpdated(this.isOnline);

  @override
  List<Object> get props => [isOnline];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}
