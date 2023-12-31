import 'package:caganeira_control_pro/mobileAds/mobileAds.dart';
import 'package:caganeira_control_pro/multiplosde10/multiplosde10.dart';
import 'package:caganeira_control_pro/ranksystem.dart';
import 'package:caganeira_control_pro/toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Desenvolvido por HeroRickyGames

bool isStarted = false;
int caganeiraDay = 0;
var UID = FirebaseAuth.instance.currentUser?.uid;
bool init = false;
String id = "$UID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}";
int PDL = 0;
bool elobarro = false;
bool elofolha = false;
bool eloconcreto = false;
bool eloFerro = false;
bool eloPorcelana = false;
bool eloBronze = false;
bool eloPrata = false;
bool eloAco = false;
bool eloOuro = false;
bool eloPlatina = false;
bool eloMestre = false;
bool eloGM = false;
bool eloDesafiante = false;
bool eloDesafianteDeMerda = false;

class mainTela extends StatefulWidget {
  const mainTela({super.key});

  @override
  State<mainTela> createState() => _mainTelaState();
}

class _mainTelaState extends State<mainTela> {

  getUsersInformations() async {
    var resulte = await FirebaseFirestore.instance
        .collection("Users")
        .doc(UID)
        .get();

    setState(() {
      PDL = resulte['pdl'];

      elobarro = Barro(PDL);
      elofolha = Folha(PDL);
      eloconcreto = Concreto(PDL);
      eloFerro = Ferro(PDL);
      eloPorcelana = Porcelana(PDL);
      eloBronze = Bronze(PDL);
      eloPrata = Prata(PDL);
      eloAco = Aco(PDL);
      eloOuro = Ouro(PDL);
      eloPlatina = Platina(PDL);
      eloMestre = Mestre(PDL);
      eloGM = GM(PDL);
      eloDesafiante = Desafiante(PDL);
      eloDesafianteDeMerda = DesafianteDaMerda(PDL);
    });
  }
  @override
  Widget build(BuildContext context) {

    if(isStarted == false){
      getUsersInformations();
    }

    isStarted = true;
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
                .where("id", isEqualTo: id)
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
            ElevatedButton(
              onPressed: (){
                setState(() {
                  caganeiraDay ++;
                  FirebaseFirestore.instance.collection("caganeraday").doc(id).set({
                    "id": id,
                    "cagacont": caganeiraDay,
                    "idPertence": UID,
                    "data": "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}"
                  });

                  if(caganeiraDay < 10){
                    elobarro = Barro(PDL);
                    elofolha = Folha(PDL);
                    eloconcreto = Concreto(PDL);
                    eloFerro = Ferro(PDL);
                    eloPorcelana = Porcelana(PDL);
                    eloBronze = Bronze(PDL);
                    eloPrata = Prata(PDL);
                    eloAco = Aco(PDL);
                    eloOuro = Ouro(PDL);
                    eloPlatina = Platina(PDL);
                    eloMestre = Mestre(PDL);
                    eloGM = GM(PDL);
                    eloDesafiante = Desafiante(PDL);
                    eloDesafianteDeMerda = DesafianteDaMerda(PDL);

                    if(elobarro == true){
                      PDL = PDL + 100;
                    }

                    if(elofolha == true){
                      PDL = PDL + 80;
                    }

                    if(eloconcreto == true){
                      PDL = PDL + 70;
                    }

                    if(eloFerro == true){
                      PDL = PDL + 60;
                    }

                    if(eloPorcelana == true){
                      PDL = PDL + 55;
                    }

                    if(eloBronze == true){
                      PDL = PDL + 53;
                    }

                    if(eloPrata == true){
                      PDL = PDL + 50;
                    }

                    if(eloAco == true){
                      PDL = PDL + 48;
                    }

                    if(eloOuro == true){
                      PDL = PDL + 45;
                    }

                    if(eloPlatina == true){
                      PDL = PDL + 40;
                    }

                    if(eloMestre == true){
                      PDL = PDL + 35;
                    }

                    if(eloGM == true){
                      PDL = PDL + 25;
                    }

                    if(eloDesafiante == true){
                      PDL = PDL + 20;
                    }

                    if(eloDesafianteDeMerda == true){
                      PDL = PDL + 20;
                    }

                    FirebaseFirestore.instance.collection("Users").doc(UID).update({
                      "pdl": PDL
                    });
                  }

                  bool multi = ehMultiploDe10(caganeiraDay);

                  if(multi){
                    interAdReward(false);
                  }

                  if(caganeiraDay == 15){
                    toastShow("Está cagando de mais hoje!", "SHORT");
                  }

                  if(caganeiraDay == 17){
                    toastShow("Talvez você esteja com sinais de diarreia!", "SHORT");
                  }

                  if(caganeiraDay == 20){
                    toastShow("Melhor você ir a um hospital", "SHORT");
                  }

                  if(caganeiraDay == 25){
                    toastShow("A industria de papel tá crescendo e você está financiando!", "SHORT");
                  }

                  if(caganeiraDay == 30){
                    toastShow("Vai colocar até às tripas para fora deste jeito", "SHORT");
                  }

                });
              },
              child: const Text('ACABEI DE CAGAR'),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  elobarro == true ?
                  Image.asset(
                      "assets/elos/elo_barro.png",
                    scale: 4,
                  ):
                  elofolha == true ?
                  Image.asset(
                    "assets/elos/elo_folha.png",
                    scale: 4,
                  ):
                  eloconcreto == true ?
                  Image.asset(
                    "assets/elos/elo_concreto.png",
                    scale: 4,
                  ):
                  eloFerro == true ?
                  Image.asset(
                    "assets/elos/elo_ferro.png",
                    scale: 4,
                  ):
                  eloPorcelana == true ?
                  Image.asset(
                    "assets/elos/elo_procelana.png",
                    scale: 4,
                  ):
                  eloBronze == true ?
                  Image.asset(
                    "assets/elos/elo_bronze.png",
                    scale: 4,
                  ):
                  eloPrata == true ?
                  Image.asset(
                    "assets/elos/Elo_Prata.png",
                    scale: 4,
                  ):
                  eloAco == true ?
                  Image.asset(
                    "assets/elos/elo_aco.png",
                    scale: 4,
                  ):
                  eloOuro == true ?
                  Image.asset(
                    "assets/elos/elo_ouro.png",
                    scale: 4,
                  ):
                  eloPlatina == true ?
                  Image.asset(
                    "assets/elos/elo_platina.png",
                    scale: 4,
                  ):
                  eloMestre == true ?
                  Image.asset(
                    "assets/elos/elo_mestre.png",
                    scale: 4,
                  ):
                  eloGM == true ?
                  Image.asset(
                    "assets/elos/gm.png",
                    scale: 4,
                  ):
                  eloDesafiante == true ?
                  Image.asset(
                    "assets/elos/elo_desafiante.png",
                    scale: 4,
                  ):
                  eloDesafianteDeMerda == true ?
                  Image.asset(
                    "assets/elos/elo_desafiante.png",
                    scale: 4,
                  ):
                  Container(),
                  Text('Pontos de Rank: $PDL'),
                  eloDesafianteDeMerda == true ?
                  const Text(
                    textAlign: TextAlign.center,
                      "MEUS PARABENZIO! Você virou o Desafiante das Merdas, a maior merda que a humanidade fez, literalmente"
                  ):
                      Container()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(26),
              child: const mobileAds(),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: StreamBuilder(stream: FirebaseFirestore.instance
            .collection('caganeraday')
            .where("idPertence", isEqualTo: UID)
            .snapshots(), builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Container();
          }
          if(snapshot.data!.docs.isEmpty){
            return Container();
          }
          return Center(
            child: ListView(
              children: snapshot.data!.docs.map((documents) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Text("data: ${documents['data']} vezes cagadas: ${documents['cagacont']}"),
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
