//import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

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

  /*getProductKeyword(String skinTone, String weather) {
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
  }*/


  setProducts(List<Map<String,dynamic>> product){

    products2.value=product;
    print("${products2.value}");
  }

  List<String> getProductKeywords(String skinTone, String weather) {
  final s = skinTone.toLowerCase().trim();
  final w = weather.toLowerCase().trim();

  final Map<String, Map<String, List<String>>> data = {
  'white': {
  'sunny': [
  "sunscreen", "sunglasses", "white dress", "summer hat", "light jacket",
  "beachwear", "flip flops", "cotton shirt", "shorts", "sun hat",
  "linen pants", "tank top", "swimwear", "sandals", "sunblock",
  "light scarf", "summer bag", "casual shirt", "sports shoes", "beach towel",
  "baseball cap", "sun dress", "parasol", "beach sandals", "summer sandals",
  "breezy blouse", "cropped pants", "short sleeve shirt", "light cardigan", "sun gloves",
  "water bottle", "outdoor sunglasses", "summer socks", "sport hat", "light hoodie",
  "daypack", "swim shorts", "beach hat", "summer sandals", "sun visor",
  "beach ball", "summer watch", "summer earrings", "sunglasses case", "flip flop bag",
  "tote bag", "beach blanket", "pool float", "outdoor sandals", "summer necklace",
  "sunglasses strap"
  ],
  'rainy': [
  "light raincoat", "umbrella", "waterproof shoes", "rain hat", "poncho",
  "rain boots", "water resistant jacket", "waterproof bag", "rain pants", "waterproof gloves",
  "rain poncho", "waterproof hat", "quick dry shirt", "rain umbrella", "waterproof watch",
  "water resistant shoes", "rain coat", "waterproof jacket", "rain boots", "rain boots covers",
  "rain gloves", "rain pants", "waterproof backpack", "rain cover", "waterproof phone case",
  "rain gaiters", "waterproof socks", "waterproof pants", "water resistant gloves", "waterproof raincoat",
  "waterproof scarf", "raincoat with hood", "raincoat vest", "waterproof face mask", "rain umbrella cover",
  "rain shoes", "waterproof outdoor gear", "rain poncho with hood", "rainproof jacket", "rainproof backpack",
  "waterproof trekking pants", "rainproof gloves", "rainproof shoes", "waterproof camera case", "raincoat packable",
  "waterproof travel bag", "rain boots with fur", "waterproof jacket packable", "rain gear", "waterproof shell"
  ],
  'cold': [
  "wool sweater", "winter coat", "gloves", "scarf", "thermal socks",
  "beanie", "thermal underwear", "down jacket", "earmuffs", "winter boots",
  "fleece jacket", "winter gloves", "wool scarf", "thermal hat", "winter hat",
  "insulated jacket", "snow boots", "thick socks", "thermal gloves", "down vest",
  "wool gloves", "winter pants", "thermal leggings", "winter sweater", "heated gloves",
  "heated socks", "thermal scarf", "thermal coat", "fur coat", "fleece gloves",
  "thermal jacket", "wool hat", "thick gloves", "winter mittens", "thermal hoodie",
  "down mittens", "wool socks", "thermal vest", "winter parka", "heated jacket",
  "insulated pants", "fur gloves", "winter earmuffs", "thermal boots", "wool boots",
  "thermal headband", "fleece pants", "winter fleece", "heated gloves", "thermal neck gaiter"
  ],
  },

  'brown': {
  'sunny': [
  "cotton shirt", "sunglasses", "light pants", "sun hat", "summer sandals",
  "linen shirt", "summer dress", "flip flops", "sun visor", "casual shorts",
  "tank top", "beachwear", "cotton shorts", "breathable shirt", "sports sandals",
  "summer jacket", "summer cap", "light scarf", "outdoor sandals", "beach bag",
  "canvas shoes", "light hoodie", "summer socks", "sun dress", "casual shirt",
  "short sleeve shirt", "summer backpack", "summer sunglasses", "summer necklace", "breezy blouse",
  "cropped pants", "casual sandals", "summer hat", "sun gloves", "summer watch",
  "sport hat", "beach towel", "summer earrings", "light cardigan", "summer boots",
  "summer shoes", "beach ball", "swimwear", "sun dress", "outdoor sunglasses",
  "tank dress", "light pants", "summer sandals", "cotton jacket", "summer blouse"
  ],
  'rainy': [
  "raincoat", "umbrella", "waterproof boots", "rain hat", "rain jacket",
  "waterproof shoes", "water resistant jacket", "rain pants", "rain boots covers", "rain gloves",
  "rain poncho", "waterproof hat", "quick dry shirt", "rain umbrella", "waterproof watch",
  "water resistant shoes", "raincoat with hood", "raincoat vest", "waterproof gloves", "rainproof jacket",
  "waterproof backpack", "rain cover", "waterproof phone case", "rain gaiters", "waterproof socks",
  "waterproof pants", "water resistant gloves", "waterproof raincoat", "raincoat packable", "waterproof scarf",
  "rainproof backpack", "rainproof gloves", "rainproof shoes", "waterproof camera case", "rain boots with fur",
  "waterproof jacket packable", "rain gear", "waterproof shell", "rain boots waterproof", "raincoat waterproof",
  "waterproof mittens", "rain poncho waterproof", "waterproof poncho", "rain boots men", "rain boots women",
  "rain jacket waterproof", "waterproof hiking boots", "rain jacket men", "rain jacket women", "waterproof jacket men"
  ],
  'cold': [
  "thermal jacket", "wool scarf", "winter boots", "gloves", "beanie",
  "winter coat", "thermal gloves", "heated jacket", "insulated pants", "fur gloves",
  "thermal socks", "winter hat", "fleece jacket", "thermal underwear", "down jacket",
  "earmuffs", "thermal scarf", "heated gloves", "winter mittens", "thermal vest",
  "wool gloves", "winter pants", "thermal leggings", "thermal hat", "thermal hoodie",
  "down mittens", "wool socks", "winter parka", "heated socks", "thermal boots",
  "fur coat", "fleece gloves", "thermal coat", "wool hat", "thick gloves",
  "heated jacket men", "insulated jacket", "snow boots", "thermal headband", "fleece pants",
  "winter fleece", "thermal neck gaiter", "heated jacket women", "winter gloves", "thermal jacket women"
  ],
  },

  'black': {
  'sunny': [
  "light jacket", "sunglasses", "sun hat", "shorts", "tank top",
  "summer shirt", "flip flops", "light pants", "casual shoes", "cotton shirt",
  "beachwear", "summer dress", "breathable shirt", "sun visor", "summer sandals",
  "summer cap", "sports shoes", "beach towel", "summer socks", "summer watch",
  "tank dress", "outdoor sandals", "beach bag", "casual shirt", "light scarf",
  "cropped pants", "summer earrings", "summer jacket", "sun gloves", "summer blouse",
  "swimwear", "cotton shorts", "short sleeve shirt", "breezy blouse", "summer backpack",
  "casual sandals", "summer hat", "summer shoes", "light hoodie", "beach ball",
  "summer necklace", "summer dress", "outdoor sunglasses", "summer boots", "summer bag",
  "summer cap", "summer sandals", "summer pants", "summer jacket", "summer blouse"
  ],
  'rainy': [
  "waterproof coat", "umbrella", "rain boots", "poncho", "waterproof gloves",
  "rain jacket", "rain boots waterproof", "waterproof jacket packable", "rain gear", "waterproof shell",
  "rainproof jacket", "waterproof raincoat", "raincoat waterproof", "waterproof mittens", "rain poncho waterproof",
  "waterproof poncho", "rain boots men", "rain boots women", "rain jacket waterproof", "waterproof hiking boots",
  "rain jacket men", "rain jacket women", "waterproof jacket men", "raincoat packable", "rainproof gloves",
  "rainproof shoes", "waterproof camera case", "rain boots with fur", "water resistant jacket", "rain boots covers",
  "rain gloves", "rain pants", "waterproof backpack", "rain cover", "waterproof phone case",
  "rain gaiters", "waterproof socks", "waterproof pants", "water resistant gloves", "quick dry shirt",
  "rain umbrella", "waterproof watch", "water resistant shoes", "raincoat with hood", "raincoat vest",
  "raincoat", "umbrella", "waterproof shoes", "rain hat", "poncho"
  ],
  'cold': [
  "winter coat", "thermal gloves", "beanie", "scarf", "winter boots",
  "fleece jacket", "wool scarf", "thermal hat", "winter hat", "insulated jacket",
  "snow boots", "thick socks", "thermal gloves", "down vest", "wool gloves",
  "winter pants", "thermal leggings", "winter sweater", "heated gloves", "heated socks",
  "thermal scarf", "thermal coat", "fur coat", "fleece gloves", "thermal jacket",
  "wool hat", "thick gloves", "winter mittens", "thermal hoodie", "down mittens",
  "wool socks", "thermal vest", "winter parka", "heated jacket", "insulated pants",
  "fur gloves", "winter earmuffs", "thermal boots", "wool boots", "thermal headband",
  "fleece pants", "winter fleece", "heated gloves", "thermal neck gaiter", "heated jacket women",
  "heated jacket men", "winter gloves", "thermal jacket women", "thermal jacket men", "thermal gloves men"
  ],
  },
  };

  if (data.containsKey(s)) {
  if (data[s]!.containsKey(w)) {
  return data[s]![w]!;
  } else {
  List<String> combinedKeywords = [];
  data[s]!.values.forEach((list) {
  combinedKeywords.addAll(list);
  });
  return combinedKeywords.toSet().toList();
  }
  } else {
  // Fallback generic keywords - 50+
  return [
  "clothing", "shoes", "accessories", "jackets", "bags", "hats",
  "summer clothes", "winter clothes", "casual wear", "formal wear",
  "sportswear", "outdoor gear", "rainwear", "footwear", "backpacks",
  "jackets", "coats", "scarves", "gloves", "socks",
  "t-shirts", "pants", "shorts", "skirts", "dresses",
  "swimwear", "hats", "belts", "watches", "jewelry",
  "sunglasses", "boots", "sandals", "sneakers", "hoodies",
  "sweaters", "thermal wear", "underwear", "sleepwear", "formal shirts",
  "casual shirts", "sports shoes", "running shoes", "cycling gear", "gym clothes"
  ];
  }
  }
  }



