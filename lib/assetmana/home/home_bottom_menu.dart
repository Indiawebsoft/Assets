import 'package:asset_management/assetmana/home/add_asset_page.dart';
import 'package:asset_management/assetmana/home/home_page.dart';
import 'package:asset_management/assetmana/home/massage_page.dart';
import 'package:asset_management/assetmana/home/search_page.dart';
import 'package:asset_management/dashboard/repository/model/get_home_data_response.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:get/get.dart';
import '../app_drawer.dart';
import '../controllers/app_controller.dart';
import '../list_pages/add_new_asset.dart';
import '../list_pages/asset_list.dart';
import 'my_profile_page.dart';

class HomeBottomMenu extends StatefulWidget {
  @override
  State<HomeBottomMenu> createState() => _HomeBottomMenu();
}

class _HomeBottomMenu extends State<HomeBottomMenu> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _hideNavBar = false;
  NavBarStyle _navBarStyle = NavBarStyle.style15;
  bool _hideNavigationBarWhenKeyboardShows = true;
  bool _resizeToAvoidBottomInset = true;
  bool _stateManagement = true;
  bool _handleAndroidBackButtonPress = true;
  bool _popAllScreensOnTapOfSelectedTab = true;
  bool _confineInSafeArea = true;
  final appController = Get.put(AppController());

  List<Widget> _buildScreens() {
    return [
      HomePage(
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      AssetListPage(null, null, null,null),

      // AddNewAsset(widget.selectedCategory,null),
      AddNewAsset(null, null),
      // AddAssetPage(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      MassagePage(
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MyProfilePage(
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.list),
        title: ("My Assets"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => HomePage(),
        //     '/second': (context) => SearchPage(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.blueAccent,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          // routeAndNavigatorSettings: RouteAndNavigatorSettings(
          //   initialRoute: '/',
          //   routes: {
          //     '/first': (context) => MainScreen2(),
          //     '/second': (context) => MainScreen3(),
          //   },
          // ),
          onPressed: (context) {
            if (context != null) {
              Get.to(AddNewAsset(null, null));
              // pushDynamicScreen(context,
              //     screen: SampleModalScreen(), withNavBar: true);
            }
          }),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Notification"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle_outlined),
        title: ("Profile"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: AppDrawer(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: _confineInSafeArea,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: _handleAndroidBackButtonPress,
        resizeToAvoidBottomInset: _resizeToAvoidBottomInset,
        stateManagement: _stateManagement,
        navBarHeight: kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: _hideNavigationBarWhenKeyboardShows,
        margin: EdgeInsets.zero,
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        // onWillPop: (context) async {
        //   if (context != null) {
        //     await showDialog(
        //       context: context,
        //       useSafeArea: true,
        //       builder: (context) => Container(
        //         height: 50.0,
        //         width: 50.0,
        //         color: Colors.white,
        //         child: ElevatedButton(
        //           child: Text("Close"),
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //         ),
        //       ),
        //     );
        //   }
        //   return false;
        // },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(0.0),
        ),
        popAllScreensOnTapOfSelectedTab: _popAllScreensOnTapOfSelectedTab,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: _navBarStyle,
      ),
    );
  }
}
