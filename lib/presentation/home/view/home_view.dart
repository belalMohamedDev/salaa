import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:salaa/domain/model/home/category.dart';
import 'package:salaa/domain/model/home/home_model.dart';

import 'package:salaa/presentation/resource/app_size.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/image_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/model/category/category_model.dart';
import '../../base/viewModel/home_view_model.dart';
import '../../categoryDetails/view/category_details_view.dart';
import '../../common/provider/bloc_provider.dart';

import '../../productsDetails/view/products_view.dart';
import '../../search/view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late HomeViewModel _viewModel;
  int indexCarouselSlider = 0;
  _bind() {
    _viewModel.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = BlocProviderApp.of<HomeViewModel>(context);
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _getData();
  }

  Widget _getData() {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<HomeModel>(
              stream: _viewModel.outputData,
              builder: (context, snapshot) {
                return _showData(snapshot.data);
              },
            ),
            StreamBuilder<CategoryModel>(
              stream: _viewModel.outputCategoryData,
              builder: (context, snapshot) {
                return _getCategory(snapshot.data);
              },
            ),
            StreamBuilder<HomeModel>(
              stream: _viewModel.outputData,
              builder: (context, snapshot) {
                return _getProduct(snapshot.data);
              },
            ),
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }

  Widget _showData(HomeModel? data) {
    if (data != null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return CarouselSlider(
                    items: data.data!.banners!
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: e.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: 200.0,
                        initialPage: 0,
                        onPageChanged: ((index, reason) {
                          //CarouselSlider

                          indexCarouselSlider = index;
                          setState(() {});
                        }),
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.easeInOutBack,
                        scrollDirection: Axis.horizontal));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: AnimatedSmoothIndicator(
              effect: ExpandingDotsEffect(
                activeDotColor: AppColor.darkBG3,
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 6,
                spacing: 8,
              ),
              count: data.data!.banners!.length,
              activeIndex: indexCarouselSlider,
            )),
          ],
        ),
      );
    } else {
      return const CarouselSliderShimmerLoading();
    }
  }

  Widget _getCategory(CategoryModel? data) {
    if (data != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(AppStrings.category,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18))
                  .tr(),
            ),
            const SizedBox(height: 15),
            StreamBuilder<CategoryDaTADetailsModel>(
              stream: _viewModel.outputCategory,
              builder: (context, snapshot) {
                return SizedBox(
                  height: 60,
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: data.data!.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          _viewModel
                              .getCategoryData(data.data!.data![index].id);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CategoryDetailsView(),
                              ));
                        },
                        child: Card(
                          elevation: 2,
                          color: AppColor.darkBG3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: SizedBox(
                              width: 165,
                              child: Center(
                                child: Text(data.data!.data![index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 12)),
                              )),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return const ListViewCategoryLoadingShimmir();
    }
  }

  Widget _getProduct(HomeModel? data) {
    if (data != null) {
      return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: GridView.count(
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              top: 15,
              right: 8,
              left: 8,
            ),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 0.5,
            childAspectRatio: 0.6,
            children: List.generate(
              data.data!.products!.length,
              (index) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(data.data!.products![index]),
                    )),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(width: 1.5, color: AppColor.lightGrey)),
                  elevation: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 120.0,
                        ),
                        child: IconButton(
                          onPressed: () {
                            _viewModel.getFavor(data.data!.products![index].id);
                            setState(() {});
                          },
                          icon: _viewModel
                                  .favorites[data.data!.products![index].id]!
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColor.red,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: AppColor.grayFont,
                                  size: 20,
                                ),
                        ),
                      ),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: data.data!.products![index].image,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 15, right: 15),
                        child: Text(
                          data.data!.products![index].name,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 12),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${data.data!.products![index].oldPrice} \$',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 10),
                              ),
                              TextSpan(
                                text: '${data.data!.products![index].price} \$',
                                style: const TextStyle(
                                  // color: Colors.grey,
                                  fontSize: 16,
                                  // decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    } else {
      return const GridViewItemLoaderShimmir();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class ListViewCategoryLoadingShimmir extends StatelessWidget {
  const ListViewCategoryLoadingShimmir({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    color: Colors.black,
                    height: 8,
                    width: 150,
                  )),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade400,
                    child: Center(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          child: Container(
                            color: Colors.black,
                            height: 40,
                            width: 165,
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GridViewItemLoaderShimmir extends StatelessWidget {
  const GridViewItemLoaderShimmir({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 15,
            right: 8,
            left: 8,
          ),
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 0.5,
          childAspectRatio: 0.6,
          children: List.generate(
            20,
            (index) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(width: 1.5, color: AppColor.lightGrey)),
              elevation: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 120.0,
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outline_rounded,
                            color: AppColor.red,
                            size: 20,
                          )),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade400,
                    child: Center(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Container(
                            color: Colors.black,
                            height: 100,
                            width: 110,
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 15, right: 15),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black,
                              height: 2,
                              width: 120,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black,
                              height: 2,
                              width: 110,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black,
                              height: 2,
                              width: 110,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black,
                              height: 2,
                              width: 110,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black,
                              height: 2,
                              width: 80,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //itemCount: data.data!.products!.length,
          ),
        ));
  }
}

class CarouselSliderShimmerLoading extends StatelessWidget {
  const CarouselSliderShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade400,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  color: Colors.black,
                  height: 200,
                  width: double.infinity,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    color: Colors.black,
                    height: 5,
                    width: double.infinity,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
