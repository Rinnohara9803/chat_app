import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  final _user = FirebaseAuth.instance.currentUser as User;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (streamSnapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${streamSnapshot.error}',
            ),
          );
        } else {
          final documents = streamSnapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: documents.isEmpty
                ? const Center(
                    child: Text(
                      'No messages in the chat',
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: documents.length,
                    itemBuilder: (ctx, i) {
                      return MessageBubble(
                        text: documents[i]['text'],
                        userName: documents[i]['userName'],
                        userImage: documents[i]['userImage'],
                        isMe: documents[i]['userId'] == _user.uid,
                        uniqueKey: ValueKey(
                          documents[i].id,
                        ),
                      );
                    },
                  ),
          );
        }
      },
    );
  }
}
