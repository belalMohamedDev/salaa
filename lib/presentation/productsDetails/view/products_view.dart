import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:salaa/domain/model/home/home_model.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';

import '../../../app/di.dart';
import '../../base/viewModel/home_view_model.dart';

class ProductDetails extends StatefulWidget {
  final Products products;
  const ProductDetails(this.products, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with AutomaticKeepAliveClientMixin {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 22),
        title: const Text(AppStrings.products,
            style: TextStyle(
              fontSize: 16,
            )).tr(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.products.name,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 16)),
              const SizedBox(
                height: 30,
              ),
              CarouselSlider(
                  items: widget.products.images
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: e,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: 300.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.easeInOutBack,
                      scrollDirection: Axis.horizontal)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ ${widget.products.price} ',
                          style: const TextStyle(
                   
                            fontSize: 18,
                      
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 15),
                        ),
                        TextSpan(
                          text: '\$ ${widget.products.oldPrice} ',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _viewModel.addProducts(widget.products.id);
                    },
                    child: Card(
                      elevation: 1,
                      color: AppColor.darkBG3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: SizedBox(
                          width: 100,
                          height: 50,
                          child: Center(
                            child: Text(AppStrings.add,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 12))
                                .tr(),
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  AppStrings.description,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.start,
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 15, bottom: 50),
                child: Text(
                  widget.products.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
