import 'package:firebase_notifications/widgets_reusing.dart';
import 'package:flutter/material.dart';

class ScreenNotification extends StatefulWidget {
  final String notification_title;
  ScreenNotification({required this.notification_title});

  @override
  State<ScreenNotification> createState() => _ScreenNotificationState();
}

class _ScreenNotificationState extends State<ScreenNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.notification_title}")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WidgetsReusing.getSnakeBar(context, "message");
        },
        child: Icon(Icons.message),
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
