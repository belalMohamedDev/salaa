import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:salaa/app/cubit/app_logic_cubit.dart';

import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../about/view/about_view.dart';

import '../../contact/view/contact_view.dart';
import '../../profile/view/profile_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20.0), child: AppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: Column(
            children: [
              Card(
                elevation: 10,
                color: Colors.blue[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: AppColor.grayFont, width: 0.2)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 18, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(AppStrings.accountSetting,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontSize: 16))
                            .tr(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _container(context, AppStrings.profile.tr(), Icons.person,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileView()));
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      _container(
                          context, AppStrings.payment.tr(), Icons.exit_to_app,
                          () {
                        _appPreferences.removeData();
                        //  Phoenix.rebirth(context);
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.blue[100],
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: AppColor.grayFont, width: 0.2)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppStrings.generalSetting.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AppLogicCubit, AppLogicState>(
                        builder: (context, state) {
                          return _container(
                              context, AppStrings.darkMode.tr(), Icons.light,
                              () {
                            context.read<AppLogicCubit>().changeAppTheme(null);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _container(
                          context, AppStrings.language.tr(), Icons.language,
                          () {
                        _appPreferences.changeAppLanguage();
                        restAllModule();
                         Phoenix.rebirth(context);
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                color: Colors.blue[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: AppColor.grayFont, width: 0.2)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppStrings.support,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 16),
                        ).tr(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _container(context, AppStrings.contactUs.tr(),
                          Icons.contact_phone, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactView()));
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      _container(context, AppStrings.aboutAs.tr(), Icons.info,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutAs()));
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _container(
      context, String name, IconData icon, GestureTapCallback function) {
    return GestureDetector(
      onTap: function,
      child: Card(
        color: AppColor.darkBG3,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(
                width: 20,
              ),
              Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12, color: AppColor.white)),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 15, color: AppColor.white),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
