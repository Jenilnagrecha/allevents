import 'dart:convert';

import 'package:allevents/models/Event_call.dart';
import 'package:allevents/models/categores_model.dart';
import 'package:http/http.dart' as http;

class TestApis {
  Future<List<Categories>> GetCateories() async {
    final response = await http.get(
      Uri.parse('https://allevents.s3.amazonaws.com/tests/categories.json'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Categories.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<EventCall> GetEventData(String dataUrl) async {
    final response = await http.get(
      Uri.parse(dataUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return EventCall.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
