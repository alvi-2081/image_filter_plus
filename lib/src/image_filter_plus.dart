import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_filter_plus/src/entities/filter_matrix.dart';
import 'package:image_filter_plus/src/entities/filter_preset.dart';

class ImageFilterPlus {
  static List<FilterPreset> getFilters() {
    return [
      FilterPreset(name: 'Normal', filterMatrix: FilterMatrix.normal),
      FilterPreset(name: 'Nashville', filterMatrix: FilterMatrix.nashville),
      FilterPreset(name: 'Toaster', filterMatrix: FilterMatrix.toaster),
      FilterPreset(name: 'Clarendon', filterMatrix: FilterMatrix.clarendon),
      FilterPreset(name: 'Chrome', filterMatrix: FilterMatrix.chrome),
      FilterPreset(name: 'Fade', filterMatrix: FilterMatrix.fade),
      FilterPreset(name: 'Instant', filterMatrix: FilterMatrix.instant),
      FilterPreset(name: 'Mono', filterMatrix: FilterMatrix.mono),
      FilterPreset(name: 'Noir', filterMatrix: FilterMatrix.noir),
      FilterPreset(name: 'Tonal', filterMatrix: FilterMatrix.tonal),
      FilterPreset(name: 'Transfer', filterMatrix: FilterMatrix.transfer),
      FilterPreset(name: 'Tone', filterMatrix: FilterMatrix.tone),
      FilterPreset(name: 'Linear', filterMatrix: FilterMatrix.linear),
      FilterPreset(name: 'Sepia', filterMatrix: FilterMatrix.sepia),
      FilterPreset(name: 'Greyscale', filterMatrix: FilterMatrix.greyscale),
      FilterPreset(name: 'Vintage', filterMatrix: FilterMatrix.vintage),
      FilterPreset(name: 'Sweet', filterMatrix: FilterMatrix.sweet),
    ];
  }

  static Future<Uint8List> applyFilterAndConvertToUint8List(
      {required Uint8List uint8ListImage, required FilterPreset filter}) async {
    if (filter.name == "Normal") {
      return uint8ListImage;
    } else {
      // Convert Uint8List to ui.Image
      final codec = await ui.instantiateImageCodec(uint8ListImage);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Apply the color filter
      final paint = Paint()
        ..colorFilter = ColorFilter.matrix(filter.filterMatrix);

      // Draw the image on the canvas
      // final Size size = Size(image.width.toDouble(), image.height.toDouble());
      canvas.drawImage(image, Offset.zero, paint);

      // End recording and get the image
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);

      // Convert the image to Uint8List
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    }
  }
}
