import 'dart:io';

void main() async {
  var outputPath = Directory.current.path + '/output';
  var env = Platform.environment;

  var targets = <String>[];
  var children = Directory(outputPath).listSync();
  for (var child in children) {
    targets.add(child.path.replaceFirst('//output/', ''));
  }

  Directory.current = outputPath;

  //Set git user
  await Process.run('git', ['config', 'user.name', 'gh-action-vis']);
  await Process.run('git', ['config', 'user.email', 'gh-action-vis@users.noreply.github.com']);
  //Git set
  await Process.run('git', ['init', '--initial-branch', 'gh-pages']);
  //Add
  await Process.run('git', ['add', '--all']);
  //Commit
  await Process.run('git', ['commit', '-m', 'deploy']);
  //Branch
  await Process.run('git', ['checkout', 'gh-pages']);
  await Process.run('git', ['branch', '-d', 'master']);

  //Push
  var remoteRepo =
      'https://${env['GITHUB_ACTOR']}:${env['GITHUB_TOKEN']}@github.com/${env['GITHUB_REPOSITORY']}.git';
  await Process.run('git', ['push', '-f', remoteRepo, 'gh-pages']);
}
