import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/blocs/list/cubit.dart';
import 'package:facilitador_citas/blocs/user/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final languageCubit = LanguageCubit();
  static final themeCubit = ThemeCubit();
  static final messageCubit = MessageCubit(null);
  static final homeCubit = HomeCubit();
  static final authenticationCubit = AuthenticationCubit();
  static final loginCubit = LoginCubit();
  static final userCubit = UserCubit();
  static final searchCubit = SearchCubit();
  static final listCubit = ListCubit();
  static final locationCubit = LocationCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<LanguageCubit>(
      create: (context) => languageCubit,
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
    ),
    BlocProvider<MessageCubit>(
      create: (context) => messageCubit,
    ),
    BlocProvider<HomeCubit>(
      create: (context) => homeCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticationCubit,
    ),
    BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    BlocProvider<SearchCubit>(
      create: (context) => searchCubit,
    ),
    BlocProvider<ListCubit>(
      create: (context) => listCubit,
    ),
    BlocProvider<LocationCubit>(
      create: (context) => locationCubit,
    )
  ];

  static void dispose() {
    applicationCubit.close();
    languageCubit.close();
    themeCubit.close();
    messageCubit.close();
    homeCubit.close();
    authenticationCubit.close();
    userCubit.close();
    listCubit.close();
    locationCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
