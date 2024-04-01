import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import '../provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Cat {
  final String id;
  final String cat;
  final String lien_photo;
  final String lien; // Champ pour le lien de chaque carte
  final IconData iconData;

  Cat({
    required this.id,
    required this.cat,
    required this.lien_photo,
    required this.lien,
    required this.iconData,
  });

  String getImageUrl() {
    return 'https://www.okrichmoha.one/images/cat/$lien_photo';
  }
}

class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  Map<String, IconData> iconDataMap = {
    'sports': Icons.sports,
    'ecole': Icons.book_rounded,
    // Ajoutez ici d'autres associations de noms d'icônes à IconDatas
  };

  List<Cat> categories = [
    Cat(
      id: '1',
      cat: 'انشطة رياضية',
      lien_photo: 'photo1.jpg',
      lien: 'homesport.dart',
      iconData: Icons.sports,
    ),
    Cat(
      id: '2',
      cat: 'انشطة ثقافية ',
      lien_photo: 'photo2.jpg',
      lien: 'homesport.dart',
      iconData:
          Icons.school_rounded, // Remplacez "category" par l'icône appropriée
    ),
    Cat(
      id: '2',
      cat: 'انفتاح المؤسسة على محيطها',
      lien_photo: 'photo2.jpg',
      lien: 'homesport.dart',
      iconData: Icons
          .book_online_rounded, // Remplacez "category" par l'icône appropriée
    ),
    Cat(
      id: '2',
      cat: 'فيديوهات',
      lien_photo: 'photo2.jpg',
      lien: 'site.dart',
      iconData: Icons
          .video_camera_back_rounded, // Remplacez "category" par l'icône appropriée
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تصنيفات'),
        backgroundColor: Colors.cyan[500],
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Action à exécuter lorsque l'utilisateur appuie sur la carte
                String lien = categories[index].lien;
                // Naviguer vers la page spécifique à la catégorie
                Navigator.pushNamed(context, lien);
              },
              child: CustomCard(
                height: 80,
                width: screenWidth,
                borderRadius: 10,
                hoverColor: Colors.indigo,
                elevation: 6,
                childPadding: 10,
                color: Colors.blue,
                child: ListTile(
                  leading: Icon(categories[index].iconData),
                  title: Text(
                    categories[index].cat,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
