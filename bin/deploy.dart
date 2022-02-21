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
  await Process.run(
      'git', ['config', '--global', 'user.name', env['GITHUB_ACTOR']!]);
  await Process.run('git', [
    'config',
    '--global',
    'user.email',
    '${env['GITHUB_ACTOR']}@users.noreply.github.com'
  ]);

  //Git set
  var initResult = await Process.run('git', ['init']);
  print('git init > stdout: ${initResult.stdout}');
  print('git init > stderr: ${initResult.stderr}');

  //Add
  var addResult = await Process.run('git', ['add', '--all']);
  print('git add --all > stdout: ${addResult.stdout}');
  print('git add --all > stderr: ${addResult.stderr}');

  //Commit
  var commitResult = await Process.run('git', ['commit', '-m', 'deploy']);
  print('git commit > stdout: ${commitResult.stdout}');
  print('git commit > stderr: ${commitResult.stderr}');

  //Branch
  var branchCreateResult = await Process.run('git', ['branch', 'gh-pages']);
  print('git branch gh-pages > stdout: ${branchCreateResult.stdout}');
  print('git branch gh-pages > stderr: ${branchCreateResult.stderr}');

  var checkoutResult = await Process.run('git', ['checkout', 'gh-pages']);
  print('git checkout gh-pages > stdout: ${checkoutResult.stdout}');
  print('git checkout gh-pages > stderr: ${checkoutResult.stderr}');

  var branchRemoveResult = await Process.run('git', ['branch', '-d', 'master']);
  print('git branch -d master > stdout: ${branchRemoveResult.stdout}');
  print('git branch -d master > stderr: ${branchRemoveResult.stderr}');

  //Remote
  var remoteUrl =
      'https://x-access-token:${env['INPUT_GITHUB_TOKEN']}@github.com/${env['GITHUB_REPOSITORY']}.git';
  var remoteResult =
      await Process.run('git', ['remote', 'add', 'origin', remoteUrl]);
  print('git remote add $remoteUrl > stdout: ${remoteResult.stdout}');
  print('git remote add $remoteUrl > stderr: ${remoteResult.stderr}');

  //Push
  var pushResult =
      await Process.run('git', ['push', '-f', 'origin', 'gh-pages']);
  print('git push -f origin gh-pages > stdout: ${pushResult.stdout}');
  print('git push -f origin gh-pages > stderr: ${pushResult.stderr}');
}
