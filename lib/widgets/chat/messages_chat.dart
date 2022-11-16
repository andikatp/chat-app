import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagesChat extends StatelessWidget {
  const MessagesChat({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final doc = snapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: doc?.length,
          itemBuilder: (context, index) {
            return MessageBubble(
                userImage: doc?[index]['userImage'],
                message: doc?[index]['text'],
                isMe: snapshot.data?.docs[index]['userId'] ==
                        FirebaseAuth.instance.currentUser?.uid
                    ? true
                    : false,
                username: doc?[index]['username'],
                key: ValueKey(
                  doc?[index].id,
                ));
          },
        );
      },
    );
  }
}
