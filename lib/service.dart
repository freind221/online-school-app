import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  String url = "http://localhost:5000/recommend";
  String postUrl = "http://localhost:5000/submit-quiz-result";
  Future<Map<String, dynamic>> fetchRecommendData(int userId, int last_quiz, int limit) async {
    // String str = FirebaseAuth.instance.currentUser!.uid;
    // int asciiValue = str.codeUnits.reduce((value, element) => value + element);
    // print(asciiValue);
    http.Response response = await http.get(Uri.parse(
        '${url}/recommend?user_id=${userId}&last_quiz_id=${last_quiz}&num_recommendations=${limit}'));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['recommended_quizzes'][0]);
        return data;
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }

    throw Exception('Error');
  }

  Future<void> postUser(String userId, List quizzes, List scores, List categories) async {
    try {
      final response = await http.post(
        Uri.parse(postUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"user_id": userId, "user_quizzes": quizzes, "scores": scores, "categories": categories}),
      );

      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        print("Success")
      } else {
        throw Exception('Failed to create album.');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
