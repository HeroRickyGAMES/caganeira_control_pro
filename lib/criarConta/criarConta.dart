import 'package:caganeira_control_pro/loginScreen/login.dart';
import 'package:caganeira_control_pro/mainTela/mainTela.dart';
import 'package:caganeira_control_pro/mobileAds/mobileAds.dart';
import 'package:caganeira_control_pro/toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Desenvolvido por HeroRickyGames

class criarConta extends StatefulWidget {
  const criarConta({super.key});

  @override
  State<criarConta> createState() => _criarContaState();
}

class _criarContaState extends State<criarConta> {
  String nome = '';
  String Email = '';
  String Senha = '';

  irParaTelaMain(){
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return const mainTela();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Criar sua conta',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  "assets/ic_launcher.png",
                  scale: 2,
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    enableSuggestions: true,
                    autocorrect: false,
                    onChanged: (value){
                      setState(() {
                        nome = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.yellow), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.black
                        ),
                      ),
                      hintText: 'Seu nome',
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    autocorrect: false,
                    onChanged: (value){
                      setState(() {
                        Email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.yellow), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.black
                        ),
                      ),
                      hintText: 'Seu Email',
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value){
                      setState(() {
                        Senha = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.yellow), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.black
                        ),
                      ),
                      hintText: 'Sua Senha',
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(onPressed: () async {
                  if(nome == ''){
                    toastShow("Preencha seu nome!", "SHORT");
                  }else{
                    if(Email == ''){
                      toastShow("Preencha seu email!", "SHORT");
                    }else{
                      if(Senha == ''){
                        toastShow("Preencha seu senha!", "SHORT");
                      }else{
                        if(!Email.contains("@")){
                          toastShow("Preencha o email corretamente", "SHORT");
                        }else{
                          if(!Email.contains(".com")){
                            toastShow("Preencha o email corretamente", "SHORT");
                          }else{
                            if(Senha.length < 8){
                              toastShow("Sua senha é curta de mais!", "SHORT");
                            }else{
                              var auth = FirebaseAuth.instance;

                              auth.createUserWithEmailAndPassword(email: Email, password: Senha).whenComplete(() {
                                var UID = FirebaseAuth.instance.currentUser?.uid;

                                FirebaseFirestore.instance.collection('Users').doc(UID).set({
                                  'uid': UID,
                                  'Nome' : nome.trim(),
                                  'Email': Email.trim(),
                                  "pdl": 0
                                }).whenComplete(() {
                                  irParaTelaMain();
                                });
                              }).catchError((e){
                                toastShow("Ocorreu um erro: $e", "SHORT");
                              });
                            }
                          }
                        }
                      }
                    }
                  }
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent
                    ),child: const Text(
                      'Criar uma conta.',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              ),
              Container(
                padding: const EdgeInsets.all(26),
                child: const mobileAds(),
              ),
              WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return const login();
                      }));
                  return false;
                }, child: const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
