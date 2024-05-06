import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salaa/presentation/resource/app_size.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/image_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../resource/route_manger.dart';

class WelcomeView extends StatelessWidget {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, top: 120, right: 35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: FadeInLeftBig(
                      duration: const Duration(seconds: 1),
                      child: Lottie.asset(AppJson.choice, height: 150)),
                ),
                const SizedBox(height: 20),
                Text(AppStrings.welcome.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 28)),
                const SizedBox(height: 70),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                        _appPreferences.setWelcomeScreenView();
                      },
                      child: Text(AppStrings.login,
                              style: Theme.of(context).textTheme.displayMedium)
                          .tr(),
                    )),
                const SizedBox(height: 25),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.darkGrayFont),
                        onPressed: () {
                          _appPreferences.setWelcomeScreenView();
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.login);
                        },
                        child: Text(AppStrings.signUp,
                                style:
                                    Theme.of(context).textTheme.displayMedium)
                            .tr())),
                const SizedBox(height: AppSizeMange.s60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
