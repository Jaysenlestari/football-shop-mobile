// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    int? userId;
    String id;
    String name;
    int price;
    String brand;
    String description;
    String thumbnail;
    String category;
    int stock;
    int rating;
    String? clothesSize;
    String? shoeSize;
    bool isFeatured;

    ProductEntry({
        required this.userId,
        required this.id,
        required this.name,
        required this.price,
        required this.brand,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.stock,
        required this.rating,
        required this.clothesSize,
        required this.shoeSize,
        required this.isFeatured,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        userId: json["user_id"],
        id: json["id"],
        name: json["name"],
        price: json["price"],
        brand: json["brand"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        stock: json["stock"],
        rating: json["rating"],
        clothesSize: json["clothes_size"],
        shoeSize: json["shoe_size"],
        isFeatured: json["is_featured"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "name": name,
        "price": price,
        "brand": brand,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "stock": stock,
        "rating": rating,
        "clothes_size": clothesSize,
        "shoe_size": shoeSize,
        "is_featured": isFeatured,
    };
}
