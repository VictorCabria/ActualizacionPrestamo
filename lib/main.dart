import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prestamo_mc_2_0/app/services/firebase_services/auth_services.dart';
import 'package:prestamo_mc_2_0/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(
    ResponsiveSizer(builder: (context, orientation, screenType) {
      return const MyApp();
    }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? setInitialRoute() {
      var firebaseUser = auth.getCurrentUser();

      if (firebaseUser != null) {
        return Routes.HOME;
      } else {
        // return AppPages.INITIAL;
        return AppPages.INITIAL;
      }
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
       color: Palette.primary,
      initialRoute: setInitialRoute(),
      getPages: AppPages.routes,
      localizationsDelegates: const [
         GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
      ],
      locale: const Locale('es'), // Spanish
    );
  }
}
