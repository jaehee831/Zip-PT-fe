// checklist_screen.dart
import 'package:flutter/material.dart';
import 'package:zippt/colors.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<Map<String, dynamic>> _checklistItems = [
    {
      'title': '화장실 수압 상태',
      'tags': ['좋음', '보통', '나쁨']
    },
    {
      'title': '창문 방향',
      'tags': ['남', '동', '서', '북']
    },
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
      backgroundColor: AppColors.main,
      appBar: AppBar(
        title: const Text(
          '집보기 체크리스트',
          style: TextStyle(
            fontFamily: 'GowunBatang', // GowunBatang 폰트 사용
            fontWeight: FontWeight.bold, // Bold 스타일 적용
          ),
        ),
        backgroundColor: AppColors.main,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.mainGrey, // 박스 색상을 mainGrey로 설정
                borderRadius: BorderRadius.circular(8), // 라운딩 추가
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 그림자 색상
                    blurRadius: 4, // 그림자 블러 정도
                    offset: const Offset(0, 2), // 그림자의 위치 (x, y)
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0), // 텍스트 주위에 여백 추가
              child: const Text(
                '꼭 체크해야하는 부분을 아래에 자유롭게 추가해 주세요.',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: '새로운 체크리스트 항목',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _checklistItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 238, 224, 224),
                    child: ExpansionTile(
                      title: Text(_checklistItems[index]['title']),
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: List<Widget>.generate(
                            _checklistItems[index]['tags'].length,
                            (tagIndex) {
                              return Chip(
                                label: Text(
                                    _checklistItems[index]['tags'][tagIndex]),
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
                                icon: const Icon(Icons.add),
                                onPressed: () => _addTag(index),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Color.fromARGB(255, 79, 79, 79)),
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
