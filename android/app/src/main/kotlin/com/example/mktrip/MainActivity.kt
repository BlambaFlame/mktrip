package com.example.mktrip

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("4b206f61-6eb9-4a6b-9fc3-f2d1447ae18c")
        super.configureFlutterEngine(flutterEngine)
    }
}