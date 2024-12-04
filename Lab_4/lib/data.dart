
// Data Layer: Controller for managing data.
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'domain.dart'; // Import models

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
