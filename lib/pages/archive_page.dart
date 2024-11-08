import 'package:flutter/material.dart';
import 'package:zippt/colors.dart';

class ArchivePage extends StatelessWidget {
  final List<House> houses = [
    House(
      title: '영상강 뷰 완전 좋은 단독주택',
      date: '1999년 11월 1일 오후 11시',
      address: '복당시 북당읍 북당리 북당마을 2단지 초가집 2호',
      imageUrl: 'assets/images/house_image1.jpg',
    ),
    House(
      title: '배산임수 풍수 최고 단독주택',
      date: '2000년 12월 2일 오후 2시',
      address: '광주광역시 북구 첨단과기로123 1호',
      imageUrl: 'assets/images/house_image2.jpg',
    ),
    House(
      title: '사과농장 뷰 달콤 단독주택',
      date: '2001년 1월 3일 오후 3시',
      address: '복당시 동당읍 동당리 동당마을 4단지 초가집 3호',
      imageUrl: 'assets/images/house_image3.jpg',
    ),
  ];

  ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내가 봤던 집',
          style: TextStyle(
            fontFamily: 'GowunBatang', // GowunBatang 폰트 사용
            fontWeight: FontWeight.bold, // Bold 스타일 적용
          ),
        ),
        backgroundColor: AppColors.main,
      ),
      body: ListView.builder(
        itemCount: houses.length,
        itemBuilder: (context, index) {
          return HouseCard(house: houses[index]); // HouseCard에 house 정보 전달
        },
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final House house;

  const HouseCard({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              house.imageUrl, // House의 이미지 URL 사용
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.title, // House의 제목 사용
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  house.date, // House의 날짜 사용
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  house.address, // House의 주소 사용
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class House {
  final String title;
  final String date;
  final String address;
  final String imageUrl;

  House({
    required this.title,
    required this.date,
    required this.address,
    required this.imageUrl,
  });
}
