import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_connect/user_screen.dart';

Future<void> main() async {
  // Ensure that all binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(home: UserScreen(userId: "G5mjh7n0pk")));
}
