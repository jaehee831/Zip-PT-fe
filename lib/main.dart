import 'package:flutter/material.dart';
import 'pages/archive_page.dart';

void main() {
  // Flutter 앱의 시작점
  runApp(MyApp()); // 위젯 트리를 루트부터 렌더링하도록 지시하는 함수
  // MyApp 클래스를 루트 위젯으로 설정하여 실행
}

class MyApp extends StatelessWidget {
  // MyApp 클래스는 Flutter에서 앱을 초기화하는 기본 위젯
  // StatelessWidget을 상속받아 상태가 없는 위젯으로 정의되었으며, 빌드할 때 화면의 변동이 없는 구조
  @override
  Widget build(BuildContext context) {
    // Flutter의 UI는 build 메서드를 통해 그려짐
    // 이 메서드는 Flutter 프레임워크가 UI를 렌더링할 때 호출하며
    // MaterialApp 위젯을 반환하여 앱의 구조를 정의
    return MaterialApp(
      // Flutter 앱의 근간이 되는 위젯. 전체 앱의 테마와 홈 화면, 네비게이션 등을 관리
      title: 'Flutter Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //상태를 가질 수 있는 StatefulWidget을 상속받음.
  //사용자가 상호작용 해서 상태가 변경될 때, UI를 다시 빌드해 화면에 반영 가능
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //MyHomePage의 상태를 관리하는 클래스
  //State<MyHomePage>를 상속받아 MyHomePage와 연결됨
  int _selectedIndex = 0; //현재 선택된 하단 내비게이션 항목의 인덱스 저장하는 변수

  static final List<Widget> _widgetOptions = <Widget>[
    //사용자가 선택한 항목에 따라 Text 위젯을 표시하는 List
    const Text('Home'),
    const Text('Search'),
    const Text('Notifications'),
    ArchivePage(),
    const Text('Profile'),
  ];

  void _onItemTapped(int index) {
    //이 함수는 하단 내비게이션 바의 항목을 눌렀을 때 호출됨
    setState(() {
      _selectedIndex =
          index; //index를 받아 _selectedIndex를 업데이트하고, setState로 상태 갱신하여 화면 다시 그림
    });
  }

  @override
  Widget build(BuildContext context) {
    //build 메서드는 UI를 정의하는 곳. Scaffold 위젯을 사용해 기본 레이아웃을 구성
    return Scaffold(
      //Flutter에서 화면의 기본 구조를 정의하는 위젯
      appBar: AppBar(
        title: Text('ZipPT'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Checklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Archive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
