import 'package:caganeira_control_pro/firebase_options.dart';
import 'package:caganeira_control_pro/loginScreen/login.dart';
import 'package:caganeira_control_pro/mainTela/mainTela.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Desenvolvido por HeroRickyGames

initDB(context) async {

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    if(user == null){
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return const login();
          }));
    }else{
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return const mainTela();
          }));
    }
  });
}

main(){
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true
      ),
      home: PrimeiraTela(),
    )
  );
}

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {

  @override
  Widget build(BuildContext context) {

    initDB(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Aguarde!',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
