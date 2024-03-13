import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:flutter/foundation.dart';

class AppWriteClient extends ChangeNotifier {
  final Client _client = Client();
  late final Account _account;

  // Getters
  Client get client => _client;
  Account get account => _account;

  // Constructor
  AppWriteClient() {
    _client
        .setEndpoint(AppWriteConstants.endpoint) // Your API Endpoint
        .setProject(AppWriteConstants.projectId) // Your project ID
        .setSelfSigned(status: true); // For self signed certificates, only use for development
    _account = Account(_client);
  }

}