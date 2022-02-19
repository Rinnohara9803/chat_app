import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(
                'chats/Jv9CL1K7Cl0KrIM5Z8cQ/messages',
              )
              .orderBy(
                'createdAt',
                descending: false,
              )
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (streamSnapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${streamSnapshot.error}',
                ),
              );
            } else {
              final documents = streamSnapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, i) {
                  return Text(
                    documents[i]['text'],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/Jv9CL1K7Cl0KrIM5Z8cQ/messages')
                .add(
              {
                'text': 'test 3',
                'createdAt': 3,
              },
            );
          },
        ),
      ),
    );
  }
}
