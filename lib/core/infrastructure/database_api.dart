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

      final capybaraInfo = document.documents.first.data;

      if(capybaraInfo['alive'] == true) {
        Utils.logDebug(message: 'getMonster name result: ${capybaraInfo['name']}');
        Utils.logDebug(message: 'getMonster color result: ${capybaraInfo['color']}');
        Utils.logDebug(message: 'getMonster birthDate result: ${DateTime.parse(capybaraInfo['birthDate'])}');
        Utils.logDebug(message: 'getMonster hunger result: ${capybaraInfo['hunger']}');
        Utils.logDebug(message: 'getMonster happiness result: ${capybaraInfo['happiness']}');
        Utils.logDebug(message: 'getMonster life result: ${capybaraInfo['life']}');
        Utils.logDebug(message: 'getMonster alive result: ${capybaraInfo['alive']}');
        Utils.logDebug(message: 'getMonster userId result: ${document.documents.first.$id}');

        return Capybara(
            name: capybaraInfo['name'],
            color: CapyColor.values.byName(capybaraInfo['color']),
            birthDate: DateTime.parse(capybaraInfo['birthDate']),
            hunger: capybaraInfo['hunger'],
            happiness: capybaraInfo['happiness'],
            life: capybaraInfo['life'],
            alive: capybaraInfo['alive'],
            documentId: document.documents.first.$id
        );
      } else {
        deleteMonster(capybara: Capybara(name: capybaraInfo['name'], color: CapyColor.values.byName(capybaraInfo['color']), documentId: document.documents.first.$id));
        return createMonster(capybara: Capybara(name: 'Roger', color: CapyColor.brown, documentId: ID.unique()), userId: userId);
      }
    } on AppwriteException catch(e) {
      Utils.logError(message: e);
      return createMonster(capybara: Capybara(name: 'Roger', color: CapyColor.brown, documentId: ''), userId: userId);
    } finally {
      notifyListeners();
    }
  }

  Future<Capybara> createMonster({
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
              'color': capybara.color.name,
              'birthDate': capybara.birthDate.toIso8601String(),
              'hunger': capybara.hunger,
              'happiness': capybara.happiness,
              'life': capybara.life,
              'alive': capybara.alive,
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
    return capybara;
  }

  updateMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      final isHavingMonster = await getMonster(userId: userId);
      if(isHavingMonster.documentId != '') {
        await _databases.updateDocument(
            databaseId: AppWriteConstants.databaseId,
            collectionId: AppWriteConstants.collectionId,
            documentId: capybara.documentId,
            data: {
              'name': capybara.name,
              'color': capybara.color.name,
              'birthDate': capybara.birthDate.toIso8601String(),
              'hunger': capybara.hunger,
              'happiness': capybara.happiness,
              'life': capybara.life,
              'alive': capybara.alive,
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