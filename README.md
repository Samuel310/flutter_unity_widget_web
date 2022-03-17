<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Flutter unity widget for embedding unity in flutter web apps. Now you can render unity webGL build in a Flutter web app. Also enables two way communication between flutter web and unity.

## Setup

1. Place the exported unity webGL build folder inside web folder.

![Web folder structure](https://github.com/Samuel310/flutter_unity_widget_web/blob/main/assets/fs.png?raw=true "Location to place exported unity web folder")

2. Modify the index.html file inside unity webGL build folder.

   - Add following script in index.html.

     ```javascript
     let globalUnityInstance;

     window["receiveMessageFromUnity"] = function (params) {
       window.parent.postMessage(params, "*");
     };

     window.parent.addEventListener("flutter2js", function (params) {
       const obj = JSON.parse(params.data);
       globalUnityInstance.SendMessage(obj.gameObject, obj.method, obj.data);
     });
     ```

     index.html file after adding the above script.

     ![index.html file image](https://github.com/Samuel310/flutter_unity_widget_web/blob/main/assets/index1.png?raw=true "index.html will look like this after adding the above script")

   - Add following script in index.html.

     ```javascript
     window.parent.postMessage("unity_loaded", "*");
     globalUnityInstance = unityInstance;
     ```

     index.html file after adding the above script.

     ![index.html file image](https://github.com/Samuel310/flutter_unity_widget_web/blob/main/assets/index2.png?raw=true "index.html will look like this after adding the above script")

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_web/flutter_unity_widget_web.dart';

class UnityScreen extends StatefulWidget {
  const UnityScreen({Key? key}) : super(key: key);

  @override
  State<UnityScreen> createState() => _UnityScreenState();
}

class _UnityScreenState extends State<UnityScreen> {
  late UnityWebController _unityWebController;

  @override
  Widget build(BuildContext context) {
    return UnityWebWidget(
      url: 'http://localhost:${Uri.base.port}/unity/index.html',
      listenMessageFromUnity: _listenMessageFromUnity,
      onUnityLoaded: _onUnityLoaded,
    );
  }

  @override
  void dispose() {
    _unityWebController.dispose();
    super.dispose();
  }

  void _listenMessageFromUnity(String data) {
    if (data == 'load_next_scene') { // any message emitted from unty.
      _unityWebController.sendDataToUnity(
        gameObject: 'GameWindow',
        method: 'LoadNextScene',
        data: '0', // data sent to unity from flutter web.
      );
    }
  }

  void _onUnityLoaded(UnityWebController controller) {
    _unityWebController = controller;
    setState(() {});
  }
}

```

## API

- `onUnityLoaded(UnityWebController controller)` (Unity to flutter web binding and listener when unity is loaded)
- `listenMessageFromUnity(String data)` (Listen for message sent from unity to flutter web)
- `sendDataToUnity(String gameObject, String method, String data)` (Allows you to send date from flutter web to untiy)

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Samuel310/flutter_unity_widget_web/issues
