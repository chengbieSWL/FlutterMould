import 'package:flutter/material.dart';

/**
 * Created by 城别 on 2019/5/15.
 * email: 1634163405@qq.com
 *
 * @Description  跳页动画
 *
 * 使用方法：
 *    Navigator.of(context).push(CustomRoute(方法名(),'跳转方式'));
 */


class CustomRoute extends PageRouteBuilder {
  //定义变量
  final Widget widget;
  final ticketNumber;
  //构造方法
  CustomRoute(this.widget, this.ticketNumber)
      : super(
    //父类的方法
    //过渡时间
      transitionDuration: const Duration(milliseconds: 500),
      //构造器（需要三个参数）
      pageBuilder: (BuildContext context, //上下文
          Animation<double> animation1, //动画
          Animation<double> animation2) {
        return widget;
      },
      //过渡效果（需要接受四个参数）
      transitionsBuilder: (BuildContext context, //上下文
          Animation<double> animation1, //动画
          Animation<double> animation2,
          Widget child) {
        //Widget
        //【关键】
        switch (ticketNumber) {
        /*
              * 淡入淡出
              * */
          case 'FadeTransition':
            return FadeTransition(
              //过渡透明度效果
              opacity:
              Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                //父级动画
                  parent: animation1,
                  //动画曲线
                  curve: Curves.fastOutSlowIn)),
              child: child,
            );
            break;
        /*
              * 缩放路由动画
              * */
          case 'ScaleTransition':
            return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child);
            break;
        /*
              * 旋转+缩放路由动画
              * */
          case 'RotationTransition':
            return RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animation1, curve: Curves.fastOutSlowIn)),
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animation1,
                          curve: Curves.fastOutSlowIn)),
                  child: child,
                ));
            break;
        /*
              * 左右滑动路由动画
              * */
          case 'SlideTransition':
            return SlideTransition(
              position: Tween<Offset>(
                  begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(CurvedAnimation(
                  parent: animation1, curve: Curves.fastOutSlowIn)),
              child: child,
            );
            break;
        }
      });
}
