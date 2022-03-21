import 'dart:io';

import 'package:path/path.dart' as path;

import 'custom_logger.dart';
import 'service/github_action_service.dart';

void main() async {
  var exportDirectory = Directory(GithubActionService.getExportPath());
  var targets = <String>[];
  await exportDirectory.create();

  CustomLogger.normal.i('Start Copying Assets');
  await _copyDirectory(Directory(GithubActionService.getAssetsFolderPath()), Directory(GithubActionService.getExportPath()));
  CustomLogger.normal.i('Finish Copying Assets');

  if (Platform.isWindows) return;

  CustomLogger.normal.i('Start Deploying');
  var children = exportDirectory.listSync();
  for (var child in children) {
    targets.add(child.path.replaceFirst(
        GithubActionService.EXPORT_FOLDER_NAME + Platform.pathSeparator, ''));
  }

  Directory.current = GithubActionService.getExportPath();

  //Set git user
  var setNameResult = await Process.run('git', [
    'config',
    '--global',
    'user.name',
    GithubActionService.getActorName()
  ]);
  CustomLogger.simple.v('git config --global user.name ${GithubActionService.getActorName()}> stdout: ${setNameResult.stdout}');
  CustomLogger.simple.v('git config --global user.name ${GithubActionService.getActorName()}> stderr: ${setNameResult.stderr}');
  var setEmailResult = await Process.run('git', [
    'config',
    '--global',
    'user.email',
    '${GithubActionService.getActorName()}@users.noreply.github.com'
  ]);
  CustomLogger.simple.v('git config --global user.email ${GithubActionService.getActorName()}@users.noreply.github.com> stdout: ${setEmailResult.stdout}');
  CustomLogger.simple.v('git config --global user.email ${GithubActionService.getActorName()}@users.noreply.github.com> stderr: ${setEmailResult.stderr}');
  var setDefaultNameResult = await Process.run('git', [
    'config',
    '--global',
    'init.defaultBranch',
    'master'
  ]);
  CustomLogger.simple.v('git config --global init.defaultBranch master> stdout: ${setDefaultNameResult.stdout}');
  CustomLogger.simple.v('git config --global init.defaultBranch master> stderr: ${setDefaultNameResult.stderr}');

  ////Git set
  var initResult = await Process.run('git', ['init']);
  CustomLogger.simple.v('git init > stdout: ${initResult.stdout}');
  CustomLogger.simple.v('git init > stderr: ${initResult.stderr}');

  //Add
  var addResult = await Process.run('git', ['add', '--all']);
  CustomLogger.simple.v('git add --all > stdout: ${addResult.stdout}');
  CustomLogger.simple.v('git add --all > stderr: ${addResult.stderr}');

  //Commit
  var commitResult = await Process.run('git', ['commit', '-m', 'deploy']);
  CustomLogger.simple.v('git commit > stdout: ${commitResult.stdout}');
  CustomLogger.simple.v('git commit > stderr: ${commitResult.stderr}');

  //Branch
  var branchCreateResult = await Process.run('git', ['branch', 'gh-pages']);
  CustomLogger.simple.v('git branch gh-pages > stdout: ${branchCreateResult.stdout}');
  CustomLogger.simple.v('git branch gh-pages > stderr: ${branchCreateResult.stderr}');

  var checkoutResult = await Process.run('git', ['checkout', 'gh-pages']);
  CustomLogger.simple.v('git checkout gh-pages > stdout: ${checkoutResult.stdout}');
  CustomLogger.simple.v('git checkout gh-pages > stderr: ${checkoutResult.stderr}');

  var branchRemoveResult = await Process.run('git', ['branch', '-d', 'master']);
  CustomLogger.simple.v('git branch -d master > stdout: ${branchRemoveResult.stdout}');
  CustomLogger.simple.v('git branch -d master > stderr: ${branchRemoveResult.stderr}');

  //Remote

  var remoteUrl = 'https://x-access-token:${GithubActionService.getGithubToken()}@github.com/${GithubActionService.getRepository()}.git';
  var remoteResult =
      await Process.run('git', ['remote', 'add', 'origin', remoteUrl]);
  CustomLogger.simple.v('git remote add $remoteUrl > stdout: ${remoteResult.stdout}');
  CustomLogger.simple.v('git remote add $remoteUrl > stderr: ${remoteResult.stderr}');

  //Push
  var pushResult =
      await Process.run('git', ['push', '-f', 'origin', 'gh-pages']);
  CustomLogger.simple.v('git push -f origin gh-pages > stdout: ${pushResult.stdout}');
  CustomLogger.simple.v('git push -f origin gh-pages > stderr: ${pushResult.stderr}');

  CustomLogger.normal.i('Finish Deplying');
}



Future<void> _copyDirectory(Directory source, Directory destination) async {
  await for (var entity in source.list(recursive: false)) {
    if (entity is Directory) {
      var newDirectory =
      Directory(path.join(destination.absolute.path, path.basename(entity.path)));
      await newDirectory.create();
      await _copyDirectory(entity.absolute, newDirectory);
    } else if (entity is File) {
      var p = path.join(destination.path, path.basename(entity.path));
      CustomLogger.simple.i('copied : ' + p);
      await entity.copy(p);
    }
  }
}