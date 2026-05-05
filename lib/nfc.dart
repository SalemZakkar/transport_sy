import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('nfc_emulator');

class NfcApp extends StatelessWidget {
  const NfcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NfcPage());
  }
}

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  final TextEditingController _controller = TextEditingController();
  String status = "No value set";

  Future<void> setValue() async {
    try {
      final value = _controller.text;

      if (value.isEmpty) {
        setState(() {
          status = "Enter something first";
        });
        return;
      }

      await platform.invokeMethod('setNfcValue', {'value': value});

      setState(() {
        status = "Sent: $value";
      });
    } catch (e) {
      setState(() {
        status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NFC Emulator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter value",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: setValue,
              child: const Text("Set NFC Value"),
            ),
            const SizedBox(height: 20),
            Text(status),
          ],
        ),
      ),
    );
  }
}
