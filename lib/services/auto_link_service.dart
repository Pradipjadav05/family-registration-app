class AutoLinkService {
  static Map<String, String> samajTempleMap = {
    'Gujarati': 'Swaminarayan Temple',
    'Marathi': 'Vitthal Mandir',
    'Rajasthani': 'Ram Mandir',
  };

  static String getTempleForSamaj(String samaj) {
    return samajTempleMap[samaj] ?? 'Default Temple';
  }
}