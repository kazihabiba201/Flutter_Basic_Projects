
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/match_detailes.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
      ),
      body: StreamBuilder(
        stream: firestore.collection('basketball').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError == true) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data?.docs.isEmpty == true) {
            return const Center(child: Text('An error occurred.'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            // log(snapshot.data!.docs.length.toString());
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${snapshot.data!.docs[index].get('team_a')} vs ${snapshot.data!.docs[index].get('team_b')}', style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () {
                    navigateToMatchDetailsScreen(snapshot.data!.docs[index].id);
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void navigateToMatchDetailsScreen(String matchName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsApp(
          matchName: matchName,
        ),
      ),
    );
  }
}
