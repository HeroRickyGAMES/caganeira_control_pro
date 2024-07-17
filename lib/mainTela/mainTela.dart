import 'package:caganeira_control_pro/mobileAds/mobileAds.dart';
import 'package:caganeira_control_pro/multiplosde10/multiplosde10.dart';
import 'package:caganeira_control_pro/ranksystem.dart';
import 'package:caganeira_control_pro/toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Desenvolvido por HeroRickyGames

String elo = "";
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
bool eloMestreSolar = false;
bool eloMestredaGalaxia = false;
bool eloMestreUniverso = false;
bool eloMestreMultiverso = false;
bool eloDeusMestre = false;
bool eloDeusRei = false;

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
      eloMestreSolar = MestredoSistemaSolar(PDL);
      eloMestredaGalaxia = MestreDaGalaxia(PDL);
      eloMestreUniverso = MestredoUniverso(PDL);
      eloMestreMultiverso = MestreDoMultiverso(PDL);
      eloDeusMestre = DeusMestre(PDL);
      eloDeusRei = DeusRei(PDL);
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
                  setState(() async {
                    caganeiraDay ++;
                    FirebaseFirestore.instance.collection("caganeraday").doc(id).set({
                      "id": id,
                      "cagacont": caganeiraDay,
                      "idPertence": UID,
                      "data": "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}"
                    });

                    if(caganeiraDay < 10){
                      if(elobarro == true){
                        PDL = PDL + 110;
                        elo = "Barro";
                      }

                      if(elofolha == true){
                        PDL = PDL + 90;
                        elo = "Folha";
                      }

                      if(eloconcreto == true){
                        PDL = PDL + 80;
                        elo = "Concreto";
                      }

                      if(eloFerro == true){
                        PDL = PDL + 70;
                        elo = "Ferro";
                      }

                      if(eloPorcelana == true){
                        PDL = PDL + 60;
                        elo = "Porcelana";
                      }

                      if(eloBronze == true){
                        PDL = PDL + 55;
                        elo = "Bronze";
                      }

                      if(eloPrata == true){
                        PDL = PDL + 53;
                        elo = "Prata";
                      }

                      if(eloAco == true){
                        PDL = PDL + 50;
                        elo = "Aço";
                      }

                      if(eloOuro == true){
                        PDL = PDL + 45;
                        elo = "Ouro";
                      }

                      if(eloPlatina == true){
                        PDL = PDL + 40;
                        elo = "Platina";
                      }

                      if(eloMestre == true){
                        PDL = PDL + 35;
                        elo = "Mestre";
                      }

                      if(eloGM == true){
                        PDL = PDL + 30;
                        elo = "Grão Mestre";
                      }

                      if(eloDesafiante == true){
                        PDL = PDL + 25;
                        elo = "Desafiante";
                      }

                      if(eloDesafianteDeMerda == true){
                        PDL = PDL + 25;
                        elo = "Desafiante";
                      }

                      if(eloMestreSolar == true){
                        PDL = PDL + 20;
                        elo = "Mestre do Sistema Solar";
                      }

                      if(eloMestredaGalaxia == true){
                        PDL = PDL + 15;
                        elo = "Mestre da Galaxia";
                      }

                      if(eloMestreUniverso == true){
                        PDL = PDL + 10;
                        elo = "Mestre do Universo";
                      }

                      if(eloMestreMultiverso == true){
                        PDL = PDL + 7;
                        elo = "Mestre do Multiverso";
                      }

                      if(eloDeusMestre == true){
                        PDL = PDL + 5;
                        elo = "Deus Mestre";
                      }

                      if(eloDeusRei == true){
                        PDL = PDL + 4;
                        elo = "Deus Rei";
                      }

                      FirebaseFirestore.instance.collection("Users").doc(UID).update({
                        "pdl": PDL
                      });

                      var resulte = await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(UID)
                          .get();
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
                      eloMestreSolar = MestredoSistemaSolar(PDL);
                      eloMestredaGalaxia = MestreDaGalaxia(PDL);
                      eloMestreUniverso = MestredoUniverso(PDL);
                      eloMestreMultiverso = MestreDoMultiverso(PDL);
                      eloDeusMestre = DeusMestre(PDL);
                      eloDeusRei = DeusRei(PDL);
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

                    if(caganeiraDay == 40){
                      toastShow("Mar rapaz, Desse jeito você lotar mais ainda o Rio Tiete!", "SHORT");
                    }

                    if(caganeiraDay > 50){
                      toastShow("Haja Merda viu kkkkkkkkkk!", "SHORT");
                    }
                  }
                );
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
                  eloMestreSolar == true ?
                  Image.asset(
                    "assets/elos/MestreSistemaSolar.png",
                    scale: 4,
                  ):
                  eloMestredaGalaxia == true ?
                  Image.asset(
                    "assets/elos/MestreGalaxia.png",
                    scale: 4,
                  ):
                  eloMestreUniverso == true ?
                  Image.asset(
                    "assets/elos/MestreUniverso.png",
                    scale: 4,
                  ):
                  eloMestreMultiverso == true ?
                  Image.asset(
                    "assets/elos/MestreMultiverso.png",
                    scale: 4,
                  ):
                  eloDeusMestre == true ?
                  Image.asset(
                    "assets/elos/DeusMestre.png",
                    scale: 4,
                  ):
                  eloDeusRei == true ?
                  Image.asset(
                    "assets/elos/DeusRei.png",
                    scale: 4,
                  ):
                  Container(),
                  Text('Pontos de Rank: $PDL'),
                  Container(
                    padding: const EdgeInsets.all(26),
                    child: Text(elo),
                  ),
                  eloDesafianteDeMerda == true ?
                  const Text(
                    textAlign: TextAlign.center,
                      "MEUS PARABENZIO! Você virou o Desafiante das Merdas, a maior merda que a humanidade fez, literalmente"
                  ):
                      Container(),
                  eloDeusRei == true ?
                  const Text(
                      textAlign: TextAlign.center,
                      "Parabéns! Você acaba de chegar ao maior ranking! Depois de muita cagada, muito esforço e muita merda, você chegou! Você merece!"
                  ):
                  Container(),
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
