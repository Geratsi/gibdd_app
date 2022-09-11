package ru.caronline.app;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import com.yandex.mapkit.MapKitFactory;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        MapKitFactory.setApiKey("bcd1660e-13dd-48df-8b47-eb5a19928d85");
        super.configureFlutterEngine(flutterEngine);
    }
}
