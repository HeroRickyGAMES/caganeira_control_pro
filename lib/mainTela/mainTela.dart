import 'package:caganeira_control_pro/mobileAds/mobileAds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int caganeiraDay = 0;
var UID = FirebaseAuth.instance.currentUser?.uid;
bool init = false;

class mainTela extends StatefulWidget {
  const mainTela({super.key});

  @override
  State<mainTela> createState() => _mainTelaState();
}

class _mainTelaState extends State<mainTela> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Quanto caguei hoje?',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Cagadas de hoje:",
              style: TextStyle(
                  fontSize: 25
              ),
            ),
            StreamBuilder(stream: FirebaseFirestore.instance
                .collection('caganeraday')
                .where("idPertence", isEqualTo: UID)
                .snapshots(), builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot){

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: Text(
                    '$caganeiraDay',
                    style: const TextStyle(
                        fontSize: 35
                    ),
                  ),
                );
              }

              return Center(
                child: Stack(
                  children: snapshot.data!.docs.map((documents) {

                    addInt() async {
                      if(init == false){
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() {
                          caganeiraDay = documents['cagacont'];
                        });
                      }
                    }

                    addInt();
                    init = true;
                    return Text(
                      "${documents['cagacont']}",
                      style: const TextStyle(
                          fontSize: 35
                      ),
                    );
                  }).toList(),
                ),
              );
              }),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    String id = "$UID${DateTime.now().month}${DateTime.now().day}${DateTime.now().year}";
                    caganeiraDay ++;
                    FirebaseFirestore.instance.collection("caganeraday").doc(id).set({
                      "id": id,
                      "cagacont": caganeiraDay,
                      "idPertence": UID
                    });
                  });
                },
                child: const Text('ACABEI DE CAGAR'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(26),
              child: const mobileAds(),
            )
          ],
        ),
      ),
    );
  }
}
