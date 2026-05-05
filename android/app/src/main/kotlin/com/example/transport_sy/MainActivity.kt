package com.example.transport_sy

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "nfc_emulator"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {
                    "setNfcValue" -> {
                        val value = call.argument<String>("value")

                        if (value != null) {
                            MyHostApduService.nfcValue = value
                            result.success("OK")
                        } else {
                            result.error("INVALID", "Value is null", null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }
}