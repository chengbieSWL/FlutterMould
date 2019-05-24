import 'package:flutter/material.dart';
import 'dart:convert';//dart里面有base64（接口加密）
import 'package:crypto/crypto.dart';//sha1（接口加密）
import 'dart:async';//（检测网络）
import 'package:flutter/services.dart';//（检测网络）
import 'package:connectivity/connectivity.dart';//（检测网络）
import 'package:fluttertoast/fluttertoast.dart';//提示框
import 'package:shared_preferences/shared_preferences.dart';//（存值）
import 'dart:math';//dart模拟生成随机数

/*
 * Created by 城别 on 2019/5/15.
 * email: 1634163405@qq.com
 *
 * @Description  接口加密、检测网络、储值数值
 *
 * 使用方法：
 *    请参照本页面底部
 */

class publicAll{

  /**
   * @Effect  接口加密
   *
   * 使用方法：
   *     var encrypTion = publicAll().encryption();//获取加密值
   *     'random': encrypTion[0],
         'code': encrypTion[1],
   */
  encryption(){
     String randomNo;//加密变量
    var codeNo;//加密变量

    String alphabet = '7412589630';
    int strlenght = 10; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }

    //生成时间戳
    randomNo = DateTime.now().millisecondsSinceEpoch.toString() + left;
    //random = 0.11343798064626753;
    //print(random);
    //utf8转换为数组
    var bytes = utf8.encode('xxxxxx$randomNo');
    //print(bytes);
    //base64进行加密
    var bytesTwo = 'xxx' + base64Encode(bytes) + 'xxx';
    //print(bytesTwo);
    //utf8转换为数组
    var bytesThree = utf8.encode(bytesTwo); // data being hashed
    //print(bytesThree);
    //哈希加密
    codeNo = sha1.convert(bytesThree);
    //print(code);
    List encryptionList = [randomNo, codeNo];
    return encryptionList;
  }



  /**
   * @Effect  检测网络
   *
   * 使用方法：
   *    初始化（initState）时：
   *        publicAll().initConnectivity(); //网络监听（开始）
   *        publicAll().connectivityInitState(); //网络监听（进行）
   *
   *    结束（dispose）时：
   *         publicAll().connectivityDispose(); //网络监听（结束）
   */
  //定义变量（网络状态）
  String _connectionStatus = 'Unknown';
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //网络初始状态
  connectivityInitState(){
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          print(result.toString());
          if(result.toString() == 'ConnectivityResult.none'){
            Fluttertoast.showToast(
                msg: '网络连接错误!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 2,
                fontSize: 16.0
            );
          }
        });
  }
  //网络结束监听
  connectivityDispose(){
    _connectivitySubscription.cancel();
  }
  //网络进行监听
  Future<Null> initConnectivity() async {
    String connectionStatus;
    //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
    try {
      connectionStatus = (await Connectivity().checkConnectivity()).toString();

      if (connectionStatus == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (connectionStatus == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      }
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }
  }


  /**
   * @Effect  储值数值
   *
   * 使用方法：
   *    //存值
   *    publicAll().StoredValue('方式', '起名', 要存的值);
   *    //取值
   *    SharedPreferences preferences = await SharedPreferences.getInstance();
        String studentId = preferences.get('起的名');
   */
  StoredValue(stype,sname,scontent) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(stype){
      case 'setString':prefs.setString(sname, scontent);
        break;
      case 'setBool':prefs.setBool(sname, scontent);
        break;
      case 'setDouble':prefs.setDouble(sname, scontent);
        break;
      case 'setInt':prefs.setInt(sname, scontent);
        break;
      case 'setStringList':prefs.setStringList(sname, scontent);
        break;
    }
  }




}
