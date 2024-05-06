import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:salaa/presentation/login/viewModel/login_cubit.dart';
import 'package:salaa/presentation/resource/app_size.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/image_manger.dart';
import 'package:salaa/presentation/resource/input_validator.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';

import '../../common/stateRenderer/state_renderer_impl.dart';
import '../../resource/route_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  _bins() {
    _userEmail.addListener(() {
      BlocProvider.of<LoginCubit>(context).setEmailId(_userEmail.text);
    });
    _userPassword.addListener(() {
      BlocProvider.of<LoginCubit>(context).setPassword(_userPassword.text);
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(AppJson.login, height: 200),
                  Text(
                    AppStrings.loginNow,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 30),
                  ).tr(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppStrings.loginNowHotOff,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 15),
                  ).tr(),
                  const SizedBox(
                    height: AppSizeMange.s40,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: InputValidator.isEmailValid,
                    controller: _userEmail,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.email, size: AppSizeMange.s18),
                      labelText: AppStrings.emailAddress.tr(),
                      hintText: AppStrings.emailAddress.tr(),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizeMange.s20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _userPassword,
                    validator: InputValidator.isPasswordValid,
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
                  BlocListener<LoginCubit, LoginState>(
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
                          BlocProvider.of<LoginCubit>(context)
                              .appPreferences
                              .setLoginScreenView();
                          BlocProvider.of<LoginCubit>(context)
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
                            //  _viewModel.login();
                            BlocProvider.of<LoginCubit>(context).login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppPaddingSizeMange.p12)),
                        ),
                        child: const Text(
                          AppStrings.loginNow,
                        ).tr(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text.rich(
                      TextSpan(
                          text: AppStrings.notHaveAccount.tr(),
                          style: const TextStyle(fontSize: 15),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(
                                      context, Routes.register),
                                text: AppStrings.signUpNotHave.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: 15, color: AppColor.darkBG3))
                          ]),
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(
                    height: AppPaddingSizeMange.p50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
