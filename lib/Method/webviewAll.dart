import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart'; //打开内部链接
import 'dart:ui';

/*
 * Created by 城别 on 2019/5/15.
 * email: 1634163405@qq.com
 *
 * @Description  页面内打开第三方网页
 *
 * 使用方法：
 *     MaterialPageRoute(
        builder: (context) => NewsWebPageTwo(
            url: '我是连接',
            title: '我是标题'))
 */

class NewsWebPageTwo extends StatefulWidget {
  String url;
  String title;
  NewsWebPageTwo({Key key, @required this.url, this.title}) : super(key: key);

  @override
  _NewsWebPageTwoState createState() => _NewsWebPageTwoState();
}

//-------------------------------------------------------------------------内跳
class _NewsWebPageTwoState extends State<NewsWebPageTwo> {
  /**
   * @Region 变量
   */
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  String initialUrl = ''; //初始连接
  bool appBarDisplay = true; //是否有appbar

  /**
   * @Region 监听
   */
  @override //初始化
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (initialUrl == '') {
        initialUrl = url; //赋予初始值
      }
      if (url == initialUrl) {
        //相等就是根目录
        setState(() {
          appBarDisplay = true;
        });
      } else {
        setState(() {
          appBarDisplay = false;
        });
      }
    });
  }

  @override //结束
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.close(); //关闭web
  }

  @override
  Widget build(BuildContext context) {
    //使用Flutter导航启动WebView全屏＃
    return WillPopScope(
        child: WebviewScaffold(
          url: widget.url, //这是第三方连接
          appBar: appBarDisplay == true
              ? AppBar(
                  title: new Text("${widget.title}"),
                  centerTitle: true,
                  leading: IconButton(
//左侧关闭按钮
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 35.0,
                    ), //关闭按钮的图标
                    onPressed: () {
//点击事件
                      Navigator.pop(context); //返回上一页
                    },
                  ),
                )
              : PreferredSize(
                  child: AppBar(),
                  preferredSize: Size.fromHeight(0),
                ),
        ),
        onWillPop: () {//物理键监听
          if(appBarDisplay == true){
            Navigator.pop(context);
          }
        });
  }
}




