import 'package:flutter/material.dart';
import 'unity_web_controller.dart';
import 'unity_widget_impl_stub.dart' if (dart.library.js) 'unity_widget_impl_web.dart';

class UnityWebWidget extends StatelessWidget {
  const UnityWebWidget({
    required this.url,
    required this.listenMessageFromUnity,
    required this.onUnityLoaded,
    Key? key,
  }) : super(key: key);

  /// location of the index.html file inside unity folder
  /// ```dart
  /// String url = 'http://localhost:${Uri.base.port}/unityBuild/index.html'
  /// ```
  final String url;

  /// listen for [data] emitted by unity
  final void Function(String data) listenMessageFromUnity;

  /// called when unity is loaded.
  /// use [unityWebController] to send data to unity.
  final void Function(UnityWebController unityWebController) onUnityLoaded;

  @override
  Widget build(BuildContext context) {
    return getUnityWidget(
      url: url,
      listenMessageFromUnity: listenMessageFromUnity,
      onUnityLoaded: onUnityLoaded,
    );
  }
}
