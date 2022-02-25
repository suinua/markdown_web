class Committer {
  final String name;
  final String url;
  final String avatarUrl;

  Committer(this.name, this.url, this.avatarUrl);

  Committer.fromJson(Map json)
      : name = json['login'],
        url = json['html_url'],
        avatarUrl = json['avatar_url'];

  @override
  bool operator ==(Object other) {
    if (other is Committer) {
      return other.name == name;
    }
    return false;
  }

  static const String ICON_CLASS_NAME = 'committer-icon';
}