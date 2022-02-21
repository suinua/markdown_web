import 'dart:io';

void main() async {
  var outputPath = Directory.current.path + '/output';
  var env = Platform.environment;

  var targets = <String>[];
  var children = Directory(outputPath).listSync();
  for (var child in children) {
    targets.add(child.path.replaceFirst('//output/', ''));
  }

  Directory.current = '${env['GITHUB_WORKSPACE']}/';

  //Set git user
  await Process.run('git', ['config', 'user.name', 'gh-action-vis']);
  await Process.run('git',
      ['config', 'user.email', 'gh-action-vis@users.noreply.github.com']);

  //Branch
  await Process.run('git', ['checkout', '--orphan', 'gh-pages']);
  await Process.run('git', ['rm', ' --cachedn', '-r', '.']);

  //Add
  for (var element in targets) {
    print('git add $element');
    await Process.run('git', ['add', element]);
  }

  //Commit
  await Process.run('git', ['commit', '-m', 'deploy']);

  //Push
  var remoteRepo =
      'https://${env['GITHUB_ACTOR']}:${env['GITHUB_TOKEN']}@github.com/${env['GITHUB_REPOSITORY']}.git';
  await Process.run('git', ['push', '-f', remoteRepo]);
}