import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:aactivpay/export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.primaryLight,
      appBar: HomeAppBar(
        controller.openLocationPage,
        controller.openProfilePage,
        controller.openSearchPage,
      ),
      body: controller.obx(
        (state) => getBody(context),
        onLoading: HomeLoadingScreen(),
      ),
      floatingActionButton: FloatingAction(
        onPressed: () => controller.openBottomSheet(
          context,
          this._scaffoldKey.currentState,
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return Container(
      height: sizes.height,
      width: sizes.width,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final HomeDataType type = controller.useCase.data[index].type;
          switch (type) {
            case HomeDataType.LOCATION:
              return MapCard(onTap: controller.openLocationPage);
            case HomeDataType.CATEGORIES:
              return FilterPills(
                dataList: controller.pillsList,
                onTap: controller.onPillsTap,
              );
            case HomeDataType.TOPRATED_HEADER:
              return HeadingCard(
                'Top ratted Stores',
                icon: assets.icMedal,
              );
            case HomeDataType.TOPRATED:
              return StoreCard(
                controller.getHomeData(index),
                openStoreDetails: controller.openStoreDetailsPage,
                seeAllStore: controller.openAllStorePage,
              );
            case HomeDataType.NEARBYHEADER:
              return NearByHeader();
            case HomeDataType.NEARBY_EMPTY_CARD:
              return Obx(
                () => NearByEmptyCard(
                  controller.userAddress.value,
                  onTap: controller.openLocationPage,
                ),
              );
            case HomeDataType.NEARBY_DATA_CARD:
              return StoreCard(
                controller.getHomeData(index),
                openStoreDetails: controller.openStoreDetailsPage,
                seeAllStore: controller.openAllStorePage,
              );
            case HomeDataType.INVITE:
              return InviteCard();
            case HomeDataType.TRANSACTIONS:
              return RecentTransactions(controller.recentTransactions);
            case HomeDataType.SPACE:
              return verticalSpacer(20);
            default:
              return verticalSpacer(20);
          }
        },
        itemCount: controller.useCase.data.length,
      ),
    );
  }
}
