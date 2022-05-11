import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context, widget._subjectTitle),
    );
  }

  getBody(BuildContext context, String subjectTitle) {
    CollectionReference subjectCollection =
        FirebaseFirestore.instance.collection('Subjects');
    final TextEditingController _commentcontroller = TextEditingController();
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
                    // var response = await subjectInfo.get();
                    //           var veri = response.data();
                    if (asyncSnapshot.hasData) {
                      DateTime dt =
                          (asyncSnapshot.data['Date'] as Timestamp).toDate();
                      String d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
                      return Column(
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
                          TextFormField(
                            minLines: 6,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _commentcontroller,
                            decoration: const InputDecoration(
                                labelText: 'Yorum Yap',
                                border: OutlineInputBorder(),
                                hintText: 'Bu kararı beğendim 👍'),
                          ),
                          ElevatedButton(
                            onPressed: (() {
                              //TODO: Yorum ekleme işlemi
                            }),
                            child: const Text("Gönder"),
                          ),
                        ],
                      );
                    } else {
                      return const Text("Hata oluştu.Sonra tekrar deneyiniz.");
                    }
                  }),
              ElevatedButton(
                onPressed: (() async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }),
                child: const Text("Anasayfa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
