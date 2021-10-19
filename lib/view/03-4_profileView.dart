import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meridasns/Controller/profile_controller.dart';
import 'package:meridasns/Controller/statement_controller.dart';

class Profileview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Profile.to.profile_load(Get.arguments.toString());
    return WillPopScope(
      onWillPop: () {
        Get.offNamed('/Main');
      },
      child: Scaffold(
        body: Obx(() {
          return Profile.to.profile.value.age != null
              ? Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Get.size.height * 0.7,
                            width: Get.size.width,
                            child: Image.network(
                              Profile.to.common.baseurl +
                                  '/profile/' +
                                  Profile.to.profile.value.backgroundphoto
                                      .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Profile.to.innerImage.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(left: 15)),
                                        SizedBox(
                                            height: 250,
                                            width: 250,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: GestureDetector(
                                                  child: CachedNetworkImage(
                                                    imageUrl: Statement
                                                            .to.baseurl +
                                                        '/diary/' +
                                                        Profile
                                                            .to
                                                            .photoinprofile[0]
                                                            .filepath +
                                                        '/' +
                                                        Profile.to
                                                            .innerImage[index],
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                  // onTap: () {
                                                  //   Fluttertoast.showToast(
                                                  //       msg: "유진아 준비중이야!",
                                                  //       toastLength:
                                                  //           Toast.LENGTH_SHORT,
                                                  //       gravity:
                                                  //           ToastGravity.CENTER,
                                                  //       timeInSecForIosWeb: 1,
                                                  //       // backgroundColor: Colors.red,
                                                  //       textColor: Colors.white,
                                                  //       fontSize: 16.0);

                                                  // },
                                                ))),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: Get.size.height * 0.4 - 70,
                        left: Get.size.width * 0.5 - 70,
                        child: GestureDetector(
                          child: Column(
                            children: [
                              Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(Profile
                                              .to.common.baseurl +
                                          '/profile/' +
                                          Profile.to.profile.value.profilephoto
                                              .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                    // border: Border.all(
                                    //   color: Colors.white,
                                    //   width: 10.0,
                                    // )
                                  )),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      Profile.to.profile.value.name.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 28.0,
                                      ),
                                    ),
                                  ),
                                  Profile.to.editchk.value != false
                                      ? Container(
                                          child: IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.white,
                                              onPressed: () {
                                                Get.toNamed('/Createprofile',
                                                    arguments: {
                                                      'kind': 1,
                                                      'id': Statement.to
                                                          .commonuser.value.id,
                                                    });
                                              }),
                                        )
                                      : Container()
                                ],
                              ),
                            ],
                          ),
                        ),
                        // onTap: () async {
                        //   await Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (BuildContext context) => profileDetailView(imageurl : commoninfo.url+'/profile/'+_users[0].profilephoto)
                        //       )
                        //     );
                        // },
                      ),
                      Positioned(
                          child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.cancel),
                              iconSize: 30,
                              color: Colors.orangeAccent,
                              onPressed: () {
                                Get.offNamed('/Main');
                              }),
                          Profile.to.editchk.value != false
                              ? IconButton(
                                  icon: Icon(Icons.edit),
                                  iconSize: 30,
                                  color: Colors.orangeAccent,
                                  onPressed: () {
                                    Get.toNamed('/Createprofile', arguments: {
                                      'kind': 2,
                                      'id': Statement.to.commonuser.value.id,
                                    });
                                  })
                              : SizedBox()
                        ],
                      )),
                    ],
                  ),
                )
              : Text("로딩중");
        }),
      ),
    );
  }
}
