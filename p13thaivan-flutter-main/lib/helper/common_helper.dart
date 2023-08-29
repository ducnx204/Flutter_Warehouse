import 'package:html_unescape/html_unescape.dart';

class CommonHelper {
  ///
  ///  A Dart library for unescaping HTML-encoded strings.
  ///
  String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }
}
