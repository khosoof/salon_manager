plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "com.example.salon_manager"   // با package در Manifest یکی باشد
    compileSdk 35

    defaultConfig {
        applicationId "com.example.salon_manager"
        minSdk 23
        targetSdk 35
        versionCode 1
        versionName "1.0.0"
        multiDexEnabled true
    }

    buildTypes {
        release {
            // فعلاً برای ساخت دمو، امضا را دیباگ می‌گذاریم
            signingConfig signingConfigs.debug
            minifyEnabled false
            shrinkResources false
        }
        debug { }
    }
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
}
