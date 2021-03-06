import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../custom_logger.dart';

class CardService {
  static Future<String> generateCardHtml(String url) async {
    try {
      var title = await _getTitle(url);
      CustomLogger.simple.i('generate embed:$title');
      var description = await _getDescription(url);
      var thumbnail = await _getImageUrl(url);
      var favIcon = await _getFavicon(url);

      var thumbnailHtml = thumbnail.isEmpty
          ? ''
          : '''<img class="thumbnail" src="$thumbnail" alt="thumbnail">''';

      return '''
<a href="$url" class="uk-link-reset">
  <div class="card">
        <div class="card-body">
                <div class="title">$title</div>
                <div class="context">$description</div>
        </div>
        $thumbnailHtml
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
      CustomLogger.normal.e('generateCardHtml, url is $url\n$e');
      return '<a href="$url">$url</a>';
    }
  }

  static Future<String> _getImageUrl(String url, {String? preUrl}) async {
    var imageUrl = '';
    var response = await http.get(Uri.parse(url));
    url = response.url ?? url;

    //無限リダイレクト防止
    if (url == preUrl) return '';

    if (response.statusCode != 200) {
      if (_isLastPage(url)) return '';
      return await _getImageUrl(_getNextUrl(url), preUrl:url);
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
      if (_isLastPage(url)) {
        return imageUrl;
      } else {
        return await _getImageUrl(_getNextUrl(url), preUrl:url);
      }
    }
  }

  static Future<String> _getDescription(String url, {String? preUrl}) async {
    var description = '';

    var response = await http.get(Uri.parse(url));
    url = response.url ?? url;

    //無限リダイレクト防止
    if (url == preUrl) return '';

    if (response.statusCode != 200) {
      if (_isLastPage(url)) return '';
      return await _getDescription(_getNextUrl(url), preUrl:url);
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
      if (_isLastPage(url)) {
        return description;
      } else {
        return await _getDescription(_getNextUrl(url), preUrl:url);
      }
    }
  }

  static Future<String> _getTitle(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return url;

    var elements = parse(response.body).getElementsByTagName('title');
    if (elements.isEmpty) return '';

    return elements[0].text;
  }

  static Future<String> _getFavicon(String url) async {
    var response = await http.get(Uri.parse(url));
    var html = parse(response.body);
    var elements = html.getElementsByTagName('link');
    for (var i = 0; i < elements.length; i++) {
      var element = elements[i];
      var rel = element.attributes['rel'];
      if (rel == 'shortcut icon') {
        return element.attributes['href'] ?? '';
      }
    }

    return '';
  }

  static bool _isLastPage(String url) {
    return ['', '/'].contains(Uri.parse(url).path);
  }

  static String _getNextUrl(String url) {
    if (url.split('').last == '/') {
      url = url.substring(0, url.length - 1);
    }

    return url.replaceFirst(RegExp(r'/(?!.*/).*$'), '');
  }
}
