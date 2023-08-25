import 'package:flutter/material.dart';
import 'arg_vs_africa.dart';
import 'italy_vs_spain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Match List"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("live_score")
                .doc("arg_vs_africa")
                .snapshots(),
            builder:
                (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              if (snapshot.hasData) {
                final score = snapshot.data!;
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(score.get("match_name").toString()),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ArgentinaVSAfrica()));
                            },
                          ),
                          ListTile(
                            title: const Text("Italy vs Spain"),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ItalyVSSpain()));
                            },
                          )
                        ],
                      );
                    });
              }
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
