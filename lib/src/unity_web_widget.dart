import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_web/src/unity_web_controller.dart';
import 'package:webviewx/webviewx.dart';

class UnityWebWidget extends StatefulWidget {
  const UnityWebWidget({
    required this.url,
    required this.listenMessageFromUnity,
    required this.onUnityLoaded,
    Key? key,
  }) : super(key: key);

  final String url;
  final void Function(String data) listenMessageFromUnity;
  final void Function(UnityWebController unityWebController) onUnityLoaded;

  @override
  State<UnityWebWidget> createState() => _UnityWebWidgetState();
}

class _UnityWebWidgetState extends State<UnityWebWidget> {
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
