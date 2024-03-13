import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/shared/constants/appwrite.dart';

class AppWriteClient {
  Client client = Client();

  // Constructor
  AppWriteClient() {
    client
        .setEndpoint(AppWriteConstants.endpoint) // Your API Endpoint
        .setProject(AppWriteConstants.projectId) // Your project ID
        .setSelfSigned(status: true); // For self signed certificates, only use for development
  }
}