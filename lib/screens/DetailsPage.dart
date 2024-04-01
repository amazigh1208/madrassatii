import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../ContactPage.dart';
import '../cat/categorie.dart';
import '../provider/theme_provider.dart';
import '/article.dart';
import 'home.dart';

class DetailsPage extends StatelessWidget {
  final Article article;

  const DetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String articleUrl =
        "https://wa.me/+212628961998?text=مرحبا يسرنا التواصل معكم";
    String articleUrl1 =
        "https://web.facebook.com/profile.php?id=100085315370313&locale=fr_FR";

    return Directionality(
      textDirection:
          TextDirection.rtl, // Définir la direction de droite à gauche
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            article.titre,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Afficher l'image à l'aide du widget Image
                Image.network(
                  'https://www.okrichmoha.one/images/${article.lienPhoto}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  article.titre,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 16),

                // Utiliser le widget Html pour afficher le contenu HTML
                Html(
                  data: article.contenu,
                ),
                const SizedBox(height: 16),

                // Ajouter le bouton de partage
                MaterialButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  onPressed: () async {
                    await EasyLauncher.url(
                        url: articleUrl, mode: Mode.platformDefault);
                  },
                  child: Text('${article.titre}'),
                ),
              ],
            ),
          ),
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
                    number: "0628961998",
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
      ),
    );
  }
}
