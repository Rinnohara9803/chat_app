import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String userName;
  final String userImage;
  final bool isMe;

  final Key uniqueKey;

  const MessageBubble({
    required this.text,
    required this.userName,
    required this.userImage,
    required this.isMe,
    required this.uniqueKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 9,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.blueGrey.withOpacity(0.4)
                          : Colors.blue.withOpacity(0.4),
                      borderRadius: isMe
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(
                                12,
                              ),
                              bottomLeft: Radius.circular(
                                12,
                              ),
                              bottomRight: Radius.circular(
                                12,
                              ),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(
                                12,
                              ),
                              bottomLeft: Radius.circular(
                                12,
                              ),
                              bottomRight: Radius.circular(
                                12,
                              ),
                            ),
                    ),
                    child: Text(
                      text,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: isMe ? 180 : null,
            left: !isMe ? 180 : null,
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                userImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
