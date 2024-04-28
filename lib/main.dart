import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:alice/alice.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Alice alice = Alice(showNotification: true); // Alice'i oluştur

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alice Example',
      home: MyHomePage(alice: alice),
      navigatorKey: alice.getNavigatorKey(), // Alice navigator key
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Alice alice;

  const MyHomePage({required this.alice, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Dio dio;
  late ImagePicker imagePicker; // image picker to gallery and camera

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker(); // initialize image picker
    dio = Dio(); // initialize Dio
    dio.interceptors
        .add(widget.alice.getDioInterceptor()); // Alice'i Dio'ya bağla
  }

  void fetchData() async {
    try {
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (kDebugMode) {
        print('Data: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hata: $e');
      }
    }
  }

  Future<void> postData() async {
    try {
      Response response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      );
      if (kDebugMode) {
        print('POST Request result: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('POST Request erorr: $e');
      }
    }
  }

  Future<void> putData() async {
    try {
      Response response = await dio.put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      );
      if (kDebugMode) {
        print('PUT request result: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('PUT request erorr: $e');
      }
    }
  }

  Future<void> deleteData() async {
    try {
      Response response =
          await dio.delete('https://jsonplaceholder.typicode.com/posts/1');
      if (kDebugMode) {
        print('DELETE request result: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DELETE request erorr: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alice Example'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              widget.alice.showInspector(); // Alice arayüzünü açmak için
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: fetchData, // HTTP isteklerini tetikler
              child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 186, 135, 195),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Fetch Data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
            GestureDetector(
              onTap: deleteData, // HTTP isteklerini tetikler
              child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 186, 135, 195),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Delete Data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
            GestureDetector(
              onTap: postData, // HTTP isteklerini tetikler
              child: Container(
                  height: 50,
                  width: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 186, 135, 195),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Post Data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
            GestureDetector(
              onTap: putData, // HTTP isteklerini tetikler
              child: Container(
                  height: 50,
                  width: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 186, 135, 195),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Put Data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
