import 'dart:convert';

import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/shared/constant.dart';

import 'package:http/http.dart' as http;

// Follow OpenAI's document
// https://platform.openai.com/docs/guides/chat/introduction
// https://platform.openai.com/docs/api-reference/chat
class ChatGptService {
  Future<String> fetchChatResponse(String content) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/chat/completions");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": content,
            }
          ],
          'temperature': 0,
          'max_tokens': 1000,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        }),
      );

      // Response success
      if (response.statusCode == 200) {
        print("-----------------------");
        print(response.body.toString());
        // Decode response from API using UTF-8 format.
        String responseBody = utf8.decode(response.bodyBytes);

        // Convert JSON String to Map<String, dynamic>
        Map<String, dynamic> newResponse = jsonDecode(responseBody);

        // This format is follow by OpenAI's document
        return newResponse['choices'][0]['message']['content'];
      }
      // Response Failed
      else {
        print("Error: Response failed - ${response.statusCode}");
        print("Response: ${response.body}");
        throw Exception("Đã có lỗi xảy ra, xin vui lòng thử lại");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> fetchChatResponseWithAllHistory(
    List<MessageModel> messages,
  ) async {
    final newMessages =
        List<Map<String, dynamic>>.generate(messages.length, (index) {
      return {
        "role": messages[index].senderType == SenderType.user
            ? "user"
            : "assistant",
        "content": messages[index].content,
      };
    });

    print("newMessages: $newMessages");

    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": newMessages,
          'temperature': 0,
          'max_tokens': 1000,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        }),
      );

      // Response success
      if (response.statusCode == 200) {
        print("-----------------------");
        print(response.body.toString());
        // Decode response from API using UTF-8 format.
        String responseBody = utf8.decode(response.bodyBytes);

        // Convert JSON String to Map<String, dynamic>
        Map<String, dynamic> newResponse = jsonDecode(responseBody);

        // This format is follow by OpenAI's document
        return newResponse['choices'][0]['message']['content'];
      }
      // Response Failed
      else {
        print("Error: Response failed - ${response.statusCode}");
        print("Response: ${response.body}");
        throw Exception("Đã có lỗi xảy ra, xin vui lòng thử lại");
      }
    } catch (e) {
      rethrow;
    }
  }
}
