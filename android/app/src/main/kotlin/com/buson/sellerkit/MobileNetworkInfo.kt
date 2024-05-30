// MobileNetworkInfo.kt
package com.busondigitalservice.sellerkit

import android.content.Context
import android.telephony.TelephonyManager

class MobileNetworkInfo(private val context: Context) {
    fun getMobileNetworkName(): String? {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return telephonyManager.networkOperatorName
    }
    
}
