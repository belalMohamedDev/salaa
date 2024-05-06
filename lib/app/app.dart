import 'package:flutter/material.dart';

import 'package:salaa/app/app_prefs.dart';
import 'package:salaa/app/cubit/app_logic_cubit.dart';
import 'package:salaa/presentation/home/view/home_view.dart';

import '../presentation/base/viewModel/home_view_model.dart';
import '../presentation/categories/view/categories_view.dart';
import '../presentation/categoryDetails/view/category_details_view.dart';
import '../presentation/common/provider/bloc_provider.dart';
import '../presentation/common/provider/bloc_provider_tree.dart';
import '../presentation/contact/view/contact_view.dart';
import '../presentation/favorites/view/favorites_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/resource/dark_theme_manger.dart';
import '../presentation/resource/light_theme_manger.dart';
import '../presentation/resource/route_manger.dart';
import '../presentation/salla/view/salla_view.dart';
import '../presentation/search/view_model.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //privet named constructor

  static const MyApp _instance =
      MyApp._internal(); //singleton or single _instance
  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //factory
  final AppPreferences appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    appPreferences
        .getLocalAppLanguage()
        .then((value) => {context.setLocale(value)});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: <BlocProviderApp>[
          BlocProviderApp<HomeViewModel>(
              bloc: instance<HomeViewModel>(), child: const HomeView()),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const CategoriesView(),
          ),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const FavoritesView(),
          ),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const CategoryDetailsView(),
          ),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const SearchView(),
          ),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const ContactView(),
          ),
          BlocProviderApp<HomeViewModel>(
            bloc: instance<HomeViewModel>(),
            child: const SallaView(),
          ),
        ],
        child: BlocProvider(
          create: (context) => instance<AppLogicCubit>()
            ..changeAppTheme(appPreferences.getDark()),
          child: BlocBuilder<AppLogicCubit, AppLogicState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splashRoute,
                onGenerateRoute: RouteGenerator.getRoute,
                theme: getApplicationTheme(),
                darkTheme: getApplicationDarkTheme(),
                themeMode: context.read<AppLogicCubit>().isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ));
  }
}
