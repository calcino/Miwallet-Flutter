package com.calcino.fluttermiwallet


import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.imagepicker.ImagePickerPlugin


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ImagePickerPlugin.registerWith(
                registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"))
    }

}