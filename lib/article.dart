// model/article.dart
class Article {
  final String id;
  final String nom;
  final String prenom;
  final String titre;
  final String contenu;
  final String lienPhoto;
  final String cat;

  Article({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.titre,
    required this.contenu,
    required this.lienPhoto,
    required this.cat,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      titre: json['titre'],
      contenu: json['contenu'],
      lienPhoto: json['lien_photo'],
      cat: json['cat'],
    );
  }
}
