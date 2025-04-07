import 'package:api/Services/ResponseServices.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GrammarDoctor {
  Future<Response> checkGrammar(String text) async {
  final uri = Uri.parse('https://api.languagetool.org/v2/check');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'text': text,
      'language': 'en-US',
    },
  );

  if (response.statusCode == 200) {
     final result = json.decode(response.body);
    //   for (var match in result['matches']) {
    //     print("Lỗi: ${match['shortMessage']}");
    //     print("Gợi ý: ${match['replacements'].map((r) => r['value']).join(', ')}");
    //   }
    // print(result['matches']);
    if (result['matches'].isEmpty) {

      return Response(statusCode: 200, data: [], );
    } else {
      List<Word> dataErrors = [];
      result['matches'].forEach((match) {
          dataErrors.add(Word(
            startIndex: match['offset'],
            endIndex: match['offset'] + match['length'],
            word: text.substring(match['offset'], match['offset'] + match['length']),
          ));
      });
      return Response(message: "Có lỗi ngữ pháp được phát hiện.", data: dataErrors, statusCode: 200);
    }
  } else {
    return Response(message: "Lỗi: ${response.statusCode}",data : [], statusCode: response.statusCode);
  }
}
}
class Response  extends ResponseServices {
  String? message;

  Response({this.message, required super.statusCode, required super.data});
}
class Word{
  int? startIndex;
  int? endIndex;
  String? word;
  Word({this.startIndex, this.endIndex, this.word});
}