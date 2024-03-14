import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:flutter/widgets.dart';

class DatabaseAPI extends ChangeNotifier{
  late Databases _databases;

  // Constructor
  DatabaseAPI({
    required Databases databases
  }) {
    _databases = databases;
  }

  Future<Capybara> getMonster({
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

      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.data['name']}');
      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.data['color']}');
      Utils.logDebug(message: 'getMonster name result: ${DateTime.parse(document.documents.first.data['birthDate'])}');
      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.data['hunger']}');
      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.data['happiness']}');
      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.data['life']}');
      Utils.logDebug(message: 'getMonster name result: ${document.documents.first.$id}');

      final capybaraInfo = document.documents.first.data;
      return Capybara(
          name: capybaraInfo['name'],
          color: capybaraInfo['color'],
          birthDate: DateTime.parse(capybaraInfo['birthDate']),
          hunger: capybaraInfo['hunger'],
          happiness: capybaraInfo['happiness'],
          life: capybaraInfo['life'],
          documentId: document.documents.first.$id
      );

    } on AppwriteException catch(e) {
      Utils.logError(message: e);
      return Capybara(name: 'Roger', color: CapyColor.brown, documentId: '');
    } finally {
      notifyListeners();
    }
  }

  createMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      final isHavingMonster = await getMonster(userId: userId);
      if(isHavingMonster.documentId == '') {
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
      } else {
        Utils.logDebug(message: "User have already a capybara");
      }
    } on AppwriteException catch(e) {
      Utils.logError(message: e);
    } finally {
      notifyListeners();
    }
  }

  updateMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      final isHavingMonster = await getMonster(userId: userId);
      if(isHavingMonster.documentId == '') {
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
      }
    } on AppwriteException catch(e) {
      Utils.logError(message: e);
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
      Utils.logError(message: e);
    } finally {
      notifyListeners();
    }
  }
}