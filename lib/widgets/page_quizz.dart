import 'package:flutter/material.dart';
import 'package:quiz_flutter/models/Question.dart';
import 'custom_text.dart';

class PageQuizz extends StatefulWidget {
  const PageQuizz({Key? key}) : super(key: key);

  @override
  State<PageQuizz> createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz> {

  late Question questions;
  int index = 0;
  int score = 0;

  List<Question> listeQuestions = [
     Question('La devise de la Belgique est l\'union fait la force', true, '', 'belgique.JPG'),
     Question('La lune va finir par tomber sur terre à cause de la gravité', false, 'Au contraire la lune s\'éloigne', 'lune.jpg'),
     Question('La Russie est plus grande en superficie que Pluton', true, '', 'russie.jpg'),
     Question('Nyctalope est une race naine d\'antilope', false, 'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
     Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu', true, '', 'commodore.jpg'),
     Question('Le nom du drapeau des pirates es black skull', false, 'Il est appelé Jolly Roger', 'pirate.png'),
     Question('Haddock est le nom du chien Tintin', false, 'C\'est Milou', 'tintin.jpg'),
     Question('La barbe des pharaons était fausse', true, 'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),
     Question('Au Québec tire toi une bûche veut dire viens viens t\'asseoir', true, 'La bûche, fameuse chaise de bucheron', 'buche.jpg'),
     Question('Le module lunaire Eagle de possédait de 4Ko de Ram', true, 'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),
  ];

  Widget boutonBool(bool b){
    return ElevatedButton(
        onPressed: (() => dialog(b)),
        child: CustomText((b)? "Vrai" : "Faux", factor: 2.0, color: Colors.white,)
    );
  }

  Future<Null> dialog (bool b) async{
    bool bonneRepose = (b == questions.reponse);
    String vrai = "assets/vrai.jpg";
    String faux = "assets/faux.jpg" ;
    if(bonneRepose){
      score++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            title: CustomText((bonneRepose)? "C'est gagné!": "Oops perdu...", factor: 1.4, color: (bonneRepose)? Colors.green: Colors.red,),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Image.asset((bonneRepose)? vrai: faux, fit: BoxFit.cover,),
              Container(
                height: 25.0,),
              CustomText( questions.explication ,factor: 1.25, color: Colors.grey[900],),
              Container(height: 25,),
              ElevatedButton(
                onPressed: (){
                Navigator.pop(context);
                questionSuivante();
              }, child: CustomText("Au suivant", factor: 1.5, color: Colors.white,),
              )
            ],
          );
        }
    );
  }

  Future<Null> alert() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildeContext){
          return AlertDialog(
            title: CustomText("C'est fini", color: Colors.blue, factor: 1.25,),
            contentPadding: EdgeInsets.all(10.0),
            content: CustomText("Votre score est : $score / $index", color: Colors.grey[900],),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(buildeContext);
                    Navigator.pop(context);
                  },
                  child: CustomText("OK", factor: 1.25, color: Colors.white,)
              )
            ],
          );
        });
  }

  void questionSuivante(){
    if(index< listeQuestions.length){
      index++;
      setState(() {
        questions = listeQuestions[index];
      });
    }
    else{
      alert();
    }
  }

  @override
  void initState(){
    super.initState();
    questions = listeQuestions[0];
  }

  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    return  Scaffold(
      appBar: AppBar(
        title: CustomText("Le quizz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText("Question numero ${index + 1}", color: Colors.grey[900], factor: 1.3,),
            CustomText("Score: $score / $index", color: Colors.grey[900], factor: 1.3,),
            Card(
              elevation: 10.0,
              child: Container(
                height: taille,
                width: taille,
                child: Image.asset("assets/${questions.imagePage}", 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomText(questions.question, color: Colors.grey[900], factor: 1.4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  boutonBool(true),
                  boutonBool(false),
                ],
            )
          ],
        ),
      ),
    );
  }
}
