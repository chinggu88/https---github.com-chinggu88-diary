import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/memo_controller.dart';
import 'package:meridasns/model/memo.dart';

class MemoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Memolist.to.memolist != 0
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(Memolist.to.memolist.length, (index) {
                  return Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                Get.defaultDialog(
                                    title: "확인",
                                    middleText: "삭제하겠습니까?",
                                    onConfirm: () {
                                      Memolist.to.deletememo(
                                          Memolist.to.memolist[index].text,
                                          Memolist.to.memolist[index].date);
                                      Memolist.to.fetchPosts();
                                      Get.back();
                                    },
                                    confirmTextColor: Colors.red,
                                    onCancel: () => Get.back());
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            child: SingleChildScrollView(
                              child: Text(
                                Memolist.to.memolist[index].text,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Text(
                            Memolist.to.memolist[index].date,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }))
            : Get.dialog(AlertDialog(
                title: Image.asset(
                  'asset/loading/unnamed.gif',
                  scale: 0.5,
                ),
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
              ));
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Get.bottomSheet(Container(
            height: Get.size.height * 0.8,
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(hintText: '내용을 입력하세요'),
                  controller: Memolist.to.memoController,
                ),
                IconButton(
                    icon: Icon(Icons.check),
                    iconSize: 50,
                    color: Colors.orangeAccent,
                    onPressed: () async {
                      Get.dialog(AlertDialog(
                        title: Image.asset(
                          'asset/loading/unnamed.gif',
                          scale: 0.5,
                        ),
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                      ));
                      Memolist.to.savememo();
                      Memolist.to.fetchPosts();
                      Get.back();
                    }),
              ],
            ),
          ));
        },
        label: Text('메모추가'),
        backgroundColor: Colors.amber,
        icon: Icon(Icons.add),
      ),
    );
  }
}
