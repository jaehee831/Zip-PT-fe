import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9F8F4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherCard(),
              SizedBox(height: 20),
              RecentHouseCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String city = '';
  String temperature = '';
  String feelsLike = '';
  String description = '';
  String humidity = '';
  String iconUrl = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url = Uri.parse('http://210.125.84.145:8000/api/weather');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "latitude": 34.7,
        "longitude": 126.9780,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        city = data['city'];
        temperature = "${data['temperature']['current']}°";
        feelsLike = "체감 ${data['temperature']['feels_like']}°";
        description = data['weather']['description'];
        humidity = "습도 ${data['humidity']}%";
        iconUrl = data['weather']['icon'];
      });
    } else {
      print('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFFFCDD2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "오늘의 날씨 - $city",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              iconUrl.isNotEmpty
                  ? Image.network(iconUrl, width: 40, height: 40)
                  : const Icon(Icons.wb_cloudy, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    temperature,
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Text(description),
                  Text(feelsLike,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Text("일요일 | 11월 7일"), // 예시 날짜 (서버에서 날짜 데이터를 받지 않는 경우)
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.opacity, size: 16),
                      Text(humidity),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecentHouseCard extends StatelessWidget {
  const RecentHouseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/house.png', // 로컬 이미지 사용
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "영산강 뷰 완전 조은 단독주택",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("3:30 PM | 아따 뷰가 좋당께"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
