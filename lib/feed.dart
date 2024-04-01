// help/feed.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import '/article.dart';

class Feed {
  List<Article> feed = [];

  Future<void> getFeed() async {
    // Remplacez l'URL par votre API
    Uri uri = Uri.parse("https://www.okrichmoha.one/test1.php");

    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);
    if (jsonData is List) {
      jsonData.forEach((element) {
        if (element is Map<String, dynamic>) {
          Article article = Article.fromJson(element);
          feed.add(article);
        }
      });
    }
  }
}
