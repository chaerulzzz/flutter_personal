    
import 'package:flutter/foundation.dart';
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

  Future<List<Post>> fetchPosts(http.Client client) async {
    final response = await client.get(url);

    return compute(parsePosts , response.body);
  }
}