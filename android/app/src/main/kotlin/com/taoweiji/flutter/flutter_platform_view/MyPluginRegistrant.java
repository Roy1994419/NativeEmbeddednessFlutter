package com.taoweiji.flutter.flutter_platform_view;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;

/**
 * desc   :
 * e-mail : 1391324949@qq.com
 * date   : 2021/4/1 15:52
 * author : Roy
 * version: 1.0
 */
public class MyPluginRegistrant  implements FlutterPlugin {
    public static void registerWith(PluginRegistry.Registrar registrar) {
        registrar
                .platformViewRegistry()
                .registerViewFactory(
                        "platform_text_view",
                        new AndroidTextViewFactory(registrar.messenger()));

    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        BinaryMessenger messenger = binding.getBinaryMessenger();
        binding
                .getPlatformViewRegistry()
                .registerViewFactory(
                        "platform_text_view", new AndroidTextViewFactory(messenger));

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }
}
