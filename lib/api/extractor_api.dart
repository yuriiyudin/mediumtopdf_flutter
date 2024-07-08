import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medium_extractor_frontend/api/constant.dart';
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class ExtractorApi {
  Future<void> downloadPdf(BuildContext context, String link) async {
    dynamic bytes;
    try {
      Dio dio = Dio();
      final res = await dio.post(
        apiRoute,
        data: {'link': link},
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      bytes = res.data;
    } catch (e) {
      return;
    }

    if (bytes != null) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final uid = Uuid().v4();
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = '$uid.pdf';
      html.document.body!.children.add(anchor);

// download
      anchor.click();

// cleanup
      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } else {
      return;
    }
  }
}
