import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:flutter/cupertino.dart';

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

    } on AppwriteException catch(e) {
      print(e);
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
            'birthdate': capybara.birthDate,
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life,
            'userId': userId
          }
      );
    } on AppwriteException catch(e) {
      print(e);
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
          documentId: '',
          data: {
            'name': capybara.name,
            'color': capybara.color,
            'birthdate': capybara.birthDate,
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life,
            'userId': userId
          }
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }

  deleteMonster({
    required Capybara capybara,
    required String userId
  }) async {
    try {
      await _databases.deleteDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: ''
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }
}