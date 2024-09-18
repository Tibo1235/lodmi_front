class Annonce {
  final String dateDebut;
  final String dateFin;
  final String description;
  final String titre;
  final int gardeId;
  final bool isConseil;
  final int usersId;
  final String? pseudo; // Ajoutez ces propriétés si elles sont nécessaires
  final String? proprietaireVille;
  final String espece;

  Annonce({
    required this.dateDebut,
    required this.dateFin,
    required this.description,
    required this.titre,
    required this.gardeId,
    required this.isConseil,
    required this.usersId,
    this.pseudo,
    this.proprietaireVille,
    required this.espece,
  });

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      dateDebut: json['date_debut'],
      dateFin: json['date_fin'],
      description: json['description'],
      titre: json['titre'],
      gardeId: json['gardeId'],
      isConseil: json['isConseil'],
      usersId: json['usersId'],
      pseudo: json['pseudo'], // Assurez-vous que ces propriétés sont correctement définies
      proprietaireVille: json['proprietaireVille'],
      espece: json['espece'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_debut': dateDebut,
      'date_fin': dateFin,
      'description': description,
      'titre': titre,
      'gardeId': gardeId,
      'isConseil': isConseil,
      'usersId': usersId,
      'pseudo': pseudo,
      'proprietaireVille': proprietaireVille,
      'espece': espece,
    };
  }
}
