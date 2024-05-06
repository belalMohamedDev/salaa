import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:salaa/app/cubit/app_logic_cubit.dart';
import 'package:salaa/presentation/onBoarding/viewModel/view_model_on.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../domain/model/onBoarding/on_boarding_model.dart';
import '../../resource/route_manger.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) => _GetContent(
        data: snapshot.data,
        viewModel: _viewModel,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class _GetContent extends StatelessWidget {
  _GetContent({
    required this.viewModel,
    this.data,
  });
  final OnBoardingViewModel viewModel;
  final SliderViewObject? data;

  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    } else {
      return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  _appPreferences.setOnBoardingScreenView();
                  Navigator.pushReplacementNamed(context, Routes.choiceRoute);
                },
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 15),
                ).tr(),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: PageView.builder(
              controller: data?.pageController,
              itemCount: data?.numberOfSlides,
              onPageChanged: (index) => viewModel.onPageChanged(index),
              itemBuilder: (context, index) {
                return ColumnData(sliderObject: data?.list[index]);
              }),
          bottomSheet: BlocBuilder<AppLogicCubit, AppLogicState>(
            builder: (context, state) {
              return Container(
                height: data!.last ? 220 : 230,
                width: double.infinity,
                color: context.read<AppLogicCubit>().isDarkMode
                    ? AppColor.dark
                    : AppColor.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                        controller: data!.pageController,
                        count: data!.numberOfSlides,
                        effect: ScrollingDotsEffect(
                            activeDotColor: AppColor.darkBG3,
                            dotHeight: 5,
                            dotColor: AppColor.grayFont)),
                    Padding(
                      padding: EdgeInsets.only(bottom: data!.last ? 60 : 80),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Stack(
                          children: [
                            SizedBox(
                                height: 85,
                                width: 85,
                                child: CircularProgressIndicator(
                                  color: data!.last
                                      ? Colors.green
                                      : context.read<AppLogicCubit>().isDarkMode
                                          ? AppColor.grayFont
                                          : AppColor.darkBG3,
                                  strokeWidth: 5,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FloatingActionButton(
                                onPressed: () => viewModel.goNext(context),
                                backgroundColor: data!.last
                                    ? Colors.green
                                    : AppColor.darkBG3,
                                child: data!.last
                                    ? Icon(
                                        Icons.check_outlined,
                                        color: AppColor.white,
                                      )
                                    : Icon(Icons.arrow_forward,
                                        color: AppColor.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ));
    }
  }
}

class ColumnData extends StatelessWidget {
  final SliderObject? sliderObject;
  const ColumnData({super.key, this.sliderObject});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset("${sliderObject?.image}", height: 350),
          const SizedBox(
            height: 35,
          ),
          Text(
            "${sliderObject?.title}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
            child: Text(
              "${sliderObject?.subTitle}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
