import 'package:markdown/markdown.dart';
import 'package:tuple/tuple.dart';

import '../model/article_index.dart';
import 'card_service.dart';

class MarkdownService {
  static Future<Tuple2<String,List<ArticleIndex>>> convertToHtml(String markdown) async {
    var html = await markdownToHtml(markdown,
        inlineSyntaxes: [InlineHtmlSyntax(), StrikethroughSyntax()],
        blockSyntaxes: [const TableSyntax(), const EmbedUrlSyntax(), const NoteSyntax(), const RawUrlSyntax(), const HeaderWithIdSyntax()]);

    //index
    var indexList = <ArticleIndex>[];
    RegExp(r'<h(.*)</h[1-6]>').allMatches(html).forEach((match) {
      var matchText = match[0]!;
      var level = int.parse(matchText.replaceAll(RegExp(' (.*)'), '').replaceAll('<h', ''));
      if (level <= 2) {
        var text = matchText.replaceAll(RegExp('(.*)">'), '').replaceAll(RegExp('</(.*)'), '');
        var id = matchText.replaceFirst(RegExp('(.*)id="'), '').replaceAll(RegExp('">(.*)'), '');
        indexList.add(ArticleIndex(IndexLevel.fromInt(level), text, id));
      }
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

class NoteSyntax extends BlockSyntax {
  const NoteSyntax();

  @override
  bool canParse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current);
    if (match == null) return false;
    final start = match[0];

    return match.groupCount == 2 && ([':::info',':::warn',':::alert',':::value',':::'].contains(start));
  }

  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    endBlock ??= '';

    var childLines = <String>[];
    parser.advance();

    while (!parser.isDone) {
      var match = pattern.firstMatch(parser.current);
      if (match?[0] != ':::') {
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }

    return childLines;
  }

  @override
  Future<Node?> parse(BlockParser parser) async {
    var match = pattern.firstMatch(parser.current)!;
    var type = match[0]!.replaceFirst(':::', '');
    if (type.isEmpty) type = 'info';

    var endBlock = match.group(1);

    var childLines = parseChildLines(parser, endBlock);

    childLines.add('');

    var text = childLines.join('\n');
    var result = await MarkdownService.convertToHtml(text);
    var childrenHtml = result.item1;

    var icon = _iconsMap[type];

    var html = '''
<div class="note note-$type">
    <div class="note-icon-wrap">
        <span class="note-icon note-$type-icon" uk-icon="icon: $icon; ratio: 1.25"></span>
    </div>
    <div class="note-body">
        $childrenHtml
    </div>
</div>\n
''';

    return UnparsedContent(html);
  }

  static const _iconsMap = {
    'info' : 'check',
    'warn' : 'warning',
    'alert' : 'close',
    'value' : 'pencil'
  };

  @override
  RegExp get pattern => RegExp(r'^(:::)(info|warn|alert|value|)$');
}