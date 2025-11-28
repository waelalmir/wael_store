plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // السطر الذي أضفناه لتطبيق إضافة خدمات جوجل
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.ecommerce"
    // تم رفع الإصدار بناءً على طلب الحزم الجديدة
    compileSdk = 36 
    // تم رفع الإصدار بناءً على طلب الحزم الجديدة
   // ndkVersion = "26.1.10909125"
    ndkVersion = "29.0.14206865"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.ecommerce"
        minSdk = flutter.minSdkVersion
        targetSdk = 34 // يمكن ترك هذا كما هو أو رفعه إلى 36، كلاهما سيعمل
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // أعدنا إضافة هذه الاعتمادية التي احتجناها سابقًا
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
