import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val markeiDbaProperties = Properties().apply {
    val propertiesFile =
        rootProject.projectDir.parentFile.resolve(".markei_dba_gradle.properties")
    if (propertiesFile.isFile) {
        propertiesFile.inputStream().use { load(it) }
    }
}

android {
    namespace = "com.gusigu.markei"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.gusigu.markei"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        val debugAuth0Domain =
            markeiDbaProperties.getProperty("MARKEI_AUTH0_DOMAIN")
                ?.trim()
                ?.takeIf { it.isNotEmpty() }
                ?: "auth0.example.invalid"
        manifestPlaceholders["auth0Domain"] =
            providers.gradleProperty("MARKEI_AUTH0_DOMAIN")
                .orElse(debugAuth0Domain)
                .get()
        manifestPlaceholders["auth0Scheme"] = "https"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
