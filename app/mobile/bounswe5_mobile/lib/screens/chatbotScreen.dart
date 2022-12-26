import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: ChatbotScreen(),
  ));
}

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Start Conversation'),
          onPressed: () async {
            try {
              dynamic conversationObject = {
                'appId': '35f067c7290c8f7f05b2575bf22b44440',
                'isSingleConversation' : false
              };
              dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
              print("Conversation builder success : " + result.toString());
            } on Exception catch (e) {
              print("Conversation builder error occurred : " + e.toString());
            }
          },
        ),
      ),
    );
  }
}

