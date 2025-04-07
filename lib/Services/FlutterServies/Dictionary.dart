import 'package:api/Services/ResponseServices.dart';
import 'package:free_dictionary_api_v2/free_dictionary_api_v2.dart';
class Dictionary
{
  static Future<ResponseServices> getWordDetails(String word) async {
  if (word.trim().isEmpty) {
    return ResponseServices(statusCode: 400, data: null);
  }

  try {
    final dictionary = FreeDictionaryApiV2();
    final response = await dictionary.getDefinition(word);

    if (response.isEmpty) {
      return ResponseServices(statusCode: 404, data: null);
    }

    final wordData = response.first;

    WordDetails wordDetails = WordDetails(
      Word: wordData.word,
      Phonetics: (wordData.phonetics != null && wordData.phonetics!.isNotEmpty)
          ? wordData.phonetics!.first.text
          : null,
    );

    List<PartOfSpeech> partOfSpeechList = [];
    for (var meaning in wordData.meanings ?? []) {
      if (meaning.definitions != null && meaning.definitions!.isNotEmpty) {
        partOfSpeechList.add(PartOfSpeech(
          Name: meaning.partOfSpeech,
          Definition: meaning.definitions!.first.definition,
          Example: meaning.definitions!.first.example,
        ));
      }
    }

    wordDetails.Part = partOfSpeechList.isNotEmpty ? partOfSpeechList : null;

    return ResponseServices(statusCode: 200, data: wordDetails);
  } on FreeDictionaryException catch (e) {
    return ResponseServices(
      statusCode: 500,
      data: null,
    );
  } catch (e) {
    return ResponseServices(
      statusCode: 500,
      data: null,
    );
  }
}

}

class WordDetails
{
  String?  Word;
  String? Phonetics;
  List< PartOfSpeech>? Part;
  WordDetails({this.Word, this.Phonetics, this.Part});
}
class PartOfSpeech{
  String? Name;
  String? Definition;
  String? Example;
  PartOfSpeech({this.Name, this.Definition, this.Example});
}
