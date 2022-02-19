import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    User user = FirebaseAuth.instance.currentUser as User;
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _message,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
      },
    );
    _messageController.clear();
    _message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelText: 'Send a message',
                ),
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
