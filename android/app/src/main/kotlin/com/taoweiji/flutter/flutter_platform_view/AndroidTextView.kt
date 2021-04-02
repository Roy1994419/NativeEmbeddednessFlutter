package com.taoweiji.flutter.flutter_platform_view

import android.content.Context
import android.graphics.Color
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class AndroidTextView(context: Context,binaryMessenger: BinaryMessenger) : PlatformView, MethodChannel.MethodCallHandler {
    val contentView: TextView = TextView(context)
    var methodChannel:MethodChannel ;

    override fun getView(): View {

        return contentView
    }

    init {
        methodChannel = MethodChannel(binaryMessenger,"com.taoweiji.flutter.flutter_platform_view.AndroidTextView")
        methodChannel.setMethodCallHandler(this)
    }



    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }



    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
       if(call.method.equals("setText")){
           var msg = call.argument<String>("msg")
           contentView.setText(msg)
           Toast.makeText(contentView.context,"收到了flutter的消息：$msg",0).show()
           methodChannel.invokeMethod("reresult","123453332$msg")
       }

    }


}