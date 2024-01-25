import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_sign_detect_app/provider/ip.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:hand_sign_detect_app/infrastructure/predict.dart';
import 'package:hand_sign_detect_app/provider/controller.dart';
import 'package:hand_sign_detect_app/provider/initialized.dart';
import 'package:hand_sign_detect_app/provider/response.dart';

class CameraScreen extends HookConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraControllerFuture = ref.watch(controllerProvider);

    // iosのシャッター音を消すためのダミーcallback

    // コントローラーの状態を管理するためのuseStateフック
    final cameraController = useState<CameraController?>(null);

    useEffect(() {
      bool isCancelled = false;
      Timer timer = Timer.periodic(const Duration(microseconds: 1), (timer) {});

      // 非同期処理を実行
      Future<void> initializeCamera() async {
        try {
          // プロバイダからカメラコントローラーを取得
          final controller = await cameraControllerFuture;
          // コントローラーがキャンセルされていなければ状態を更新
          if (!isCancelled) {
            await controller.initialize();
            cameraController.value = controller;
            timer =
                Timer.periodic(const Duration(microseconds: 1), (timer) async {
              controller.value.isInitialized;
              final XFile image = await controller.takePicture();
              var response = await ResortechRepository.postImage(
                  image.path, ref.watch(urlProvider));
              ref.read(responseProvider.notifier).state = response.body;
            });
          }
        } catch (e) {
          if (!isCancelled) {}
        }
      }

      // カメラ初期化処理を呼び出す
      initializeCamera();

      // クリーンアップ関数
      return () {
        isCancelled = true;
        cameraController.value?.dispose();
        timer.cancel();
      };
    }, const []);

    if (ref.watch(initializedProvider) || cameraController.value == null) {
      return const CircularProgressIndicator();
    }

    final controller = cameraController.value!;
    return Column(
      children: <Widget>[
        if (controller.value.isInitialized)
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: CameraPreview(controller),
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Text(ref.watch(responseProvider)),
        ),
      ],
    );
  }
}
