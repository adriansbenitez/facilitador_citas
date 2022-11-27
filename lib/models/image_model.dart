class ImageModel {
  late int id;
  late String full;

  ImageModel({
    required this.id,
    required this.full,
  });

  void update(ImageModel item) {
    id = item.id;
    full = item.full;
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? 0,
      full: json['full']['url'] ?? '',
    );
  }

  factory ImageModel.fromDataImage(String pathUrl) {
    return ImageModel(
      id: 0,
      full: pathUrl,
    );
  }
}
