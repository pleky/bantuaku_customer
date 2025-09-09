import 'dart:ui';

import 'package:bantuaku_customer/firebase_options.dart';
import 'package:bantuaku_customer/utils/firebase_notification_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'constants/constants.dart';
import 'extensions/build_context_extension.dart';
import 'features/common/ui/providers/app_theme_mode_provider.dart';
import 'features/common/ui/widgets/offline_container.dart';
import 'routing/router.dart';
import 'utils/provider_observer.dart';

Future<void> initPlatformState() async {
  try {
    // await Purchases.setLogLevel(LogLevel.debug);

    // final configuration = PurchasesConfiguration(
    //   Platform.isIOS ? Env.revenueCatAppStore : Env.revenueCatPlayStore,
    // );
    // await Purchases.configure(configuration);
  } on PlatformException catch (e) {
    debugPrint('${Constants.tag} [initPlatformState] Error: ${e.message}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseNotificationService().init();
  await FirebaseAnalytics.instance.logAppOpen();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// Supabase
  // await Supabase.initialize(
  //   url: Env.supabaseUrl,
  //   anonKey: Env.supabaseAnonKey,
  // );

  /// Mobile ads
  // MobileAds.instance.initialize();

  /// RevenueCat
  await initPlatformState();

  /// Localization
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [AppObserver()],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      theme: context.lightTheme,
      darkTheme: context.darkTheme,
      themeMode: themeMode.value,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return OfflineContainer(child: child);
      },
    );
  }
}
