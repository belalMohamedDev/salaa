import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salaa/presentation/home/view/home_view.dart';

import '../../../domain/model/getFvor/get_favor_model.dart';

import '../../base/viewModel/home_view_model.dart';
import '../../common/provider/bloc_provider.dart';

import '../../productsDetails/view/product_favor_view.dart';

import '../../resource/app_size.dart';
import '../../resource/color_manger.dart';
import '../../resource/image_manger.dart';
import '../../resource/strings_manger.dart';
import '../../search/view_model.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with AutomaticKeepAliveClientMixin {
  late HomeViewModel _viewModel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = BlocProviderApp.of<HomeViewModel>(context);
    _viewModel.getFavorData();
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
      body: StreamBuilder<GetFavoriteDataModel>(
        stream: _viewModel.outputFavor,
        builder: (context, snapshot) {
          return _getProduct(snapshot.data);
        },
      ),
    );
  }

  Widget _getProduct(GetFavoriteDataModel? data) {
    if (data != null) {
      return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                GridView.count(
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
                    data.data!.data!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductFavorDetails(
                                  data.data!.data![index].product),
                            ));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                                width: 1.5, color: AppColor.lightGrey)),
                        elevation: 0,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 120.0,
                                ),
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return IconButton(
                                      onPressed: () {
                                        _viewModel.getFavor(data
                                            .data!.data![index].product!.id);

                                        setState(() {});
                                      },
                                      icon: _viewModel.favorites[data
                                              .data!.data![index].product!.id]!
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
                                    );
                                  },
                                )),
                            Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                    data.data!.data![index].product!.image,
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
                                  top: 20.0, left: 15, right: 15),
                              child: Text(
                                data.data!.data![index].product!.name,
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
                                          '${data.data!.data![index].product!.oldPrice} \$',
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
                                      text:
                                          '${data.data!.data![index].product!.price} \$',
                                      style: const TextStyle(
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

                    //itemCount: data.data!.products!.length,
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            )),
      );
    } else {
      return const GridViewItemLoaderShimmir();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
