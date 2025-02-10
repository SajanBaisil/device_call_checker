// Package declaration
package com.example.device_call_checker

// Import necessary Android and Flutter classes
import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.telephony.TelephonyManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Plugin class for checking device call state in a Flutter application.
 */
class DeviceCallCheckerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  // Channel for communication between Flutter and native code
  private lateinit var channel: MethodChannel
  // Context of the application
  private lateinit var context: Context
  // Activity reference, can be null
  private var activity: Activity? = null

  companion object {
    // Request code for permission request
    private const val REQUEST_CODE = 1001
  }

  /**
   * Called when the plugin is attached to the Flutter engine.
   * @param binding FlutterPlugin.FlutterPluginBinding instance
   */
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "device_call_checker")
    channel.setMethodCallHandler(this)
  }

  /**
   * Called when the plugin is detached from the Flutter engine.
   * @param binding FlutterPlugin.FlutterPluginBinding instance
   */
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  /**
   * Called when the plugin is attached to an activity.
   * @param binding ActivityPluginBinding instance
   */
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  /**
   * Called when the plugin is detached from an activity.
   */
  override fun onDetachedFromActivity() {
    activity = null
  }

  /**
   * Called when the plugin is reattached to an activity after a configuration change.
   * @param binding ActivityPluginBinding instance
   */
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  /**
   * Called when the plugin is detached from an activity for a configuration change.
   */
  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  /**
   * Handles method calls from Flutter.
   * @param call MethodCall instance
   * @param result MethodChannel.Result instance
   */
  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "isDeviceInCall" -> result.success(isDeviceInCall())
      else -> result.notImplemented()
    }
  }

  /**
   * Checks if the app has the necessary permission.
   * @return Boolean indicating if the permission is granted
   */
  private fun hasPermission(): Boolean {
    return ContextCompat.checkSelfPermission(
      context,
      Manifest.permission.READ_PHONE_STATE
    ) == PackageManager.PERMISSION_GRANTED
  }

  /**
   * Requests the necessary permission from the user.
   * @param result MethodChannel.Result instance
   */
  private fun requestPermission(result: MethodChannel.Result) {
    activity?.let {
      ActivityCompat.requestPermissions(
        it,
        arrayOf(Manifest.permission.READ_PHONE_STATE),
        REQUEST_CODE
      )
    } ?: run {
      result.error("NO_ACTIVITY", "Activity is null", null)
    }
  }

  /**
   * Checks if the device is currently in a call.
   * @return Boolean indicating if the device is in a call
   */
  private fun isDeviceInCall(): Boolean {
    return try {
      val telephonyManager =
        context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
      telephonyManager?.let {
        it.callState != TelephonyManager.CALL_STATE_IDLE
      } ?: false
    } catch (e: Exception) {
      false
    }
  }
}
