import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class SplashPage extends StatefulWidget {
  static String path = "/SplashPage";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> readNFC() async {
    try {
      // wait for tag
      var tag = await FlutterNfcKit.poll();

      // check if it has NDEF
      if (tag.ndefAvailable == true) {
        var records = await FlutterNfcKit.readNDEFRecords();

        for (var record in records) {
          print(record.payload);
        }
      } else {
        print("No NDEF data please try again later");
      }

      await FlutterNfcKit.finish();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     readNFC();
              //   },
              //   child: Text("data"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     FlutterNfcKit.finish();
              //   },
              //   child: Text("cancel"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
