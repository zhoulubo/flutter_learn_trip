import 'package:flutter/material.dart';
import 'package:trip_learn/pages/HomePage.dart';
import 'package:trip_learn/pages/MyPage.dart';
import 'package:trip_learn/pages/SerachePage.dart';
import 'package:trip_learn/pages/TravelPage.dart';

/**
 * home 导航页面
 */
class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabNavigator();
  }
}

class _TabNavigator extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  // 当前选中的Tab
  int _currentIndex = 0;

  // pagerView 控制器
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // 使用Scaffold填充页面
    return Scaffold(
      // PageView类似ViewPage
      body: PageView(
          controller: _controller,
          children: <Widget>[
            HomePage(),
            SearchPage(),
            TravelPage(),
            MyPage(),
          ],
//          physics: NeverScrollableScrollPhysics(),
          physics: AlwaysScrollableScrollPhysics(),
          // 监听滑动
          onPageChanged: (currentPage) {
            setState(() {
              _currentIndex = currentPage;
            });
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem("HOME", Icons.home, 0),
          _bottomItem("SEARCH", Icons.search, 1),
          _bottomItem("PHOTO", Icons.camera_alt, 2),
          _bottomItem("MY", Icons.account_circle, 3),
        ],
      ),
    );
  }

  // 统一给NavigatorBarItem 设置属性
  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
