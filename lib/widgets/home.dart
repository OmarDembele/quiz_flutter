import 'package:flutter/material.dart';
import 'package:quiz_flutter/widgets/custom_text.dart';
import 'package:quiz_flutter/widgets/page_quizz.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 10.0,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/cover.jpg", fit: BoxFit.cover,),
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return PageQuizz();
                  }));
                },
                child: CustomText( "Commencer le quizz", factor: 2.0, color: Colors.white))
          ],

        ),
      ),
    );
  }
}
