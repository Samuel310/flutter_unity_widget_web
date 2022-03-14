// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

class UnityWebController {
  late html.MessageEvent _flutter2js;

  UnityWebController({required Function(String data) listenMessageFromUnity}) {
    html.window.addEventListener('message', (event) {
      listenMessageFromUnity((event as html.MessageEvent).data.toString());
    });
  }

  sendDataToUnity({
    required String gameObject,
    required String method,
    required String data,
  }) {
    _flutter2js = html.MessageEvent(
      'flutter2js',
      data: json.encode({
        "gameObject": gameObject,
        "method": method,
        "data": data,
      }),
    );
    html.window.dispatchEvent(_flutter2js);
  }

  void dispose() {
    html.window.removeEventListener('message', (event) {
      log("message event disposed. ${event.toString()}");
    });
    html.window.removeEventListener('flutter2js', (event) {
      log("flutter2js event disposed. ${event.toString()}");
    });
  }
}
