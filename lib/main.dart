import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sarmad/api/api_manager.dart';
import 'package:sarmad/api/base/base_api_manager.dart';
import 'package:sarmad/api/environments/environment.dart';
import 'package:sarmad/bloc/lang/language_cubit.dart';
import 'package:sarmad/prefs/pref_manager.dart';
import 'package:sarmad/ui/screens/home/bloc/home_bloc.dart';
import 'package:sarmad/ui/screens/home/bloc/home_repo.dart';
import 'package:sarmad/ui/screens/home/home_screen.dart';
import 'package:sarmad/ui/screens/splash_screen/splash_screen.dart';
import 'package:sarmad/util/lang/app_localization.dart';
import 'package:sarmad/util/theme/app_theme.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// choose which environment (Stg -- prod -- dev)
  /// this will changes the keys in (apiKey file)

  Environment.init(envType: EnvType.prod);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const SarmadApp());
}

class SarmadApp extends StatelessWidget {
  const SarmadApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
            create: (BuildContext context) => LanguageCubit()),
        BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(HomeRepo(
                apiManager: ApiManager(DioApiManager(PrefManager()))))),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, localeState) {
          return MaterialApp(
            title: 'Sarmad',
            theme: AppTheme(localeState).themeDataLight,
            debugShowCheckedModeBanner: false,

            /// the list of our supported locals for our app
            /// currently we support only 2 English, Arabic ...
            supportedLocales: AppLocalizations.supportLocales,

            /// these delegates make sure that the localization data for the proper
            /// language is loaded ...
            localizationsDelegates: const [
              /// this for selecting the county localization
              CountryLocalizations.delegate,

              /// A class which loads the translations from JSON files
              AppLocalizations.delegate,

              /// Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,

              /// Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,

              GlobalCupertinoLocalizations.delegate,
            ],

            /// Returns a locale which will be used by the app
            localeResolutionCallback: AppLocalizations.localeResolutionCallback,
            locale: localeState,
            home: const SplashScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => const SplashScreen(),
              HomeScreen.routeName: (ctx) => const HomeScreen()
            },
          );
        },
      ),
    );
  }
}
