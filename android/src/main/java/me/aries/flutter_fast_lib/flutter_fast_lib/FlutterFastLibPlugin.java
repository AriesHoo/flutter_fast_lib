package me.aries.flutter_fast_lib.flutter_fast_lib;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Intent;
import android.content.Context;
import android.app.Activity;

/**
 * FlutterFastLibPlugin
 */
public class FlutterFastLibPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context mContext;
    private Activity mActivity;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_fast_lib");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("navigateToSystemHome")) {//返回系统首页
            Intent intent = new Intent();// 创建Intent对象
            intent.setAction(Intent.ACTION_MAIN);// 设置Intent动作
            intent.addCategory(Intent.CATEGORY_HOME);// 设置Intent种类
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);//标记
            mContext.startActivity(intent);
        } else if (call.method.equals("isSupportStatusBarFontChange")) {//是否支持系统状态栏文字颜色变化
            result.success(StatusBarUtil.isSupportStatusBarFontChange());
        } else if (call.method.equals("setStatusBarLightMode")) {//设置状态栏亮色-黑色字体
            result.success(StatusBarUtil.setStatusBarLightMode(mActivity));
        } else if (call.method.equals("setStatusBarDarkMode")) {//设置状态栏暗色-白色字体
            result.success(StatusBarUtil.setStatusBarDarkMode(mActivity));
        } else if (call.method.equals("isSupportNavigationBarFontChange")) {//是否支持系统导航栏文字颜色变化
            result.success(NavigationBarUtil.isSupportNavigationBarFontChange());
        } else if (call.method.equals("setNavigationBarLightMode")) {//设置导航栏亮色-黑色字体
            result.success(NavigationBarUtil.setNavigationBarLightMode(mActivity));
        } else if (call.method.equals("setNavigationBarDarkMode")) {//设置导航栏暗色-白色字体
            result.success(NavigationBarUtil.setNavigationBarDarkMode(mActivity));
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        mActivity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        mActivity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {

    }
}
