import 'package:flutter/material.dart';
import 'dart:io'; //获取设备信息
import 'package:device_info/device_info.dart'; //获取设备信息
import 'package:template/Method/HttpUtil.dart'; //网络请求
import 'package:package_info/package_info.dart'; //用于查询有关应用程序包的信息。
import 'package:url_launcher/url_launcher.dart';//打开外部链接


//--- 变量区
bool setUpStateSWL = false;//能否下载
String appUrl = '';//下载连接
String IOSorAndroid = '';//判断是安卓还是IOS

//版本更新（此方法判断是否可以更新）
Future checkNewVersion(context,pattern) async {
  //var downLoadUrl = 'http://172.19.35.51/apk/android.json';

  var downLoadUrl = '';//请求路径
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin(); //获取设备信息
  if (Platform.isIOS) {
    //ios相关代码
    downLoadUrl = 'http://xxxx';
    IOSorAndroid = 'IOS';
  } else if (Platform.isAndroid) {
    //android相关代码
    downLoadUrl = 'http://xxxx';
    IOSorAndroid = 'Android';
  }

  String remoteChangeLog = '';//更新内容
  //----------------------------------------------------------------获取当前版本号
  //用于查询有关应用程序包的信息。
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  //appName:wkxy
  // packageName:com.example.wkxy
  // version:1.0.0
  // buildNumber:1
//    print("appName:" +
//        appName +
//        "=packageName:" +
//        packageName +
//        "=version:" +
//        version +
//        "=buildNumber:" +
//        buildNumber);
  //----------------------------------------------------------------获取最新版本号
  try {
    //网络请求（请求版本号路径）
    String url = downLoadUrl;
    //await 关键字则表明这是阻塞调用
    var response = await HttpUtil().get(url);
    //这是网络版本号
    String remoteVersion = response['version'];
    //这是更新提示
    remoteChangeLog = response['changeLog'];
    //这是下载地址
    appUrl = response['url'];
    //当前版本（'.'替换并转换为数值类型）
    final dqVersion = int.parse(version.replaceAll(new RegExp(r'\.'), '0'));
    //网络版本（'.'替换并转换为数值类型）
    final wlRemoteVersion =
    int.parse(remoteVersion.replaceAll(new RegExp(r'\.'), '0'));
    // print('*************************************************************');
    // print(dqVersion);
    // print(wlRemoteVersion);

    //版本号对比（对比版本号大小）
    if (dqVersion > wlRemoteVersion) {
      print('当前版本号大，无视');
      setUpStateSWL = false; //更新状态
    } else if (dqVersion < wlRemoteVersion) {
      print('当前版本号小，提示更新');
      setUpStateSWL = true; //更新状态
    } else {
      print('版本号相同，无视');
      setUpStateSWL = false; //更新状态
    }
  } catch (e) {
    setUpStateSWL = false;
  }
  print('*************************************************************');
  if(pattern == 'dong'){
    showAlertDialog(context,remoteChangeLog);
  }
}

//提示
void showAlertDialog(context, name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('版本更新'),
        content: Text(name),
        actions: <Widget>[
          FlatButton(
              child: Text('更新'),
              onPressed: () {
                launchURL();
              })
        ],
      ));
}



//跳外部链接下载APP
launchURL() async {
  print(appUrl);
  if(IOSorAndroid == 'IOS'){
    appUrl = 'https://itunes.apple.com/cn/app/xxx';
  }
  if (setUpStateSWL) {
    var url = appUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/*
*
********************************************************************************
                                列表模式
********************************************************************************

       bool setUpStateSWL = true;

     //更新状态（依据状态判断能否更新）
      Widget _setUp() {
        print(setUpStateSWL);
        if (setUpStateSWL) {
          return Row(
            children: <Widget>[
              Text(
                '*新版本',textAlign:TextAlign.end,
                style: TextStyle(fontSize: 16.0, color: Colors.red,),
              ),
              //Icon(Icons.arrow_forward_ios,size: 18.0,),
            ],
          );
        } else {
          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '已是新版本',textAlign:TextAlign.end,
                  style: TextStyle(fontSize: 16.0, color: Colors.black26),
                ),
              ),
            ],
          );
        }
      }
*
* */
