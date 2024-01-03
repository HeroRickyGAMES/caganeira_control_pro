import 'package:caganeira_control_pro/criarConta/criarConta.dart';
import 'package:caganeira_control_pro/mainTela/mainTela.dart';
import 'package:caganeira_control_pro/mobileAds/mobileAds.dart';
import 'package:caganeira_control_pro/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Desenvolvido por HeroRickyGames

final FirebaseAuth _auth = FirebaseAuth.instance;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
            'Login',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                        borderSide: BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.black
                        ),
                      ),
                      hintText: 'Email',
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
                        borderSide: BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.black
                        ),
                      ),
                      hintText: 'Senha',
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(onPressed: () async {

                  if(Email == ''){
                    toastShow("Preencha seu email!", "SHORT");
                  }else{
                    if(Senha == ''){
                      toastShow("Preencha sua senha!", "SHORT");
                    }else{
                      bool onError = false;
                      _auth.signInWithEmailAndPassword(email: Email, password: Senha).catchError((e){
                        onError = true;
                        toastShow("Ocorreu um erro: $e", "SHORT");
                      }).whenComplete(() {
                        if(onError == false){
                          irParaTelaMain();
                        }
                      });
                    }
                  }
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent
                    ),
                    child: const Text(
                      'Logar',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              ),
              TextButton(onPressed: (){

                if(Email == ''){
                  toastShow("Preencha o seu email!", "SHORT");
                }else{
                  var auth = FirebaseAuth.instance;

                  auth.sendPasswordResetEmail(email: Email).whenComplete((){
                    toastShow( "Email de recuperação enviado para seu email! Verifique na caixa de spam ou na recebida!", "LONG");
                  });
                }
              }, child: const Text(
                'Esqueceu sua Senha?',
                style: TextStyle(
                    color: Colors.deepPurpleAccent
                ),
              )
              ),
              const Text(
                'Você ainda não tem uma conta?',
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return const criarConta();
                    }));
              }, child: const Text(
                'Crie uma conta agora!',
                style: TextStyle(
                    color: Colors.deepPurpleAccent
                ),
              )
              ),
              Container(
                padding: const EdgeInsets.all(26),
                child: const mobileAds(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
