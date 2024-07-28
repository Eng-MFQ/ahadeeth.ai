import 'dart:convert';

import 'Fatwa.dart';

// Define the classes representing the structure of the response
class GptAnswer {
  final String content;
  final String role;
  final dynamic functionCall;
  final dynamic toolCalls;

  GptAnswer({
    required this.content,
    required this.role,
    this.functionCall,
    this.toolCalls,
  });

  factory GptAnswer.fromMessage(String user, {bool isUser = true}) {
    return GptAnswer(
      content: user,
      role: isUser ? "user" : "assistant",
      functionCall: "",
      toolCalls: "",
    );
  }

  factory GptAnswer.fromJson(Map<String, dynamic> json) {
    return GptAnswer(
      content: json['content'],
      role: json['role'] ?? "assistant",
      functionCall: json['function_call'] ?? "",
      toolCalls: json['tool_calls'] ?? "",
    );
  }
}

class SheikhModel {
  final GptAnswer gptAnswer;
  final bool isSendToSheikh;
  final List<Fatwa> fatwaList;

  SheikhModel({
    required this.gptAnswer,
    required this.isSendToSheikh,
    required this.fatwaList,
  });

  factory SheikhModel.fromMessage(String message, {bool isUser = true}) {
    return SheikhModel(
        gptAnswer: GptAnswer.fromMessage(message, isUser: isUser),
        isSendToSheikh: false,
        fatwaList: []);
  }

  factory SheikhModel.fromJson(Map<String, dynamic> json) {
    var fatwaListJson = json['fatwaList'] as List;
    List<Fatwa> fatwaList =
        fatwaListJson.map((i) => Fatwa.fromJson(i)).toList();

    return SheikhModel(
      gptAnswer: GptAnswer.fromJson(json['gptAnswer']),
      isSendToSheikh: json['isSendToSheikh'] ?? false,
      fatwaList: fatwaList,
    );
  }
}
