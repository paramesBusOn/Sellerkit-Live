package com.busondigitalservice.sellerkit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity;

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.telephony.TelephonyManager

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val mobileNetworkInfo = MobileNetworkInfo(applicationContext)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "your_channel_name")

        channel.setMethodCallHandler { call, result ->
            if (call.method == "getMobileNetworkName") {
                result.success(mobileNetworkInfo.getMobileNetworkName())
            } else {
                result.notImplemented()
            }
        }
    }
}

