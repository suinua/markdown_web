import 'package:markdown/markdown.dart';
import 'package:tuple/tuple.dart';

import '../model/article_index.dart';
import 'card_service.dart';

class MarkdownService {
  static Future<Tuple2<String,List<ArticleIndex>>> convertToHtml(String markdown) async {
    var html = await markdownToHtml(markdown,
        inlineSyntaxes: [InlineHtmlSyntax()],
        blockSyntaxes: [const TableSyntax(), const EmbedUrlSyntax(), const RawUrlSyntax(), const HeaderWithIdSyntax()]);

    //index
    var indexList = <ArticleIndex>[];
    RegExp(r'<h(.*)</h[1-6]>').allMatches(html).forEach((match) {
      var matchText = match[0]!;
      var level = int.parse(matchText.replaceAll(RegExp(' (.*)'), '').replaceAll('<h', ''));
      var text = matchText.replaceAll(RegExp('(.*)">'), '').replaceAll(RegExp('</(.*)'), '');
      var id = matchText.replaceFirst(RegExp('(.*)id="'), '').replaceAll(RegExp('">(.*)'), '');
      indexList.add(ArticleIndex(IndexLevel.fromInt(level), text, id));
    });

    return Tuple2(html, indexList);
  }
}

class EmbedUrlSyntax extends BlockSyntax {
  const EmbedUrlSyntax();

  @override
  Future<Node?> parse(BlockParser parser) async {
    var match = pattern.firstMatch(parser.current)!;
    parser.advance();

    var url = match[1]!.trim();
    var html = await CardService.generateCardHtml(url);
    return UnparsedContent(html);
  }

  @override
  RegExp get pattern => RegExp(r'embed:(.*)$');
}

class RawUrlSyntax extends BlockSyntax {
  const RawUrlSyntax();

  @override
  Future<Node?> parse(BlockParser parser) async {
    var match = pattern.firstMatch(parser.current)!;
    parser.advance();

    var url = match[0]!;
    if(url.startsWith('embed:')) return null;

    return UnparsedContent('<a href="$url">$url</a>');
  }

  @override
  RegExp get pattern => RegExp(r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?( |)');
}


