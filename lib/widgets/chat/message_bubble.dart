import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.username,
    required this.userImage,
  }) : super(key: key);
  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                  topLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  topRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
                color: isMe
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).primaryTextTheme.titleLarge?.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.titleLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: isMe ? 0 : 125,
              right: isMe ? 125 : 0,
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(userImage),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
