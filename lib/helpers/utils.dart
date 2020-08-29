fixHtmlChars(String htmlCharText) {
  htmlCharText = htmlCharText
      .replaceAll("&amp;", "&")
      .replaceAll("&#039;", "'")
      .replaceAll("&quot;", "\"");

  return htmlCharText;
}

imageQuality(String imageUrl) {
  imageUrl = imageUrl.replaceAll("150x150", "500x500");

  return imageUrl;
}
