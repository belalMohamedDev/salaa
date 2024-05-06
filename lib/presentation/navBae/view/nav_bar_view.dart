import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:salaa/app/cubit/app_logic_cubit.dart';
import 'package:salaa/presentation/categories/view/categories_view.dart';
import 'package:salaa/presentation/favorites/view/favorites_view.dart';
import 'package:salaa/presentation/home/view/home_view.dart';
import 'package:salaa/presentation/resource/color_manger.dart';
import 'package:salaa/presentation/resource/strings_manger.dart';
import 'package:salaa/presentation/salla/view/salla_view.dart';
import 'package:salaa/presentation/setting/view/setting_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController bottomNavBarController =
      PersistentTabController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLogicCubit, AppLogicState>(
      builder: (context, state) {
        return PersistentTabView(
          context,
          controller: bottomNavBarController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          margin: const EdgeInsets.all(12.0),
          confineInSafeArea: true,
          backgroundColor: AppColor.darkBG3, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            //   colorBehindNavBar:AppColor.white,
            colorBehindNavBar: context.read<AppLogicCubit>().isDarkMode  ? AppColor.dark : AppColor.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        );
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const CategoriesView(),
      const SallaView(),
      const FavoritesView(),
      const SettingView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: (AppStrings.home).tr(),
        activeColorPrimary: AppColor.white,
        inactiveColorPrimary: AppColor.lightGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.widgets_outlined),
        title: (AppStrings.categories).tr(),
        activeColorPrimary: AppColor.white,
        inactiveColorPrimary: AppColor.lightGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: (AppStrings.shopping).tr(),
        activeColorPrimary: AppColor.white,
        inactiveColorPrimary: AppColor.lightGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border),
        title: (AppStrings.favorite).tr(),
        activeColorPrimary: AppColor.white,
        inactiveColorPrimary: AppColor.lightGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: (AppStrings.settings).tr(),
        activeColorPrimary: AppColor.white,
        inactiveColorPrimary: AppColor.lightGrey2,
      ),
    ];
  }
}
