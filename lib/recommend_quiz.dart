import 'package:faheem/service.dart';
import 'package:flutter/material.dart';

class RecommendQuiz1 extends StatefulWidget {
  const RecommendQuiz1({Key? key}) : super(key: key);

  @override
  State<RecommendQuiz1> createState() => _RecommendQuiz1State();
}

class _RecommendQuiz1State extends State<RecommendQuiz1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              RemoteService().fetchRecommendData();
            },
            child: Text('data'))
      ],
    ));
  }
}
