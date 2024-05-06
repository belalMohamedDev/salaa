import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/model/aboutAs/about_as_model.dart';
import '../../base/viewModel/home_view_model.dart';
import '../../common/provider/bloc_provider.dart';
import '../../resource/color_manger.dart';
import '../../resource/image_manger.dart';

class AboutAs extends StatefulWidget {
  const AboutAs({super.key});

  @override
  State<AboutAs> createState() => _AboutAsState();
}

class _AboutAsState extends State<AboutAs> {
  late HomeViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = BlocProviderApp.of<HomeViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<AboutAsModel>(
        stream: _viewModel.outputAbout,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 60.0),
                child: Card(
                    color: AppColor.darkBG3,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Lottie.asset(AppJson.splash, height: 150),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(snapshot.data!.data!.about,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.white)),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
