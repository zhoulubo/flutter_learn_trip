import 'common_model.dart';
import 'grid_nav_model.dart';
import 'sales_box_model.dart';

class HomeModel {
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBoxModel;

  HomeModel({
    this.bannerList,
    this.localNavList,
    this.gridNav,
    this.subNavList,
    this.salesBoxModel,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    var localNavListJson = json['localNavList'] as List;
    var subNavListJson = json['subNavList'] as List;

    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBoxModel: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}
