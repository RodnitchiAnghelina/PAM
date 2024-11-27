import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

// Model pentru datele JSON
class AppData {
  List<BannerModel> banners;
  List<CategoryModel> categories;
  List<CenterModel> nearbyCenters;
  List<DoctorModel> doctors;

  AppData({
    required this.banners,
    required this.categories,
    required this.nearbyCenters,
    required this.doctors,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      banners: (json['banners'] as List)
          .map((banner) => BannerModel.fromJson(banner))
          .toList(),
      categories: (json['categories'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
      nearbyCenters: (json['nearby_centers'] as List)
          .map((center) => CenterModel.fromJson(center))
          .toList(),
      doctors: (json['doctors'] as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList(),
    );
  }
}

class BannerModel {
  String title, description, image;

  BannerModel(
      {required this.title, required this.description, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class CategoryModel {
  String title, icon;

  CategoryModel({required this.title, required this.icon});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'],
      icon: json['icon'],
    );
  }
}

class CenterModel {
  String image, title, locationName;
  double reviewRate, distanceKm;
  int countReviews, distanceMinutes;

  CenterModel({
    required this.image,
    required this.title,
    required this.locationName,
    required this.reviewRate,
    required this.countReviews,
    required this.distanceKm,
    required this.distanceMinutes,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      image: json['image'],
      title: json['title'],
      locationName: json['location_name'],
      reviewRate: json['review_rate'].toDouble(),
      countReviews: json['count_reviews'],
      distanceKm: json['distance_km'].toDouble(),
      distanceMinutes: json['distance_minutes'],
    );
  }
}

class DoctorModel {
  String image, fullName, typeOfDoctor, locationOfCenter;
  double reviewRate;
  int reviewsCount;

  DoctorModel({
    required this.image,
    required this.fullName,
    required this.typeOfDoctor,
    required this.locationOfCenter,
    required this.reviewRate,
    required this.reviewsCount,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      image: json['image'],
      fullName: json['full_name'],
      typeOfDoctor: json['type_of_doctor'],
      locationOfCenter: json['location_of_center'],
      reviewRate: json['review_rate'].toDouble(),
      reviewsCount: json['reviews_count'],
    );
  }
}

// Controller pentru gestionarea datelor
class AppController extends GetxController {
  var appData =
      AppData(banners: [], categories: [], nearbyCenters: [], doctors: []).obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('lib/v1.json');
      final data = json.decode(response);
      appData.value = AppData.fromJson(data);
    } catch (e) {
      print("Eroare la încărcarea datelor: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

// Widget principal
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor Finder',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Finder'),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final data = controller.appData.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bannere
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(data.banners[0].image,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.banners[0].title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(data.banners[0].description),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Categorii
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.categories.length,
                    itemBuilder: (context, index) {
                      final category = data.categories[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(category.icon),
                            ),
                            SizedBox(height: 5),
                            Text(category.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Centre medicale
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Nearby Medical Centers",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ...data.nearbyCenters.map((center) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image.network(center.image, width: 50, height: 50),
                      ),
                      title: Text(center.title),
                      subtitle: Text(
                          '${center.locationName} - ${center.distanceKm} km'),
                      trailing: Text('${center.reviewRate} ⭐'),
                    ),
                  );
                }),
                // Doctori
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Doctors",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ...data.doctors.map((doctor) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image.network(doctor.image, width: 50, height: 50),
                      ),
                      title: Text(doctor.fullName),
                      subtitle: Text(
                          '${doctor.typeOfDoctor} - ${doctor.locationOfCenter}'),
                      trailing: Text('${doctor.reviewRate} ⭐'),
                    ),
                  );
                }),
              ],
            ),
          );
        }
      }),
    );
  }
}
