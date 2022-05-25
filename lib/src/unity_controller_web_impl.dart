// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'unity_web_controller.dart';

UnityWebController getUnityController() {
  return UnityControllerWeb();
}

class UnityControllerWeb extends UnityWebController {
  late html.MessageEvent _flutter2js;

  @override
  void sendDataToUnity({
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

  @override
  void dispose() {
    html.window.removeEventListener('message', (event) {
      log("message event disposed. ${event.toString()}");
    });
    html.window.removeEventListener('flutter2js', (event) {
      log("flutter2js event disposed. ${event.toString()}");
    });
  }
}
