import 'common_model.dart';
import 'grid_nav_model.dart';

class HomeModel {
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;

  HomeModel({this.bannerList, this.localNavList, this.gridNav});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    var localNavListJson = json['localNavList'] as List;

    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
    );
  }
}
