import 'package:chuck_norris/chuck_norris.dart' as chuck_norris;
import 'dart:io';

//To compile: dart compile exe bin/chuck_norris.dart

void main(List<String> arguments) async {
  while (true) {
    final choiceNum = menu();
    if (choiceNum == 0) {
      break;
    }
    final string = await chuck_norris.manageChoicesAsync(choiceNum);
    print(string);
  }

  stdin.readLineSync();
}

int menu() {
  print('\nHello!\nSelect what you want to do:');
  print('1) Random quote\n2) Choose a category\n3) Choose a category using a env file\n4) Filter all the quotes using one word\n\n0) Exit\n');

  final String choice = stdin.readLineSync() ?? '1';
  return int.parse(choice);
}