import 'package:flutter/material.dart';
import 'package:testoblog/prive/mapage.dart';

class Prive extends StatefulWidget {
  const Prive({Key? key}) : super(key: key);

  @override
  State<Prive> createState() => _SportState();
}

class _SportState extends State<Prive> {
  final String correctPassword = 'password'; // Mot de passe correct

  // Contrôleur pour le champ de saisie du mot de passe
  final TextEditingController _passwordController = TextEditingController();

  // Méthode pour afficher la boîte de dialogue de connexion
  Future<void> _showLoginDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mot de passe requis'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Entrez le mot de passe',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Vérifier si le mot de passe entré est correct
                if (_passwordController.text == correctPassword) {
                  // Fermer la boîte de dialogue
                  Navigator.of(context).pop();
                  // Rediriger vers la page suivante
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mapage()),
                  );
                } else {
                  // Afficher un message d'erreur si le mot de passe est incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mot de passe incorrect'),
                    ),
                  );
                }
              },
              child: const Text('Connexion'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Sport'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Afficher la boîte de dialogue de connexion lorsque le bouton est pressé
            _showLoginDialog(context);
          },
          child: const Text('Accéder à la page'),
        ),
      ),
    );
  }
}
