import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class HMSSDKInteractor {
  late HMSSDK hmsSDK;

  HMSSDKInteractor() {
    hmsSDK = HMSSDK();
    hmsSDK.build();
  }

  void addPreviewListener(HMSPreviewListener listener) {
    hmsSDK.addPreviewListener(listener: listener);
  }

  void addUpdateListener(HMSUpdateListener listener) {
    hmsSDK.addUpdateListener(listener: listener);
  }
}
