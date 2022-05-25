abstract class UnityWebController {
  void sendDataToUnity({
    required String gameObject,
    required String method,
    required String data,
  });

  void dispose();
}
