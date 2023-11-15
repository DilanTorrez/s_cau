class Socio {
  int? id;
  String name;
  int identify_card;
  int phone;

  Socio(
      {this.id,
      required this.name,
      required this.identify_card,
      required this.phone});

  factory Socio.fromJson(Map<String, dynamic> json) {
    return Socio(
      id: json['id'],
      name: json['name'],
      identify_card: json['identify_card'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'identify_card': identify_card,
      'phone': phone,
    };
  }
}
