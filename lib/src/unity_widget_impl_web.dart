import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'unity_web_controller.dart';

Widget getUnityWidget({
  required String url,
  required void Function(String data) listenMessageFromUnity,
  required void Function(UnityWebController unityWebController) onUnityLoaded,
  Key? key,
}) {
  return UnityWidgetWebImpl(
    url: url,
    listenMessageFromUnity: listenMessageFromUnity,
    onUnityLoaded: onUnityLoaded,
  );
}

class UnityWidgetWebImpl extends StatefulWidget {
  const UnityWidgetWebImpl({
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
  State<UnityWidgetWebImpl> createState() => _UnityWidgetWebImplState();
}

class _UnityWidgetWebImplState extends State<UnityWidgetWebImpl> {
  late UnityWebController _unityWebHelper;

  @override
  void initState() {
    _unityWebHelper = UnityWebController(
      listenMessageFromUnity: (data) {
        if (data == 'unity_loaded') {
          widget.onUnityLoaded(_unityWebHelper);
        } else {
          widget.listenMessageFromUnity(data);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _unityWebHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      initialContent: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      initialSourceType: SourceType.url,
      onWebViewCreated: (controller) {},
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
