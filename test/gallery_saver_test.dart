import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('gallery_saver');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'saveImage':
          return true;
        case 'saveVideo':
          return false;
      }
      return 'unknown method';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('save image', () async {
    expect(await GallerySaver.saveImage('/storage/emulated/image.jpg'), true);
  });

  test('save video', () async {
    expect(await GallerySaver.saveVideo('/storage/emulated/video.mov'), false);
  });
}
