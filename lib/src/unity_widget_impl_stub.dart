import 'package:flutter/material.dart';
import 'unity_web_controller.dart';

Widget getUnityWidget({
  required String url,
  required void Function(String data) listenMessageFromUnity,
  required void Function(UnityWebController unityWebController) onUnityLoaded,
  Key? key,
}) {
  throw UnsupportedError('unity_widget_web only supports for web currently.');
}
