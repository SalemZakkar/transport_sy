package com.swhackathon.transport_sy

import android.nfc.cardemulation.HostApduService
import android.os.Bundle

class MyHostApduService : HostApduService() {

    companion object {
        var nfcValue: String = "default"
    }

    override fun processCommandApdu(commandApdu: ByteArray?, extras: Bundle?): ByteArray {

        if (commandApdu == null) return byteArrayOf(0x6F.toByte())

        val selectApdu = byteArrayOf(
            0x00, 0xA4.toByte(), 0x04, 0x00, 0x05,
            0xF2.toByte(), 0x22, 0x22, 0x22, 0x22
        )

        val isSelect = commandApdu.contentEquals(selectApdu)

        return if (isSelect) {

            val value = nfcValue.ifEmpty { "0" }
            val data = value.toByteArray(Charsets.UTF_8)

            data + byteArrayOf(0x90.toByte(), 0x00.toByte())

        } else {
            byteArrayOf(0x6F.toByte(), 0x00.toByte())
        }
    }

    override fun onDeactivated(reason: Int) {
    }
}