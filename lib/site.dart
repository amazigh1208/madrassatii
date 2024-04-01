import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testoblog/provider/theme_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'ContactPage.dart';
import 'cat/categorie.dart';
import 'screens/home.dart';
import 'dart:ui';

class MapageVideo extends StatefulWidget {
  const MapageVideo({super.key});

  @override
  State<MapageVideo> createState() => _MapageVideoState();
}

class _MapageVideoState extends State<MapageVideo> {
  int _currentIndex = 0;
  String articleUrl =
      "https://wa.me/+212628961998?text=مرحبا يسرنا التواصل معكم";
  String articleUrl1 =
      "https://web.facebook.com/profile.php?id=100085315370313&locale=fr_FR";
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.okrichmoha.one/videomadrassa.php'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "مجموعة مدارس بني عمارت",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          // Utilisez le widget Consumer pour écouter les changements de thème
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: () {
                  // Appel de la méthode changeTheme de ThemeProvider
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme();
                },
                // Afficher l'icône en fonction du thème actuel
                icon: Icon(themeProvider.theme == ThemeData.dark()
                    ? Icons.light_mode
                    : Icons.dark_mode),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            // Naviguer vers la page d'affichage des données
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
          if (index == 0) {
            // Naviguer vers la page d'affichage des données
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          }
          if (index == 2) {
            // Naviguer vers la page d'affichage des données
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Categorie()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'اتصال',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'تصنيفات',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan[700],
              ),
              child: const Center(
                child: Text(
                  'القائمة الرئيسية',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('الانشطة المدرسية '),
              onTap: () {
                Navigator.pop(context);
                // Add logic to navigate to the home page here
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('تصنيفات'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Categorie()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'images/whatsapp.png',
                width: 30,
              ),
              title: const Text(' واتس اب'),
              onTap: () async {
                await EasyLauncher.url(
                    url: articleUrl, mode: Mode.platformDefault);
              },
            ),
            ListTile(
              leading: Image.asset(
                'images/facebook.png',
                width: 30,
              ),
              title: const Text('صفحتنا على الفايسبوك '),
              onTap: () async {
                await EasyLauncher.url(
                    url: articleUrl1, mode: Mode.platformDefault);
              },
            ),
            ListTile(
              leading: Image.asset(
                'images/telephone.png',
                width: 30,
              ),
              title: const Text('الهاتف'),
              onTap: () async {
                await EasyLauncher.call(
                  number: "555",
                );
              },
            ),
            const Center(
              child: Text(
                "مجموعة مدارس بني عمارت",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 24,
                ),
              ),
            ),
            Image.asset('images/ecole.jpg'),
          ],
        ),
      ),
    );
  }
}
