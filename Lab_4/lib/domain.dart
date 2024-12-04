
// Domain Layer: Models for the app's data.
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
