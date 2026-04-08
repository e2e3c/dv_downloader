import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:vibration/vibration.dart';
import '../services/download.dart';
import '../ads/interstitial.dart';
import 'player.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final controller = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadAd();
    autoPaste();
  }

  void autoPaste() async {
    String text = await FlutterClipboard.paste();
    if (text.contains("http")) {
      controller.text = text;
    }
  }

  Future<void> download() async {
    if (controller.text.isEmpty) return;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }

    setState(() => loading = true);

    showAd();

    await Download.downloadVideo(controller.text);

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم التحميل 📥")),
    );
  }

  void openPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Player(url: controller.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DV Downloader")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Paste video link...",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : download,
              child: loading
                  ? CircularProgressIndicator()
                  : Text("تحميل 🚀"),
            ),

            ElevatedButton(
              onPressed: openPlayer,
              child: Text("تشغيل 🎬"),
            ),
          ],
        ),
      ),
    );
  }
}
