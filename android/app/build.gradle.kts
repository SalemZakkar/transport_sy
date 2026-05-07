plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.swhackathon.transport_sy"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    flavorDimensions.add("app")

    productFlavors {
        create("mainApp") {
            dimension = "app"
            applicationId = "com.swhackathon.transport_sy"
            resValue("string", "app_name", "تنقل")

            // Main app flavor configuration
            manifestPlaceholders["flavorName"] = "mainApp"
        }

        create("nfcEmulator") {
            dimension = "app"
            applicationId = "com.swhackathon.transport_sy.nfc"
            resValue("string", "app_name", "NFC Emulator")

            // NFC Emulator flavor configuration
            manifestPlaceholders["flavorName"] = "nfcEmulator"
        }
    }

    defaultConfig {
        applicationId = "com.swhackathon.transport_sy"
        minSdk = 28
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    sourceSets {
        // Main app flavor uses main.dart
        getByName("mainApp") {
            // Flutter will use lib/main.dart by default for mainApp
        }

        // NFC Emulator flavor uses main_nfc.dart
        getByName("nfcEmulator") {
            // Flutter will use lib/main_nfc.dart for nfcEmulator
        }
    }
}

flutter {
    source = "../.."
}