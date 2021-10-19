import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Obx(
        () => Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset('asset/loading/unnamed.gif'),
              FlatButton(
                  onPressed: () {
                    // Statement.to.login();
                  },
                  child: Text("하하하")),
              Statement.to.autoLogin.value == true
                  ? Text('자동로그인 성공')
                  : Text('자동로그인실패'),
              FlatButton(
                  onPressed: () {
                    // Statement.to.login('chinggu88@gmail.com');
                    // Get.offNamed('/Main');
                  },
                  child: Text("메인뷰가기")),
            ],
          ),
        ),
      ),
    );
  }
}
