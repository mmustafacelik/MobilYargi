import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilyargi/componenets/Text_field/Bookmark.dart';
import 'package:mobilyargi/pages/HomePageScreen/cubit/homepagescreen_cubit.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: getBody(context),
    );
  }

  getBody(BuildContext context) {
    CollectionReference subjectlist =
        FirebaseFirestore.instance.collection('Subjects');
    return BlocProvider(
      create: ((context) => HomepagescreenCubit()),
      child: StreamBuilder<QuerySnapshot>(
          stream: subjectlist.snapshots(),
          builder: (BuildContext context, snap) {
            if (snap.data == null) return CircularProgressIndicator();
            List<DocumentSnapshot> listofDocuments = snap.data!.docs;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                DateTime dt =
                    (listofDocuments[index]['Date'] as Timestamp).toDate();
                String d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
                return InkWell(
                  onTap: () {
                    //todo: buraya basıldığı anda o basılan konu sayfasına gidecek
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.01),
                    color: const Color.fromRGBO(37, 204, 223, 0.5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                listofDocuments[index]['Title'],
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            //todo: burada bookmark içindeki ontap butonu tetiklenip konunun beğeni sayısını
                            //Todo: arttırıp hangi user bastıysa onun favoritetopic kısmına konuid eklenecek
                            const Bookmark(),
                          ],
                        ),
                        Text(
                          listofDocuments[index]['Index'],
                          style: const TextStyle(fontSize: 24),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                "Yazar...:" + listofDocuments[index]['Writer'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: Card(
                                color: Colors.red,
                                child: Text(
                                  "Beğeni...:" +
                                      listofDocuments[index]['NumberofLike']
                                          .toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: Card(
                                color: Colors.green,
                                child: Text(
                                  "Tarih...:" + d24,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
              itemCount: listofDocuments.length,
            );
          }),
    );
  }
}

// bool _admin = false;
// void isAdmin() async {
//   CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
//   var userinfo =
//       await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
//   _admin = userinfo['IsAdmin'];
// }

