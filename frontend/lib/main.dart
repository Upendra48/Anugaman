import 'package:flutter/material.dart';
import 'package:frontend/core/api/dio_client.dart';
import 'package:frontend/core/storage/token_storage.dart';
import 'features/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize token from secure storage
  final savedToken = await TokenStorage.getToken();
  if (savedToken != null) {
    DioClient.setAuthToken(savedToken);
  }
  
  runApp(const AnugamanApp());
}

class AnugamanApp extends StatelessWidget {
  const AnugamanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anugaman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const LoginScreen(),
    );
  }
}