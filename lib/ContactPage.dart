import 'dart:io';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:testoblog/cat/categorie.dart';
import 'package:testoblog/provider/theme_provider.dart';
import 'package:testoblog/screens/home.dart';

void main() {
  runApp(ContactPage());
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String articleUrl = "https://wa.me/+212628961998";
  String articleUrl1 =
      "https://web.facebook.com/profile.php?id=100085315370313&locale=fr_FR";
  String _messageStatus = '';
  File? _selectedFile;
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.rtl, // Définir la direction de droite à gauche
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Center(
            child: Text(
              'تواصل معنا',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Appel de la méthode changeTheme de ThemeProvider
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              icon: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  // Afficher l'icône en fonction du thème actuel
                  return Icon(themeProvider.theme == ThemeData.dark()
                      ? Icons.light_mode
                      : Icons.dark_mode);
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'الاسم العائلي'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'الاسم الشخصي'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    const InputDecoration(labelText: 'البريد الالكتروني'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'الرسالة'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _pickFile();
                },
                child: const Text('اختر صورة'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Vérifier que les champs obligatoires ne sont pas vides
                  if (_nomController.text.isEmpty ||
                      _prenomController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _messageController.text.isEmpty) {
                    setState(() {
                      _messageStatus = 'جميع الحقول مطلوبة';
                    });
                    return;
                  }

                  // Vérifier le format de l'email
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(_emailController.text)) {
                    setState(() {
                      _messageStatus = 'بريد الكتروني خاطئ';
                    });
                    return;
                  }

                  // Récupérer les données saisies
                  String nom = _nomController.text;
                  String prenom = _prenomController.text;
                  String email = _emailController.text;
                  String message = _messageController.text;

                  // Configurer les informations du serveur SMTP (exemple avec Gmail)
                  final smtpServer =
                      gmail('okrichm44@gmail.com', 'yiei nldh jqpc vrkd');

                  // Créer le message
                  final messageToSend = Message()
                    ..from = const Address('your.email@gmail.com', 'Votre Nom')
                    ..recipients.add(
                        'okrichmoha561@gmail.com') // Adresse e-mail du destinataire
                    ..subject = 'رسالة جديدة'
                    ..text =
                        'Nom: $nom\nPrénom: $prenom\nEmail: $email\n\n$message';

                  // Attacher le fichier sélectionné
                  if (_selectedFile != null) {
                    messageToSend.attachments
                        .add(FileAttachment(_selectedFile!));
                  }

                  // Envoyer le message
                  try {
                    final sendReport = await send(messageToSend, smtpServer);
                    setState(() {
                      _messageStatus = 'تم ارسال الرسالة بنجاح';
                    });
                    print('Message envoyé: ${sendReport.toString()}');
                  } catch (e) {
                    setState(() {
                      _messageStatus = 'Erreur lors de l\'envoi du message: $e';
                    });
                    print(_messageStatus);
                  }
                },
                child: const Text('ارسل'),
              ),
              const SizedBox(height: 16.0),
              Text(
                _messageStatus,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            if (_currentIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              label: 'تواصل',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'انشطة مدرسية',
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

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }
}
