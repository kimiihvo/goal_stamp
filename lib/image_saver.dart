import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaver extends StatefulWidget {
  final GlobalKey imageKey;

  const ImageSaver({super.key, required this.imageKey});

  @override
  _ImageSaverState createState() => _ImageSaverState();
}

class _ImageSaverState extends State<ImageSaver> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.imageKey,
      child: Container(
          // 입력값이 들어오는 영역의 코드를 작성합니다.
          ),
    );
  }

  Future<void> saveImage() async {
    RenderRepaintBoundary boundary = widget.imageKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image =
        await boundary.toImage(pixelRatio: 3.0); // 캡처할 이미지의 해상도를 설정합니다.
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final result =
        await ImageGallerySaver.saveImage(pngBytes); // 이미지를 갤러리에 저장합니다.
    //print(result); //
    log('selectedDay: $result'); //저장된 이미지의 경로를 출력합니다.
  }
}
