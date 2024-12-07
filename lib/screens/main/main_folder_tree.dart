import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/tree_provider.dart';

class MainFolderTree extends StatelessWidget {
  const MainFolderTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TreeProvider>( // TreeProvider를 Consumer로 감싸서 상태 관리
          builder: (context, treeProvider, child) {
            return ListView.builder(
              shrinkWrap: true, // 내부 스크롤뷰에 맞게 크기 조정
              itemCount: treeProvider.rooms.length,
              itemBuilder: (context, index) {
                final room = treeProvider.rooms[index];
                return FolderNode(
                  folderName: room.title.toString(), // Room의 이름을 폴더로 사용
                  children: room.containers.map<Widget>((container) {
                    return FileNode(
                      fileName: container.title.toString(), // Container를 파일로 표현
                      children: container.slots.map<Widget>((slot) {
                        return ArticleNode(
                          articleName: slot.title.toString(), // Slot을 아티클로 표현
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FolderNode extends StatelessWidget {
  final String folderName;
  final List<Widget> children;

  const FolderNode({Key? key, required this.folderName, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.folder),
      title: Text(folderName),
      children: children, // 자식 항목들을 하위로 표시
    );
  }
}

class FileNode extends StatelessWidget {
  final String fileName;
  final List<Widget> children;

  const FileNode({Key? key, required this.fileName, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.insert_drive_file),
      title: Text(fileName),
      children: children,
    );
  }
}

class ArticleNode extends StatelessWidget {
  final String articleName;

  const ArticleNode({Key? key, required this.articleName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.article),
      title: Text(articleName),
    );
  }
}
