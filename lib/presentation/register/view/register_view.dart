import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa/presentation/common/stateRenderer/state_renderer_impl.dart';

import 'package:salaa/presentation/register/cubit/register_cubit.dart';
import 'package:salaa/presentation/resource/input_validator.dart';

import '../../resource/app_size.dart';
import '../../resource/color_manger.dart';
import '../../resource/font_manger.dart';
import '../../resource/route_manger.dart';
import '../../resource/strings_manger.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _userEmail = TextEditingController();

  final TextEditingController _userPassword = TextEditingController();

  final TextEditingController _userPhone = TextEditingController();

  final TextEditingController _userName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bins() {
    _userEmail.addListener(() {
      BlocProvider.of<RegisterCubit>(context).setEmailId(_userEmail.text);
    });
    _userPassword.addListener(() {
      BlocProvider.of<RegisterCubit>(context).setPassword(_userPassword.text);
    });

    _userName.addListener(() {
      BlocProvider.of<RegisterCubit>(context).setName(_userName.text);
    });
    _userPhone.addListener(() {
      BlocProvider.of<RegisterCubit>(context).setPhone(_userPhone.text);
    });
  }

  @override
  void initState() {
    _bins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: AppBar()),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppPaddingSizeMange.p18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.registerNow,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 25),
                ).tr(),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppStrings.registerNowHotOff,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ).tr(),
                const SizedBox(
                  height: AppSizeMange.s40,
                ),
                TextFormField(
                  validator: InputValidator.isNameValid,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _userName,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.person, size: AppSizeMange.s18),
                    labelText: AppStrings.userName.tr(),
                    hintText: AppStrings.userName.tr(),
                  ),
                ),
                const SizedBox(
                  height: AppSizeMange.s20,
                ),
                TextFormField(
                  validator: InputValidator.isEmailValid,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _userEmail,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      size: AppSizeMange.s18,
                    ),
                    labelText: AppStrings.emailAddress.tr(),
                    hintText: AppStrings.emailAddress.tr(),
                  ),
                ),
                const SizedBox(
                  height: AppPaddingSizeMange.p24,
                ),
                TextFormField(
                  validator: InputValidator.isPhoneValid,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: _userPhone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      size: AppSizeMange.s18,
                    ),
                    labelText: AppStrings.phone.tr(),
                    hintText: AppStrings.phone.tr(),
                  ),
                ),
                const SizedBox(
                  height: AppSizeMange.s20,
                ),
                TextFormField(
                  validator: InputValidator.isPasswordValid,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _userPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: AppSizeMange.s18,
                    ),
                    labelText: AppStrings.password.tr(),
                    hintText: AppStrings.password.tr(),
                  ),
                ),
                const SizedBox(
                  height: AppPaddingSizeMange.p24,
                ),
                BlocListener<RegisterCubit, RegisterState>(
                  listenWhen: (previous, current) =>
                      current is Loading ||
                      current is Success ||
                      current is Error,
                  listener: (context, state) {
                    state.whenOrNull(
                      loading: (flowStat) {
                        flowStat.getScreenWidget(
                            context: context, retryActionFunction: () {});
                      },
                      error: (flowStat) {
                        flowStat.getScreenWidget(
                            context: context, retryActionFunction: () {});
                      },
                      success: (userData) async {
                        Navigator.of(context).pop();
                        BlocProvider.of<RegisterCubit>(context)
                            .appPreferences
                            .setLoginScreenView();
                        BlocProvider.of<RegisterCubit>(context)
                            .appPreferences
                            .setDataScreenData(
                                tokenValue: userData.data!.token,
                                nameValue: userData.data!.name,
                                phoneValue: userData.data!.phone,
                                imageValue: userData.data!.image,
                                email: userData.data!.email,
                                id: userData.data!.id);
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.bottomNavBarRoute);
                      },
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).register();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppPaddingSizeMange.p12)),
                      ),
                      child: const Text(
                        AppStrings.registerNow,
                      ).tr(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text.rich(
                    TextSpan(
                        text: AppStrings.alreadyHaveAccount.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 15),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacementNamed(
                                    context, Routes.login),
                              text: AppStrings.loginNotHave.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: FontSizeManger.s18,
                                      color: AppColor.darkBG3))
                        ]),
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
