import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilyargi/pages/ConversationPage/ConversationPage.dart';
import 'package:mobilyargi/pages/New_conversation.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key? key}) : super(key: key);
  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversations")
            .where('members', arrayContains: userID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: Colors.white30,
                    child: TextButton(
                        onPressed: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewConversation(),
                            ),
                          );
                        }),
                        child: const Text("Sohbet Başlat"))),
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs
                      .map((doc) => ListTile(
                            leading: const CircleAvatar(),
                            title: const Text("Kişi"),
                            subtitle: Text(doc["displayName"]),
                            trailing: Column(
                              children: [
                                const Text("20:04"),
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  child: const Center(
                                    child: Text("1",
                                        textScaleFactor: 0.9,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConversationPage(
                                            userID: userID,
                                            conversationID: doc.id,
                                          )));
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        });
  }
}
