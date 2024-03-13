import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:flutter/widgets.dart';

class DatabaseAPI extends ChangeNotifier{
  late Databases _databases;

  // Constructor
  DatabaseAPI({
    required Databases databases
  }) {
    _databases = databases;
  }

  getMonster({
    required String userId
  }) async {
    try {
      final document = await _databases.listDocuments(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          queries: [
            Query.equal('userId', userId)
          ]
      );

      print('getMonster name result: ${document.documents.first.data['name']}');
      print('getMonster name result: ${document.documents.first.data['color']}');
      print('getMonster name result: ${DateTime.parse(document.documents.first.data['birthDate'])}');
      print('getMonster name result: ${document.documents.first.data['hunger']}');
      print('getMonster name result: ${document.documents.first.data['happiness']}');
      print('getMonster name result: ${document.documents.first.data['life']}');
      print('getMonster name result: ${document.documents.first.$id}');

      final capybaraInfo = document.documents.first.data;
      Capybara(
        name: capybaraInfo['name'],
        color: capybaraInfo['color'],
        birthDate: DateTime.parse(capybaraInfo['birthDate']),
        hunger: capybaraInfo['hunger'],
        happiness: capybaraInfo['happiness'],
        life: capybaraInfo['life'],
        documentId: document.documents.first.$id
      );

    } on AppwriteException catch(e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  createMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      await _databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: ID.unique(),
          data: {
            'name': capybara.name,
            'color': capybara.color,
            'birthDate': capybara.birthDate.toIso8601String(),
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life,
            'userId': userId
          }
      );
    } on AppwriteException catch(e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  updateMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      await _databases.updateDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: capybara.documentId,
          data: {
            'name': capybara.name,
            'color': capybara.color,
            'birthDate': capybara.birthDate.toIso8601String(),
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life,
            'userId': userId
          }
      );
    } on AppwriteException catch(e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  deleteMonster({
    required Capybara capybara
  }) async {
    try {
      await _databases.deleteDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: capybara.documentId
      );
    } on AppwriteException catch(e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}