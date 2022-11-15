import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/Chat-Screen';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('LogOut')
                  ],
                ),
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/q3wNsSY4RHZpVwcO4bue/messages')
            .snapshots(),
        builder: (ctx, snapshot) {
          final document = snapshot.data?.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(document?[index]['text']),
              );
            },
            itemCount: document?.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/q3wNsSY4RHZpVwcO4bue/messages')
                .add({'text': 'This is from button!'});
          },
          child: const Icon(Icons.add)),
    );
  }
}
