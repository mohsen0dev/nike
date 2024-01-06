class BanerEntity {
  final int id;
  final String imageUrl;
  BanerEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        imageUrl = json["image"];
}
