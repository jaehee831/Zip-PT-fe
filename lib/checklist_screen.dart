// checklist_screen.dart
import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<Map<String, dynamic>> _checklistItems = [
    {'title': '화장실 수압 상태', 'tags': ['좋음', '보통', '나쁨']},
    {'title': '창문 방향', 'tags': ['남', '동', '서', '북']},
  ];

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _checklistItems.add({'title': _itemController.text, 'tags': []});
      });
      _itemController.clear();
    }
  }

  void _addTag(int index) {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _checklistItems[index]['tags'].add(_tagController.text);
      });
      _tagController.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      _checklistItems.removeAt(index);
    });
  }

  void _removeTag(int itemIndex, int tagIndex) {
    setState(() {
      _checklistItems[itemIndex]['tags'].removeAt(tagIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F8F4),
      appBar: AppBar(
        title: Text('집보기 체크리스트'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '본인에게 있어서 꼭 체크해야하는 부분을 자유롭게 추가해 주세요.',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: '새로운 체크리스트 항목',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _checklistItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text(_checklistItems[index]['title']),
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: List<Widget>.generate(
                            _checklistItems[index]['tags'].length,
                            (tagIndex) {
                              return Chip(
                                label: Text(_checklistItems[index]['tags'][tagIndex]),
                                onDeleted: () => _removeTag(index, tagIndex),
                              );
                            },
                          ).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _tagController,
                            decoration: InputDecoration(
                              labelText: '태그 추가',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => _addTag(index),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
