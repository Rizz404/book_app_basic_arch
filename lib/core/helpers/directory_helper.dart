import 'dart:io';

Future<Directory> getTemporaryDirectory() async {
  final tempDir = await getTemporaryDirectory();
  return await Directory('${tempDir.path}/cache').create(recursive: true);
}
