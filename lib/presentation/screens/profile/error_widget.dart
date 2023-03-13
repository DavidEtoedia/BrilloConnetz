import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.error),
      ),
    );
  }
}
