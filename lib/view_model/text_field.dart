import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final double width;

  final StateProvider<int> provider;

  const CustomTextField(
      {super.key, required this.width, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      child: TextField(
        enabled: true,
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (text) {
          ref.read(provider.notifier).state = int.parse(text);
        },
      ),
    );
  }
}
