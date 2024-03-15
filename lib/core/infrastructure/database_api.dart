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

  Future<Capybara?> getMonster({
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

      if(document == null || document.documents.isEmpty) return null;

      final capybaraInfo = document.documents.first.data;

      Utils.logDebug(message: CapyColor.values.byName(capybaraInfo['color']));

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

    } on AppwriteException catch(e) {
      Utils.logError(message: e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> createMonster({
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
            'color': capybara.color.name,
            'birthDate': capybara.birthDate.toIso8601String(),
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life,
            'alive': capybara.alive,
            'userId': userId
          }
      );
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
      if(isHavingMonster != null && isHavingMonster?.documentId != '') {
        await _databases.updateDocument(
            databaseId: AppWriteConstants.databaseId,
            collectionId: AppWriteConstants.collectionId,
            documentId: isHavingMonster.documentId,
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
        await createMonster(capybara: capybara, userId: userId);
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