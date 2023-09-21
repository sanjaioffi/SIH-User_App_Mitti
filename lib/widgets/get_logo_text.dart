String getLogoText(String text) {
  List<String> words = text.split(' ');
  String logoText = '';

  for (String word in words) {
    if (word.isNotEmpty) {
      logoText += word[0].toUpperCase();
    }
  }
  if (logoText.length > 3) {
    return logoText.substring(0, 3).toUpperCase();
  }
  return logoText.toUpperCase();
}
