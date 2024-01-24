import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newFirstIpProvider = StateProvider<int>((ref) => 0);
final newSecondIpProvider = StateProvider<int>((ref) => 0);
final newThirdIpProvider = StateProvider<int>((ref) => 0);
final newFourceIpProvider = StateProvider<int>((ref) => 0);
final newPortProvider = StateProvider<int>((ref) => 0);

final urlProvider = StateProvider((ref) => "0.0.0.0:0000");
