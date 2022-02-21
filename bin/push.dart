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
  await Process.run('git', ['branch', 'gh-pages']);
  await Process.run('git', ['checkout', 'gh-pages']);

  //Add
  for (var element in targets) {
    var addResult = await Process.run('git', ['add', element]);
    if (addResult.stderr != '') print('git add error:' + addResult.stderr);
  }

  //Commit
  var commitResult = await Process.run('git', ['commit', '-m', 'deploy']);
  if (commitResult.stderr != '') print('commit error:' + commitResult.stderr);

  //Push
  var remoteRepo =
      'https://${env['GITHUB_ACTOR']}:${env['GITHUB_TOKEN']}@github.com/${env['GITHUB_REPOSITORY']}.git';
  var pushResult = await Process.run('git', ['push', '-f', remoteRepo]);
  if (pushResult.stderr != '') print('push stderr:' + pushResult.stderr);
}
