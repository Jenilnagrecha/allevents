import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventWebview extends StatefulWidget {
  final String eventUrl;
  EventWebview({super.key, required this.eventUrl});

  @override
  State<EventWebview> createState() => _EventWebviewState();
}

class _EventWebviewState extends State<EventWebview> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.eventUrl));
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
