import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/model/home/category.dart';
import '../../base/viewModel/home_view_model.dart';
import '../../categoryDetails/view/category_details_view.dart';
import '../../common/provider/bloc_provider.dart';

import '../../resource/app_size.dart';
import '../../resource/color_manger.dart';
import '../../resource/image_manger.dart';
import '../../resource/strings_manger.dart';
import '../../search/view_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView>
    with AutomaticKeepAliveClientMixin {
  late HomeViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = BlocProviderApp.of<HomeViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: Lottie.asset(AppJson.splash),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: const Text(AppStrings.salla).tr(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchView()));
              },
              icon: const Icon(Icons.search)),
          const SizedBox(width: AppSizeMange.s10),
        ],
      ),
      body: StreamBuilder<CategoryModel>(
        stream: _viewModel.outputCategoryData,
        builder: (context, snapshot) {
          return _getCategory(snapshot.data);
        },
      ),
    );
  }

  Widget _getCategory(CategoryModel? data) {
    if (data != null) {
      return Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 25, right: 25),
          child: GridView.count(
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 0.5,
            childAspectRatio: 0.8,
            children: List.generate(
              data.data!.data!.length,
              (index) => GestureDetector(
                onTap: () async {
                  _viewModel.getCategoryData(data.data!.data![index].id);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailsView(),
                      ));
                },
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                              width: 1.5, color: AppColor.lightGrey)),
                      elevation: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: data.data!.data![index].image,
                            height: 150,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      data.data!.data![index].name,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 12),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ));
    } else {
      return const GridViewCategoryLoadeShimmer();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class GridViewCategoryLoadeShimmer extends StatelessWidget {
  const GridViewCategoryLoadeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 25, right: 25),
        child: GridView.count(
          addAutomaticKeepAlives: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 0.5,
          childAspectRatio: 0.8,
          children: List.generate(
            20,
            (index) => Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      child: Container(
                        color: Colors.black,
                        height: 150,
                        // width: 150,
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        color: Colors.black,
                        height: 6,
                        width: 120,
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
