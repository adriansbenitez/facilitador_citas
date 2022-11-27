import 'package:facilitador_citas/app_container.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/screens/screen.dart';
import 'package:facilitador_citas/screens/signin/signin.dart';
import 'package:facilitador_citas/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/bloc.dart';
import 'config/config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  Color? _getMessageByType(MessageStatusType messageStatusType) {
    switch (messageStatusType) {
      case MessageStatusType.success:
        {
          return Colors.green;
        }
      case MessageStatusType.warning:
        {
          return Colors.yellow;
        }
      default:
        {
          return Colors.red;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, lang) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, theme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme.lightTheme,
                darkTheme: theme.darkTheme,
                onGenerateRoute: Routes.generateRoute,
                locale: lang,
                localizationsDelegates: const [
                  Translate.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLanguage.supportLanguage,
                home: Scaffold(
                  body: BlocListener<MessageCubit, MessageModel?>(
                    listener: (context, message) {
                      if (message != null) {
                        final snackBar = SnackBar(
                          backgroundColor:
                              _getMessageByType(message.messageStatusType),
                          content: Text(
                            Translate.of(context).translate(message.message),
                            style: const TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 30,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: BlocBuilder<ApplicationCubit, ApplicationState>(
                      builder: (context, application) {
                        if (application == ApplicationState.unauthorized) {
                          return const SignIn();
                        }
                        if (application == ApplicationState.completed) {
                          return const AppContainer();
                        }
                        if (application == ApplicationState.intro) {
                          return const Intro();
                        }
                        return const SplashScreen();
                      },
                    ),
                  ),
                ),
                builder: (context, child) {
                  final data = MediaQuery.of(context).copyWith(
                    textScaleFactor: theme.textScaleFactor,
                  );
                  return MediaQuery(
                    data: data,
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
