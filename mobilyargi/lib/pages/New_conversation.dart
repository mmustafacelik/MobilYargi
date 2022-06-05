import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ConversationPage/ConversationPage.dart';

class NewConversation extends StatefulWidget {
  NewConversation({Key? key}) : super(key: key);

  @override
  State<NewConversation> createState() => _NewConversationState();
}

class _NewConversationState extends State<NewConversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(FirebaseAuth.instance.currentUser!.email ?? "null"),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..");
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs
                          .map((doc) => ListTile(
                                leading: const CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      "https://picsum.photos/600/1100"),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(doc["UserNickname"]),
                                subtitle: Text(doc["UsersEmail"]),
                                onTap: () async {
                                  var members = [
                                    FirebaseAuth.instance.currentUser!.uid,
                                    doc["uuid"]
                                  ];
                                  var docRef = await FirebaseFirestore.instance
                                      .collection("conversations")
                                      .add({
                                    "displayName": "first",
                                    "members": members,
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConversationPage(
                                                userID: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                conversationID: docRef.id,
                                              )));
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }));
  }
}
