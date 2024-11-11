import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/Models/UserRecord.dart';
import 'package:flutter_demo/Modules/login.dart';
import 'package:flutter_demo/Utils/AppColor.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Userrecord> userRecords = [];
  int currentPage = 0;
  final int itemsPerSet = 15;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    List<Userrecord> allData = await loadUserData();
    setState(() {
      userRecords.addAll(getPaginatedData(allData));
    });
  }

  Future<List<Userrecord>> loadUserData() async {
    final String response =
        await rootBundle.loadString('assets/user_dummy_data.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Userrecord.fromJson(json)).toList();
  }

  List<Userrecord> getPaginatedData(List<Userrecord> allData) {
    final int start = currentPage * itemsPerSet;
    final int end = start + itemsPerSet;
    currentPage++;
    return allData.sublist(start, end > allData.length ? allData.length : end);
  }

  Future<void> loadMoreData() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      List<Userrecord> allData = await loadUserData();
      final List<Userrecord> nextItems = getPaginatedData(allData);

      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        userRecords.addAll(nextItems);
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              color: Appcolor.primaryColor,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello, user',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: const Text('Logout',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none)),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: userRecords.length + 1,
                  itemBuilder: (context, index) {
                    if (index == userRecords.length) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Appcolor.primaryColor,
                              ))
                            : GestureDetector(
                                onTap: () {
                                  loadMoreData();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Appcolor.primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 40,
                                  child: const Center(
                                    child: Text(
                                      'Load more data',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }

                    final user = userRecords[index];
                    return GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            String newRupeeValue = '';

                            return AlertDialog(
                              title: const Text("Enter New Rupee Value"),
                              content: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "Enter amount",
                                ),
                                onChanged: (value) {
                                  newRupeeValue = "\$${value}";
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      userRecords[index].rupee = newRupeeValue;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Change"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            user.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(user.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone: ${user.phone}'),
                            Text('City: ${user.city}'),
                            Text(
                              'Rupee: ${user.rupee}',
                              style: TextStyle(
                                color: double.tryParse(user.rupee.replaceAll(
                                                RegExp(r'[^0-9.]'), '')) !=
                                            null &&
                                        double.tryParse(user.rupee.replaceAll(
                                                RegExp(r'[^0-9.]'), ''))! >
                                            50
                                    ? Colors.green // If rupee is more than 50
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
