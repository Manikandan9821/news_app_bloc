import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWebScreen extends StatelessWidget {
  final String title;
  final String url;

  NewsWebScreen({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      url: url,
    );
  }
}
