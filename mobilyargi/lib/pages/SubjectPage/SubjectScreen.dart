import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilyargi/pages/HomePage/Homepage.dart';
import 'package:intl/intl.dart';

class SubjectScreen extends StatefulWidget {
  final String _subjectTitle;
  const SubjectScreen(
    this._subjectTitle, {
    Key? key,
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final TextEditingController _commentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context, widget._subjectTitle),
    );
  }

  getBody(BuildContext context, String subjectTitle) {
    CollectionReference subjectCollection =
        FirebaseFirestore.instance.collection('Subjects');
    Query<Map<String, dynamic>> subcollections = FirebaseFirestore.instance
        .collectionGroup('Comments')
        .where('subject', isEqualTo: subjectTitle);
    var subjectInfo = subjectCollection.doc(subjectTitle);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/subjectpagebackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: subjectInfo.snapshots(),
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      Future<String> nickName() async {
                        CollectionReference usersRef =
                            FirebaseFirestore.instance.collection('Users');
                        var userinfo = await usersRef
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .get();
                        return (userinfo['UserNickname']) ?? 'null';
                      }

                      DateTime dt =
                          (asyncSnapshot.data['Date'] as Timestamp).toDate();
                      String d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
                      return Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 228, 161, 156),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text('${asyncSnapshot.data['Title']}'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 228, 161, 156),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text('${asyncSnapshot.data['Index']}'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 228, 161, 156),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Text(
                                      'Yazar....:${asyncSnapshot.data['Writer']}'),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 228, 161, 156),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Text(
                                      'Beğeni Sayısı...:${asyncSnapshot.data['NumberofLike']}'),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 228, 161, 156),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text("Tarih..:" + d24.toString()),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Subjects')
                                    .doc(widget._subjectTitle)
                                    .collection("Comments")
                                    .orderBy('Date', descending: false)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Expanded(
                                        child: CircularProgressIndicator());
                                  } else {
                                    QuerySnapshot<Map<String, dynamic>> data =
                                        snapshot.data!;
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Column(children: [
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: ((context, index) {
                                              // for(String key in data.docs[index].data().keys)

                                              return Card(
                                                color: Colors.orange.shade100,
                                                child: Text(
                                                  data.docs[index]
                                                      .data()
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              );
                                            }),
                                            itemCount: data.docs.length,
                                          ),
                                        ]),
                                      ),
                                    );
                                  }
                                }),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 40,
                            ),
                            TextFormField(
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _commentcontroller,
                              decoration: const InputDecoration(
                                  labelText: 'Yorum Yap',
                                  border: OutlineInputBorder(),
                                  hintText: 'Bu kararı beğendim 👍'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: (() async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                  }),
                                  child: const Text("Anasayfa"),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                ),
                                ElevatedButton(
                                  onPressed: (() async {
                                    if (_commentcontroller.text.isNotEmpty) {
                                      String nickname = await nickName();
                                      await FirebaseFirestore.instance
                                          .collection('Subjects')
                                          .doc(widget._subjectTitle)
                                          .collection("Comments")
                                          .add({
                                        nickname: _commentcontroller.text,
                                        "Date": DateTime.now().hour.toString() +
                                            ":" +
                                            DateTime.now().minute.toString() +
                                            ":" +
                                            DateTime.now().second.toString(),
                                      });
                                      _commentcontroller.clear();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Yorumunuz boş olamaz",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }),
                                  child: const Text("Gönder"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Hata oluştu.Sonra tekrar deneyiniz.");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
