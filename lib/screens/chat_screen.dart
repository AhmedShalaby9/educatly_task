import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import 'package:api/components/custom_text_field.dart';

class ChatScreen extends StatelessWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  ChatScreen(
      {Key? key, required this.receiverUserEmail, required this.receiverUserId})
      : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [currentUserId, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receiverUserEmail),
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is OnlineStatusUpdated) {
                  return Text(state.isOnline ? "Online" : "Offline",
                      style: const TextStyle(fontSize: 12));
                } else {
                  return const Text("Loading...");
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return ListView(
                    children: state.messages.docs
                        .map((doc) => _buildMessageItem(context, doc))
                        .toList(),
                  );
                } else if (state is ChatError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Start a conversation"));
                }
              },
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is TypingStatusUpdated && state.isTyping) {
                return const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Typing...", style: TextStyle(fontSize: 12)),
                );
              }
              return Container();
            },
          ),
          _buildMessageInput(context, chatRoomId),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context, String chatRoomId) {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: "Enter message",
            onChanged: (value) {
              if (value.isNotEmpty) {
                BlocProvider.of<ChatBloc>(context).add(
                  UpdateTypingStatusEvent(
                    chatRoomId: chatRoomId,
                    isTyping: true,
                  ),
                );
              } else {
                BlocProvider.of<ChatBloc>(context).add(
                  UpdateTypingStatusEvent(
                    chatRoomId: chatRoomId,
                    isTyping: false,
                  ),
                );
              }
            },
          ),
        ),
        IconButton(
          onPressed: () {
            if (_messageController.text.isNotEmpty) {
              BlocProvider.of<ChatBloc>(context).add(
                SendMessageEvent(
                  receiverId: receiverUserId,
                  message: _messageController.text,
                ),
              );
              _messageController.clear();
              BlocProvider.of<ChatBloc>(context).add(
                UpdateTypingStatusEvent(
                  chatRoomId: chatRoomId,
                  isTyping: false,
                ),
              );
            }
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  Widget _buildMessageItem(BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == FirebaseAuth.instance.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == FirebaseAuth.instance.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            Text(data['message']),
          ],
        ),
      ),
    );
  }
}
