plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace = "com.example.salon_manager"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.salon_manager"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
        multiDexEnabled = true
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("debug") // برای بیلد سریع
        }
    }
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
}
