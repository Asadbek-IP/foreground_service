package com.example.foreground_service

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "service_channel").setMethodCallHandler {
            // Note: this method is invoked on the main thread.
                call, result ->
            when (call.method) {
                "startExampleService" -> {
                    startService(Intent(this, MyService::class.java))
                    result.success("Started!")
                }
                "stopExampleService" -> {
                    stopService(Intent(this, MyService::class.java))
                    result.success("Stopped!")
                }
                "checkServiceRunning" -> {
                    result.success(MyService.serviceRunning)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
