import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String userEmail;
  final bool isMe;

  final Key uniqueKey;

  const MessageBubble({
    required this.text,
    required this.userEmail,
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
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  userEmail,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
