import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webvieu extends StatefulWidget {
  const webvieu({super.key});

  @override
  State<webvieu> createState() => _webvieuState();
}

class _webvieuState extends State<webvieu> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        'https://web.facebook.com/profile.php?id=100085315370313&locale=fr_FR'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('titre'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
