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

// Private, ignored signing configuration. Release builds must never silently
// fall back to the development debug key.
val releaseSigningFile = rootProject.file("key.properties")
val releaseSigningProperties = Properties().apply {
    if (releaseSigningFile.isFile) {
        releaseSigningFile.inputStream().use { load(it) }
    }
}
val releaseRequested = gradle.startParameter.taskNames.any {
    it.contains("release", ignoreCase = true)
}
if (releaseRequested) {
    require(releaseSigningFile.isFile) {
        "Android release signing is missing: configure android/key.properties."
    }
    for (key in listOf("storeFile", "storePassword", "keyAlias", "keyPassword")) {
        require(!releaseSigningProperties.getProperty(key).isNullOrBlank()) {
            "Android release signing property is missing: $key"
        }
    }
    require(rootProject.file(releaseSigningProperties.getProperty("storeFile")).isFile) {
        "Android release keystore does not exist."
    }
    val releaseAuth0Domain = providers.gradleProperty("MARKEI_AUTH0_DOMAIN").orNull
    require(!releaseAuth0Domain.isNullOrBlank() && !releaseAuth0Domain.endsWith(".invalid")) {
        "Set MARKEI_AUTH0_DOMAIN for the Android release manifest."
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

    signingConfigs {
        if (releaseSigningFile.isFile) {
            create("release") {
                storeFile = rootProject.file(releaseSigningProperties.getProperty("storeFile"))
                storePassword = releaseSigningProperties.getProperty("storePassword")
                keyAlias = releaseSigningProperties.getProperty("keyAlias")
                keyPassword = releaseSigningProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
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
