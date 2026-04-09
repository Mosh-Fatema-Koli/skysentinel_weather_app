plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.skysentinel"
    compileSdk = 36
    ndkVersion = "27.0.12077973" // Match plugin requirement

    defaultConfig {
        applicationId = "com.example.skysentinel"
        minSdk = 21
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // ✅ Enable core library desugaring
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0") // your other deps
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5") // ✅ updated version
}

flutter {
    source = "../.."
}