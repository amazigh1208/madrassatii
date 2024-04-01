import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testoblog/prive/priver.dart';
import 'package:testoblog/provider/theme_provider.dart';
import 'package:testoblog/screens/homesport.dart';
import 'package:testoblog/site.dart';
import '/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Your App Name',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          routes: {
            'homesport.dart': (context) => const Sport(),
            'priver.dart': (context) => const Prive(),
            'site.dart': (context) => const MapageVideo(),
            // Ajoutez d'autres routes ici selon vos besoins
          },
          home: const HomePage(),
        );
      },
    );
  }
}
