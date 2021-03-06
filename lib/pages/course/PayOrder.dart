import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectpractice/common/Global.dart';
import 'package:projectpractice/common/Http.dart';
import 'package:projectpractice/widget/Goodsbox.dart';
import 'package:projectpractice/widget/RatingBar.dart';
import 'package:projectpractice/pages/course/CourseVieo.dart';
import 'package:flutter_alipay/flutter_alipay.dart';
//确认订单页面

class PayOrder extends StatefulWidget {
  PayOrder({this.imgsrc, this.title, this.price, this.cid});
  String imgsrc;
  String title;
  double price;
  int cid; //课程id--获取课程视频需要

  @override
  _PayOrderState createState() => _PayOrderState();
}

class _PayOrderState extends State<PayOrder> {
  //表示当前选中的单选框：微信、支付宝、京东
  String payType = '支付宝';

  //保存scaffold状态实例：实现nav提示
  var _scaffoldkey = new GlobalKey<ScaffoldState>();
  //封装提示语句 message是提示内容
  void showSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.imgsrc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '确认订单',
                style: TextStyle(
                    color: Color.fromRGBO(56, 56, 56, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(), //确保stack沾满屏幕
          child: Stack(
            //!有个问题需要解决，-Positioned宽度问题。这个问题解决了可以做真正固定底部的占据全部宽度的组件
            children: <Widget>[
              Container(
                //页面组件放置在占据全屏的带浅灰色的容器里面。
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(color: const Color(0xF2F6FCff)),
              ),

              //中间主题内容：需要外加一个wrap层，因为我现在在stack父级里面
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    //商品信息
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 4.0)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '商品信息',
                            style: TextStyle(
                                color: Color.fromRGBO(86, 86, 86, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Goodsbox(
                                  imgsrc: widget.imgsrc,
                                  heigth: 68.0,
                                  title: '',
                                  introduce: '',
                                  opc: 0.0,
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Wrap(
                                          children: <Widget>[
                                            Text(
                                              widget.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1.0),
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '￥${widget.price}',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      212, 48, 48, 1.0),
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),

                    //购买提醒
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      width: double.infinity,
                      child: Text(
                        '惠优质课程，买了不后悔，赶紧购买吧',
                        style: TextStyle(
                            color: Color.fromRGBO(165, 133, 133, 1.0)),
                      ),
                    ),

                    //商品金额于优惠
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      height: 120.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 4.0)
                          ]),
                      child: Column(
                        // mainAxisAlignment: ,
                        children: <Widget>[
                          ListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            title: Text(
                              '商品金额',
                              style: TextStyle(
                                  color: Color.fromRGBO(86, 86, 86, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            trailing: Text(
                              '￥${widget.price}',
                              style: TextStyle(
                                  color: Color.fromRGBO(212, 48, 48, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            title: Text(
                              '限时优惠',
                              style: TextStyle(
                                  color: Color.fromRGBO(86, 86, 86, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            trailing: Text(
                              '-￥0.00',
                              style: TextStyle(
                                  color: Color.fromRGBO(212, 48, 48, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                    ),

                    //支付方式
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      height: 220.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 4.0)
                          ]),
                      child: Column(
                        // mainAxisAlignment: ,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '支付方式',
                            style: TextStyle(
                                color: Color.fromRGBO(86, 86, 86, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                //支付宝支付
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image(
                                          image:
                                              AssetImage('images/zhifubao.png'),
                                          width: 36.0,
                                          height: 36.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            '支付宝',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    86, 86, 86, 1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        )
                                      ],
                                    ),
                                    Radio<String>(
                                      value: '支付宝',
                                      groupValue: payType,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          payType = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                //微信支付
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              'images/weixinpay.png'),
                                          width: 36.0,
                                          height: 36.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            '微信',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    86, 86, 86, 1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        )
                                      ],
                                    ),
                                    Radio<String>(
                                      value: '微信',
                                      groupValue: payType,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        //由于目前仅仅支持支付宝支付，所以点击后不改变支付状态，
                                        //给用户一个提示
                                        showSnackBar('抱歉，目前仅支持支付宝支付');
                                      },
                                    )
                                  ],
                                ),
                                //京东支付
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              'images/jingdozhifu.png'),
                                          width: 36.0,
                                          height: 36.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            '京东',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    86, 86, 86, 1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        )
                                      ],
                                    ),
                                    Radio<String>(
                                      value: '京东',
                                      groupValue: payType,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        //由于目前仅仅支持微信支付，所以点击后不改变支付状态，
                                        //给用户一个提示
                                        showSnackBar('抱歉，目前仅支持支付宝支付');
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //!固定底部解决方案
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, -1.0),
                        blurRadius: 4.0)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: '实付',
                                style: TextStyle(
                                    color: Color.fromRGBO(86, 86, 86, 1.0))),
                            TextSpan(
                                text: '￥${widget.price}',
                                style: TextStyle(
                                    color: Color.fromRGBO(234, 82, 53, 1.0),
                                    fontSize: 18.0))
                          ]))),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 45.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(214, 55, 25, 1.0),
                              Colors.red
                            ]), //背景渐变
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              //点击跳转支付宝支付
                              var result = await FlutterAlipay.pay(
                                  "you pay info from server");
                              showSnackBar('支付失败:没有支付订单生成，缺失信息');
                              //TODO:暂时做成，支付成功后，在这里根据cid获取到课程的视频这样

                              //点击提交支付信息获取到后台返沪的订单信息后调用支付宝支付
                              var user = Global.user;
                              Http.postData(
                                  '/orderInfo/insertSelective',
                                  (data) {
                                    print(data);
                                    Http.getData(
                                        '/videoInfo/selectByCid',
                                        (data) {
                                          print(json.encode(data['data']));
                                          var url;
                                          if (data['data'].length == 0) {
                                            url = '';
                                          } else {
                                            url = data['data'][0]['vurl'];
                                          }
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CourseVideo(
                                              url: url,
                                              vidoeInfo: json.encode(
                                                data['data'],
                                              ),
                                              cid: widget.cid,
                                            );
                                          }));
                                        },
                                        params: {'cid': widget.cid},
                                        errorCallBack: (error) {
                                          print('error:$error');
                                        });
                                  },
                                  params: {
                                    'cid': widget.cid,
                                    'price': widget.price,
                                    'stuid': user.userInfo.stuid,
                                    'onpay': 0
                                  },
                                  errorCallBack: (error) {
                                    print(error);
                                  });
                            },
                            child: Text(
                              '提交订单',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        )

// This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
