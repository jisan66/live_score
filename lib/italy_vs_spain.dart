import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItalyVSSpain extends StatelessWidget {
  const ItalyVSSpain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Italy vs Spain"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("live_score")
                .doc("italy_vs_spain")
                .snapshots(),
            builder:
                (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot)
            {
              if (snapshot.hasData) {
                final score = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(score.get("match_name").toString(),
                                  style: Theme.of(context).textTheme.headlineMedium),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(score.get("score_team_a").toString(),
                                      style:
                                      Theme.of(context).textTheme.headlineLarge),
                                  Text(" : ",
                                      style:
                                      Theme.of(context).textTheme.headlineLarge),
                                  Text(score.get("score_team_b").toString(),
                                      style:
                                      Theme.of(context).textTheme.headlineLarge)
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text("Time : ${score.get("time").toString()}",
                                  style: const TextStyle(fontSize: 24)),
                              const SizedBox(
                                height: 16,
                              ),
                              Text("Full Time : ${score.get("full_time").toString()}",
                                  style: const TextStyle(fontSize: 18))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              else {
                return const Center(child: CircularProgressIndicator());
              }
            })
    );
  }
}
