import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../custom_logger.dart';

class CardService {
  static Future<String> generateCardHtml(String url) async {
    try {
      var title = await _getTitle(url);
      var description = await _getDescription(url);
      var thumbnail = await _getImageUrl(url);
      var favIcon = await _getFavicon(url);

      return '''
<a href="$url" class="uk-link-reset">
  <div class="card">
        <div class="card-body">
                <div class="title">$title</div>
                <div class="context">$description</div>
        </div>
        <img class="thumbnail"
             src="$thumbnail"
             alt="thumbnail">
        <div class="site-detail">
            <img class="favicon"
                 src="$favIcon"
                 alt="">
            <div class="host">${Uri.parse(url).host}</div>
        </div>
  </div>
</a>
  ''';
    } catch (e) {
      CustomLogger.normal.e('generateCardHtml, url is $url');
      return '<a href="$url">$url</a>';
    }
  }

  static Future<String> _getImageUrl(String url) async {
    var imageUrl = '';
    var response = await http.get(Uri.parse(url));
    url = response.url ?? url;

    if (response.statusCode != 200) {
      if (Uri.parse(url).origin == url) return '';
      return _getImageUrl(_getNextUrl(url));
    }

    var html = parse(response.body);
    await Future.forEach<Element>(html.getElementsByTagName('meta'),
        (element) async {
      if (element.attributes.keys.contains('property')) {
        var property = element.attributes['property']!;
        if (property.contains(RegExp(r'(og:image|image)'))) {
          if (!property.contains(RegExp(r'(width|height)'))) {
            imageUrl = element.attributes['content'] ?? '';
          }
        }
      }
    });

    if (imageUrl.contains(RegExp('banner|background'))) {
      imageUrl = '';
    }

    if (imageUrl.isNotEmpty) {
      return imageUrl;
    } else {
      if (Uri.parse(url).origin == url) {
        return imageUrl;
      } else {
        return _getImageUrl(_getNextUrl(url));
      }
    }
  }

  static Future<String> _getDescription(String url) async {
    var description = '';

    var response = await http.get(Uri.parse(url));
    url = response.url ?? url;

    if (response.statusCode != 200) {
      if (Uri.parse(url).origin == url) return '';
      return _getDescription(_getNextUrl(url));
    }

    var html = parse(response.body);
    await Future.forEach<Element>(html.getElementsByTagName('meta'),
        (element) async {
      if (element.attributes.keys.contains('property')) {
        var property = element.attributes['property']!;
        if (property.contains(RegExp(r'(og:description|description)'))) {
          description = element.attributes['content'] ?? '';
        }
      }
    });

    if (description.isNotEmpty) {
      return description;
    } else {
      if (Uri.parse(url).origin == url) {
        return description;
      } else {
        return _getDescription(_getNextUrl(url));
      }
    }
  }

  static Future<String> _getTitle(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return url;

    var elements = parse(response.body).getElementsByTagName('title');
    if (elements.isEmpty) return '';

    print('getitle');
    return elements[0].text;
  }

  static Future<String> _getFavicon(String url) async {
    var response = await http.get(Uri.parse(url));
    var html = parse(response.body);
    var elements = html.getElementsByTagName('link');
    for (var i=0; i < elements.length; i++) {
      var element = elements[i];
      var rel = element.attributes['rel'];
      if (rel == 'shortcut icon') {
        print('_getFavicon');
        return element.attributes['href'] ?? '';
      }
    }

    print('_getFavicon');
    return '';
  }

  static String _getNextUrl(String url) {
    if (url.split('').last == '/') {
      url = url.substring(0, url.length-1);
    }

    return url.replaceFirst(RegExp(r'/(?!.*/).*$'), '');
  }
}
