import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chats/messages.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            const NewMessage(),
          ],
        ),
      ),
    );
  }
}
