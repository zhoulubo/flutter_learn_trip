import 'package:flutter/material.dart';
import 'package:trip_learn/dao/home_dao.dart';
import 'package:trip_learn/model/common_model.dart';
import 'package:trip_learn/model/grid_nav_model.dart';
import 'package:trip_learn/model/home_model.dart';
import 'package:trip_learn/model/sales_box_model.dart';
import 'package:trip_learn/util/NavigatorUtil.dart';
import 'package:trip_learn/widget/GridNav.dart';
import 'package:trip_learn/widget/local_nav.dart';
import 'package:trip_learn/widget/sales_box.dart';
import 'package:trip_learn/widget/search_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:trip_learn/widget/sub_nav.dart';
import 'SerachePage.dart';

const APPBAR_SCROLL_OFFSET = 100;

/**
 * 首页
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  // 头部渐变透明度
  double appBarAlpha = 0;

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Center(
          child: Stack(children: <Widget>[
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                    child: NotificationListener(
                        onNotification: (scrollNotification) {
                          // 是第一个widget的滑动监听
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            //滚动且是列表滚动的时候
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                        },
                        child: _listView),
                    onRefresh: _handleRefresh)),
            _appBar,
          ]),
        ));
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SubNav(subNavList: subNavList)),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBoxModel:salesBoxModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: Text(
            "高原徒步",
            style: TextStyle(fontSize: 20, height: 5),
          ),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          // 装饰
          decoration: BoxDecoration(
              gradient: LinearGradient(
            // AppBar渐变背景
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(leftButtonClick: () {
              _jumpToSearch();
            }, rightButtonClick: () {
              _jumpToSearch();
            }),
          ),
        ),
      ],
    );
  }

  // 广告栏
  Widget get _banner {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              NavigatorUtil.push(
                  context,
                  WebView(
                      url: model.url,
                      title: model.title,
                      hideAppBar: model.hideAppBar));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage());
  }

  // 下拉刷新
  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
//      .then((onError){
//        print(onError);
//      });
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBoxModel;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }
}

class WebView extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid}) {
    if (url != null && url.contains('ctrip.com')) {
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
