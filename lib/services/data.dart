class CitiesService {
  static final List<String> cities =
      List.generate(TunisiaRegions.length, (index) {
    Future.delayed(Duration(seconds: 1));
    return TunisiaRegions[index];
  });
  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.contains(queryLower);
      }).toList();
}

// ignore: non_constant_identifier_names
List TunisiaRegions = [
  "Ariana",
  "Béja",
  "Ben Arous",
  "Bizerte",
  "Gabès",
  "Gafsa",
  "Jendouba",
  "Kairouan",
  "Kasserine",
  "Kebili",
  "Kef",
  "Mahdia",
  "Manouba",
  "Medenine",
  "Monastir",
  "Nabeul",
  "Sfax",
  "Sidi Bouzid",
  "Siliana",
  "Sousse",
  "Tataouine",
  "Tozeur",
  "Tunis",
  "Zaghouan"
];
