import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/data/network/api_services.dart';
import 'package:mvvm_template/data/network/network_api_services.dart';
import 'package:mvvm_template/resources/urls.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  final ApiService service = NetworkApiService();
  @override
  void initState() {
    super.initState();
    service.getGetApiResponse(AppUrls.randomAnimal);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Home'),),
    );
  }
}
