import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Download {
  static Future<void> downloadVideo(String url) async {
    final dir = await getTemporaryDirectory();
    final path = "${dir.path}/video.mp4";
    await Dio().download(url, path);
  }
}
