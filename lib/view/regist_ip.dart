import 'package:flutter/material.dart';
import 'package:hand_sign_detect_app/provider/ip.dart';
import 'package:hand_sign_detect_app/view/camera_screen.dart';
import 'package:hand_sign_detect_app/view_model/text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegistIP extends HookConsumerWidget {
  const RegistIP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final double fieldSize = size.width * 0.17;

    final url = ref.watch(urlProvider);

    return Center(
      child: Column(
        children: [
          const Text("現在のIPアドレス"),
          const SizedBox(height: 20),
          Text(url),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                CustomTextField(
                  width: fieldSize,
                  provider: newFirstIpProvider,
                ),
                const Text("."),
                CustomTextField(
                  width: fieldSize,
                  provider: newSecondIpProvider,
                ),
                const Text("."),
                CustomTextField(
                  width: fieldSize,
                  provider: newThirdIpProvider,
                ),
                const Text("."),
                CustomTextField(
                  width: fieldSize,
                  provider: newFourceIpProvider,
                ),
                const Text(":"),
                CustomTextField(
                  width: fieldSize,
                  provider: newPortProvider,
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
            onPressed: () {
              ref.read(urlProvider.notifier).state =
                  "${ref.watch(newFirstIpProvider)}.${ref.watch(newSecondIpProvider)}.${ref.watch(newThirdIpProvider)}.${ref.watch(newFourceIpProvider)}:${ref.watch(newPortProvider)}";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CameraScreen()));
            },
            child: const Text('登録'),
          ),
        ],
      ),
    );
  }
}
