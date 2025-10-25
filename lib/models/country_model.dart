class Country {
  final String name;
  final String capital;

  Country({required this.name, required this.capital});

  factory Country.fromJson(Map<String, dynamic> json) {
    // La API de países devuelve una lista de capitales, tomamos la primera.
    // Si no hay capital, usamos 'N/A'.
    final capitalList = json['capital'] as List<dynamic>?;
    final capital = (capitalList != null && capitalList.isNotEmpty)
        ? capitalList[0] as String
        : 'N/A';

    return Country(name: json['name']['common'] as String, capital: capital);
  }
}
