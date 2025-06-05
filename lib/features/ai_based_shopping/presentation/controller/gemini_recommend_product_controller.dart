

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GeminiRecommendProductController extends GetxController {
  RxList<Map<String,dynamic>> products2 = <Map<String,dynamic>>[].obs;
  List<String>keywordsList = [];
  // Static list of keywords

  final  keywords = [
    "Essence Mascara Lash Princess", "Eyeshadow Palette with Mirror", "Powder Canister",
    "Red Lipstick", "Red Nail Polish", "Calvin Klein CK One", "Chanel Coco Noir Eau De",
    "Dior J'adore", "Dolce Shine Eau de", "Gucci Bloom Eau de",
    "Toner", "Moisturizer",
    "sunglasses", "moisturizer", "foundation", "lipstick", "watch",
    "t-shirt", "shirt", "shoes", "sneakers", "heels", "boots", "scarf", "hat",
    "cap", "belt", "gloves", "ring", "necklace", "bracelet", "earrings",
    "perfume", "sunscreen", "face wash", "cleanser", "serum", "eye cream",
    "face mask", "toner", "body lotion", "body wash", "hair serum", "hair oil",
    "hair mask", "lip balm", "nail polish", "lip gloss", "eyeliner", "mascara",
    "blush", "bronzer", "concealer", "compact", "handbag", "backpack", "wallet",
    "jumpsuit", "Essence Mascara Lash Princess", "trousers", "shorts", "skirts", "dresses", "suits",
    "coats", "cardigans", "sweaters", "hoodies", "tracksuits", "sportswear",
    "swimwear", "lingerie", "sleepwear", "underwear", "socks", "ties", "bow tie",
    "cufflinks", "umbrella", "sandal", "flip flops", "loafers", "oxfords",
    "clutches", "crossbody bag", "tote bag", "ear cuff", "anklet", "hairband",
    "bandana", "poncho", "Dolce Shine Eau de", "Annibale Colombo Bed", "Annibale Colombo Sofa", "Bedside Table African Cherry",
    "Knoll Saarinen Executive Conference Chair", "Wooden Bathroom Sink With Mirror", "Apple", "Beef Steak", "Cat Food",
    "Chicken Meat", "Cucumber", "Dog Food", "Eggs", "Fish Steak",
    "Green Bell Pepper", "Green Chili Pepper", "Ice Cream", "Honey Jar", "Juice",
    "Kiwi"
  ];

  getProductKeyword(String skinTone, String weather) {
    keywordsList.clear();

    final s = skinTone.toLowerCase();
    final w = weather.toLowerCase();

    if (s == "white") {
      if (w == "sunny") {
        keywordsList.addAll([
          "Sunscreen", "Sunglasses", "Light Foundation", "Lip Balm",
          "Essence Mascara Lash Princess", "Red Lipstick",
        ]);
      } else if (w == "rainy") {
        keywordsList.addAll([
          "Waterproof Mascara", "Moisturizer", "Umbrella", "Boots",
          "Toner", "Face Wash",
        ]);
      } else if (w == "cloudy") {
        keywordsList.addAll([
          "Moisturizer", "Lipstick", "Eye Cream",
        ]);
      } else if (w == "cold") {
        keywordsList.addAll([
          "Body Lotion", "Lip Balm", "Hand Cream",
        ]);
      } else if (w == "hot") {
        keywordsList.addAll([
          "Sunscreen", "Sunglasses", "Light Powder",
        ]);
      } else {
        // Default for white skin if weather unknown
        keywordsList.addAll([
          "Moisturizer", "Foundation", "Lipstick",
        ]);
      }
    } else if (s == "black") {
      if (w == "sunny") {
        keywordsList.addAll([
          "SPF Lotion", "Bronzer", "Lip Gloss", "Hat",
          "Dior J'adore", "Gucci Bloom Eau de",
        ]);
      } else if (w == "rainy") {
        keywordsList.addAll([
          "Hydrating Serum", "Waterproof Eyeliner", "Jacket",
          "Face Mask", "Hair Oil",
        ]);
      } else if (w == "cloudy") {
        keywordsList.addAll([
          "Moisturizer", "Lipstick", "Serum",
        ]);
      } else if (w == "cold") {
        keywordsList.addAll([
          "Body Lotion", "Hair Mask", "Lip Balm",
        ]);
      } else if (w == "hot") {
        keywordsList.addAll([
          "Sunscreen", "Face Wash", "Light Foundation",
        ]);
      } else {
        // Default for black skin if weather unknown
        keywordsList.addAll([
          "Moisturizer", "Lipstick", "Eyeliner",
        ]);
      }
    } else if (s == "normal" || s == "medium" || s == "olive") {
      if (w == "sunny") {
        keywordsList.addAll([
          "Tinted Moisturizer", "Blush", "Sunglasses",
          "Essence Mascara Lash Princess", "Red Nail Polish",
        ]);
      } else if (w == "rainy") {
        keywordsList.addAll([
          "Waterproof Mascara", "Hydrating Cream", "Umbrella",
        ]);
      } else if (w == "cloudy") {
        keywordsList.addAll([
          "Face Wash", "Lipstick", "Body Lotion",
        ]);
      } else if (w == "cold") {
        keywordsList.addAll([
          "Hand Cream", "Lip Balm", "Moisturizer",
        ]);
      } else if (w == "hot") {
        keywordsList.addAll([
          "Sunscreen", "Light Powder", "Eye Cream",
        ]);
      } else {
        // Default for normal/medium skin
        keywordsList.addAll([
          "Moisturizer", "Foundation", "Lipstick",
        ]);
      }
    } else {
      // If skin tone unknown or empty
      keywordsList.addAll([
        "Moisturizer", "Foundation", "Lipstick", "Sunscreen", "Toner",
      ]);
    }

    return keywordsList.toList();
  }


  setProducts(List<Map<String,dynamic>> product){

    products2.value=product;
    print("${products2.value}");
  }
}
