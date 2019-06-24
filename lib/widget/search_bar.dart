import 'package:flutter/material.dart';

/**
 * 搜索Widget
 */
class SearchBar extends StatefulWidget {
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBxClick;

  const SearchBar(
      {Key key,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBxClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _getNormalSearch();
  }

  _getNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 26,
                  )),
              widget.leftButtonClick),
          Expanded(flex: 1, child: Text("_inputBox")),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "搜索",
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    // 监听触摸
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }
}
