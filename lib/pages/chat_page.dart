import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i = 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Text(
                        'Logout',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(
                'chats/Jv9CL1K7Cl0KrIM5Z8cQ/messages',
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
                'text': 'test $i',
              },
            );
            i++;
          },
        ),
      ),
    );
  }
}
