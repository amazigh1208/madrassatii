import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:testoblog/ContactPage.dart';
import 'package:testoblog/cat/categorie.dart';
import 'package:testoblog/screens/DetailsPage.dart';

import '/feedsport.dart';
import '/article.dart';

import 'home.dart';

class Sport extends StatefulWidget {
  const Sport({super.key});

  @override
  State<Sport> createState() => _SportState();
}

class _SportState extends State<Sport> {
  List<Article> articles = [];
  bool _loading = true;
  int _currentIndex = 1;
  String articleUrl =
      "https://wa.me/+212628961998?text=مرحبا يسرنا التواصل معكم";
  String articleUrl1 =
      "https://web.facebook.com/profile.php?id=100085315370313&locale=fr_FR";

  @override
  void initState() {
    super.initState();
    getFeed();
  }

  Future<void> getFeed() async {
    Feed feed = Feed();
    await feed.getFeed();

    setState(() {
      articles = feed.feed.take(10).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: const Text(
            "أنشطة مدرسية",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200.0,
                      width: screenWidth,
                      child: AnotherCarousel(
                        boxFit: BoxFit.cover,
                        autoplay: false,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: const Duration(milliseconds: 1000),
                        dotSize: 6.0,
                        dotIncreasedColor: const Color(0xFFFF335C),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: articles
                            .take(4)
                            .map(
                              (article) => NetworkImage(
                                'https://www.okrichmoha.one/images/${article.lienPhoto}',
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Announcement(
                          articles:
                              articles, // Pass the articles list to the Announcement widget
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.cyan[600],
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
                MaterialPageRoute(builder: (context) => const HomePage()),
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
              label: 'عن المدرسة',
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

class Announcement extends StatelessWidget {
  final List<Article> articles; // Declare the articles list
  final int index; // Declare the index

  const Announcement({
    Key? key,
    required this.articles,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://www.okrichmoha.one/images/${articles[index].lienPhoto}";
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(article: articles[index]),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: screenWidth,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Text('Error loading image T-T',
                          style: Theme.of(context).textTheme.titleLarge);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      articles[index].titre,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            //   Text(
            //   articles[index].prenom,
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
          ],
        ),
      ),
    );
  }
}
