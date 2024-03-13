import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';

class DatabaseAPI {
  late Databases databases;

  // Constructor
  DatabaseAPI({
    required Client client
  }) {
    databases = Databases(client);
  }

  getMonster({
    required String userId
  }) async {
    try {
      databases.listDocuments(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }

  createMonster({
    required Capybara capybara
  }) async {
    try {
      databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: ID.unique(),
          data: {
            'name': capybara.name,
            'color': capybara.color,
            'birthdate': capybara.birthDate,
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life
          }
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }

  updateMonster({
    required Capybara capybara
  }) async {
    try {
      databases.updateDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: '',
          data: {
            'name': capybara.name,
            'color': capybara.color,
            'birthdate': capybara.birthDate,
            'hunger': capybara.hunger,
            'happiness': capybara.happiness,
            'life': capybara.life
          }
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }

  deleteMonster({
    required Capybara capybara
  }) async {
    try {
      databases.deleteDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: ''
      );
    } on AppwriteException catch(e) {
      print(e);
    }
  }
}