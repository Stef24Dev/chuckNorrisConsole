import "package:http/http.dart" as http;
import "dart:convert";
import 'models/joke.dart';
import 'dart:io';
import 'package:dotenv/dotenv.dart';

const stringUrlJoke = "https://api.chucknorris.io/jokes/random";
const stringUrlWithCat = 'https://api.chucknorris.io/jokes/random?category=';
const stringUrlCat = 'https://api.chucknorris.io/jokes/categories';
const stringUrlQuery = 'https://api.chucknorris.io/jokes/search?query=';

Future<Joke> getRandomJokeAsync(String category) async {
  String stringUrl;
  if(category == "")
  {
    stringUrl = stringUrlJoke;
  }
  else
  {
    stringUrl = stringUrlWithCat + category;
  }

  final url = Uri.parse(stringUrl);
  final res = await http.get(url);

  return Joke.FromJson(json.decode(res.body));
}

Future<List<Joke>> getJokesQueryAsync(String word) async{
  final uriQuery = Uri.parse(stringUrlQuery);
  final uriApiQuery = uriQuery.replace(queryParameters: {'query': word});

  final res = await http.get(uriApiQuery);
  final data = json.decode(res.body);
  final list = data['result'] as List;

  final cfs = list.map((e) => Joke.FromMap(e as Map<String, dynamic>)).toList();

  return cfs;
}

Future<Joke> manageChoicesAsync (int choiceNum) async {
  final Joke joke;
  final List<Joke> jokes;
  
  switch (choiceNum) {
    case 1:
        joke = await getRandomJokeAsync('');
      break;
    case 2:
        joke = await getRandomJokeAsync(selectCat());
      break;
    case 3:
        final envFile = await readEnvFileAsync();
        joke = await getRandomJokeAsync(envFile['category']!);
      break;
    case 4:
        print('\nNow choose one word to search, the first quote will be printed, if you want all the quotes, there is a file in /quotes/quotes.txt');
        final word = stdin.readLineSync();
        jokes = await getJokesQueryAsync(word!);
        await File('D:/sdks/chucknorris/chuck_norris/lib/quotes/quotes.txt').writeAsString(jokes.toString());
        joke = jokes[0];
      break;
    default:
        joke = await getRandomJokeAsync('');
      break;
  }
  return joke;
}

String selectCat() {
  print('Select the category you prefer by writing it under the categories:\n');
  final String category = stdin.readLineSync() ?? "";
  return category;
}

Future<DotEnv> readEnvFileAsync() async{
  var env = await DotEnv()..load(const ['.env']);
  return env;
}