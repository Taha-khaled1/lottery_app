String subString(String text, int number) {
  String finalText = text;
  if (text.length > number) {
    finalText = text.substring(0, number - 1) + '...';
  }
  return finalText;
}
