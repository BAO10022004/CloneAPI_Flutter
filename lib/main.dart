import 'dart:io';
import 'dart:math';

import 'package:api/Services/FlutterServies/Dictionary.dart';
import 'package:api/Services/FlutterServies/TextToSpeech.dart';
import 'package:api/Services/GoogleServecis/Translate/Translate.dart';
import 'package:api/Services/Others/GrammarDoctor.dart';
import 'package:api/Services/ResponseServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String text = "Hello World";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Text',
            ),
          ),
          const SizedBox(height: 20),
           Text(text),
          ElevatedButton(
            // onPressed: ()  async {
            //   // TextToSpeech textToSpeech = TextToSpeech();
            //   // textToSpeech.speak(_controller.text);
            //   // Translator translator = Translator();
            //   // final rel= await translator.getTranslation( TranslationQuery(fromCode: "vn",toCode: "en", translateQuery: _controller.text));
            //   // setState(()  {
            //   //   text = rel;
            //   // });
            //   //await GrammarDoctor().checkGrammar("She went to school yesterday.");
            //   ResponseServices response = await Dictionary.getWordDetails("hello");
            //  // ignore: avoid_print
            //  WordDetails wordDetails = response.data as WordDetails;
            // print(wordDetails.Word);
            // print(wordDetails.Phonetics);
            // for (var part in wordDetails.Part!) {
            //   print("Part of Speech: ${part.Name}");
            //   print("Definition: ${part.Definition}");
            //   print("Example: ${part.Example}");
            // }
            // print("OK");
            // },
            onPressed: () async {
            ResponseServices response = await Dictionary.getWordDetails("Pineapple");

            if (response.statusCode == 200 && response.data != null) {
              WordDetails wordDetails = response.data as WordDetails;

              print("Word: ${wordDetails.Word}");
              print("Phonetics: ${wordDetails.Phonetics}");

              for (var part in wordDetails.Part ?? []) {
                print("Part of Speech: ${part.Name}");
                print("Definition: ${part.Definition}");
                print("Example: ${part.Example}");
              }
            } else {
              print("❌ Không tìm thấy từ hoặc lỗi API");
            }
          },
            child: const Text('Play'),
          ),
        ],),
      )
    );
  }
}
