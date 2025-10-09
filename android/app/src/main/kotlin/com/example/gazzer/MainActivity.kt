package com.az.gazzer

import android.content.Context
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.gazzer/device_state"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "isAirplaneModeOn" -> {
                    try {
                        val isAirplaneMode = isAirplaneModeOn(this)
                        result.success(isAirplaneMode)
                    } catch (e: Exception) {
                        result.error(
                            "AIRPLANE_MODE_ERROR",
                            "Could not check airplane mode",
                            e.message
                        )
                    }
                }

                "hasSimCard" -> {
                    try {
                        val hasSim = hasSimCard(this)
                        result.success(hasSim)
                    } catch (e: Exception) {
                        result.error("SIM_CARD_ERROR", "Could not check SIM card", e.message)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    /**
     * Check if airplane mode is enabled
     */
    private fun isAirplaneModeOn(context: Context): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.AIRPLANE_MODE_ON,
                0
            ) != 0
        } else {
            @Suppress("DEPRECATION")
            Settings.System.getInt(
                context.contentResolver,
                Settings.System.AIRPLANE_MODE_ON,
                0
            ) != 0
        }
    }

    /**
     * Check if device has a SIM card
     */
    private fun hasSimCard(context: Context): Boolean {
        return try {
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val simState = telephonyManager.simState

            // Check if SIM card is present and ready
            simState != TelephonyManager.SIM_STATE_ABSENT &&
                    simState != TelephonyManager.SIM_STATE_UNKNOWN
        } catch (e: Exception) {
            // If we can't determine, assume SIM is present
            true
        }
    }
}
