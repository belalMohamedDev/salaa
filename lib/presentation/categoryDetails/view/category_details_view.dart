import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salaa/presentation/home/view/home_view.dart';

import '../../../domain/model/category/category_model.dart';
import '../../base/viewModel/home_view_model.dart';
import '../../common/provider/bloc_provider.dart';

import '../../productsDetails/view/product_category_view.dart';

import '../../resource/app_size.dart';
import '../../resource/color_manger.dart';
import '../../resource/image_manger.dart';
import '../../resource/strings_manger.dart';
import '../../search/view_model.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({super.key});

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView>
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

    return StreamBuilder<CategoryDaTADetailsModel>(
      stream: _viewModel.outputCategory,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
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
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
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
                        snapshot.data!.data!.data!.length,
                        (index) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductCategoryView(
                                    snapshot.data!.data!.data![index]),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                    width: 1.5, color: AppColor.lightGrey)),
                            elevation: 0,
                            child: Column(
                           
                              children: [
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 120.0,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _viewModel.getFavor(snapshot
                                              .data!.data!.data![index].id);
                                          setState(() {});
                                        },
                                        icon: _viewModel.favorites[snapshot
                                                .data!.data!.data![index].id]!
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
                                    );
                                  },
                                ),
                                Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        snapshot.data!.data!.data![index].image,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 15, right: 15),
                                  child: Text(
                                    snapshot.data!.data!.data![index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
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
                                              '${snapshot.data!.data!.data![index].oldPrice} \$',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                          ),
                                        ),
                                        const WidgetSpan(
                                          child: SizedBox(width: 10),
                                        ),
                                        TextSpan(
                                          text:
                                              '${snapshot.data!.data!.data![index].price} \$',
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
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: Lottie.asset(AppJson.splash),
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: const Text(AppStrings.salla).tr(),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                const SizedBox(width: AppSizeMange.s10),
              ],
            ),
            body: const GridViewItemLoaderShimmir(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
