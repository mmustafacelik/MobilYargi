import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String userID;
  final String conversationID;
  const ConversationPage(
      {Key? key, required this.userID, required this.conversationID})
      : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController editingController = TextEditingController();
  late CollectionReference _ref;
  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection("conversations/${widget.conversationID}/messages");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            children: const <Widget>[
              CircleAvatar(),
              SizedBox(
                width: 5,
              ),
              Text("Kişi"),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://picsum.photos/600/1100"))),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: _ref.orderBy("timeStamp").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? const CircularProgressIndicator()
                          : ListView(
                              children: snapshot.data!.docs
                                  .map((document) => ListTile(
                                        title: Align(
                                            alignment: widget.userID !=
                                                    document["senderID"]
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    borderRadius: const BorderRadius
                                                            .horizontal(
                                                        left:
                                                            Radius.circular(10),
                                                        right: Radius.circular(
                                                            10))),
                                                child:
                                                    Text(document["message"]))),
                                      ))
                                  .toList(),
                            );
                    }),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20))),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: editingController,
                                decoration: const InputDecoration(
                                    hintText: "Mesajinizi giriniz",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10))),
                          ),
                          InkWell(
                            child: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.send),
                              onPressed: () async {
                                await _ref.add({
                                  "senderID": widget.userID,
                                  "message": editingController.text,
                                  "timeStamp": DateTime.now()
                                });

                                FirebaseFirestore.instance
                                    .collection("conversations")
                                    .doc(widget.conversationID)
                                    .update({
                                  "displayName": editingController.text
                                });

                                editingController.text = "";
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
