/*
 * Created by 城别 on 2019/5/15.
 * email: 1634163405@qq.com
 *
 * @Description  网络请求封装
 *
 * 使用方法：
 *    请参照本页面底部
 */
import 'package:dio/dio.dart';

var basrUrl="http://zhwk.wfust.edu.cn/";//此处为全局 请求路径

class HttpUtil {
  static HttpUtil instance;
  Dio dio = new Dio();// 使用默认配置
  BaseOptions options;// 或者通过传递一个 `options`来创建dio实例

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    print('dio赋值');
    // 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 5000,
      //当响应状态码不是成功状态(如404)时，是否接收响应内容，
      // 如果是false,则response.data将会为null
      receiveDataWhenStatusError:false,
      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      //receiveTimeout: 3000,
      // headers: {},
    );
    dio = new Dio(options);
  }

  get(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
      return 'lose';
    }
    return response.data;
  }

  post(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }
}



/*
*
********************************************************************************
                                页面加载
********************************************************************************

    网络状态监测
    加载动画（初始化进入时）
    无网后加载失败提示，并可以点击刷新

    结合为一：swlLook(加载器 => 根据状态判断)
        load   => 加载中
        finish => 完成
        lose   => 丢失

    使用：
        String swlLook = 'load';
        swlLook == 'finish'?
            ...//要展示的内容
        :swlLook == 'load'?
            Container(//加载动画效果
              child: Center(
                child: new CircularProgressIndicator(
                  strokeWidth: 4.0,
                  backgroundColor: Colors.blue,
                  //value: 0.2,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.blueAccent
                  ),
                ),
              ),
            )
        :Container(
            child: Center(
               child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 InkWell(
                   child: Image.asset(
                     'images/loseB.png',
                     width: MediaQuery.of(context).size.width / 5,
                     fit: BoxFit.cover,
                   ),
                   onTap: () {
                     print('刷新');
                     _loadData();
                   },
                 ),
                 Text(
                   '网络走神了~',
                   style: TextStyle(color: Colors.black54,height: 2),
                 )
               ],
             )
            ),
        );




        _registerCheck() async {

          //网络请求
          String url = basrUrl2 + "Zxh/Oauth/registerCheck";

          //如果需要参数在此处写
          var data = {
            'idcard': _userIdCardController,
          };

          //这是返回值
          var response = await HttpUtil().get(url,data: data);

          //根据后台返回的格式，看看需不需要JSON解析
          //如果需要 引用json
          // import 'dart:convert' show json;
          response = json.decode((response).toString());

        }
*
* */