    
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_personal/repository/models/models.dart';

String url = 'https://jsonplaceholder.typicode.com/posts';

class PostRepository {
  
  Future<Post> getPost() async {
    final response = await http.get('$url/1');

    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      throw Exception('failed to load post');
    }
  }

  Future<Post> getAllPosts() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      throw Exception('failed to load post');
    }
  }
}