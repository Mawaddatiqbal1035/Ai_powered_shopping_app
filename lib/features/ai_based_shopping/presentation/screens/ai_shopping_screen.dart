import 'package:ai_powered_shopping/features/ai_based_shopping/presentation/controller/gemini_recommend_product_controller.dart';
import 'package:ai_powered_shopping/features/ai_based_shopping/presentation/widgets/catalog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class AiShoppingScreen extends StatefulWidget {
  AiShoppingScreen({super.key});

  @override
  State<AiShoppingScreen> createState() => _AiShoppingScreenState();
}

class _AiShoppingScreenState extends State<AiShoppingScreen> {

  bool isLoading=false;
  final skinToneController=TextEditingController();
  final weatherController=TextEditingController();
  final geminiController=Get.find<GeminiRecommendProductController>();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF152049),
      appBar: AppBar(
        backgroundColor:Color(0xFF152049),
        title: Padding(
          padding: const EdgeInsets.only(left: 67),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_cart_checkout_outlined,color: Colors.white,),
                  SizedBox(height: 10,),
                  Center(child: Text("AI shop",style: TextStyle(color:  Colors.white,),)),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: isLoading==true?CircularProgressIndicator(): SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Stack(
                  clipBehavior: Clip.none,
                  children:[
                    Opacity(
                      opacity: 0.500,
                      child: Image.asset("assets/image2.png",width: 320,height: 300,fit:BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      top:140 ,
                      left: 70,
                      child: RichText(text: TextSpan(text: "Create unique shopping ",style: TextStyle(
                          color: Colors.white,fontSize: 18))),
                    ),
                    Positioned(
                      top:160 ,
                      left: 78,
                      child: RichText(text: TextSpan(text: "designs with the power ",style: TextStyle(
                          color: Color(0xff02ed70),fontSize: 17))),
                    ),
                    Positioned(
                      top:180 ,
                      left: 150,
                      child: Center(
                        child: RichText(text: TextSpan(text: "of Ai. ",style: TextStyle(
                            color: Colors.white,fontSize: 17))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 214,left: 18,right: 18),
                      child: TextField(
                        controller: skinToneController,
                        decoration: InputDecoration(
                          hintText: 'Skin tone',
                          fillColor: Color(0xff2d418b),
                          helperText: "Enter Skin tone",
                          border: OutlineInputBorder(borderRadius:  BorderRadius.circular(15)),
                          filled: true,
                          hintStyle: TextStyle(fontSize: 15,color: Colors.white,),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35,right: 35),
              child: TextField(
                controller: weatherController,
                decoration: InputDecoration(
                  hintText: 'Weather',
                  fillColor: Colors.white,
                  helperText: "Enter Current Weather",
                  border: OutlineInputBorder(borderRadius:  BorderRadius.circular(15)),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 15,color: Colors.black,),
                ),
              ),),
            Padding(
                padding: const EdgeInsets.only(left: 35,right: 35),
                child: Container(
                  height: 40,
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });


                      await geminiRecommendationProducts(); // Wait for the products to load

                      setState(() {
                        isLoading = false;
                      });

                      if (geminiController.products2.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CatalogScreen()),
                        );
                      } else {
                        Get.snackbar(
                          "No Products",
                          "No matching products found",
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    }, child: Text("Submit",style: TextStyle(
                      color: Colors.black
                  ),),style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xff00ff75),)

                  ),),
                ))
          ],),
        ),
      ),
    );
  }
  Future<void> fetchShoppingProducts(List<String> keywords) async {
    // We’ll collect unique products here:
    final List<Map<String, dynamic>> combined = [];
    final seenIds = <int>{}; // to avoid duplicates

    // Decide how many keywords to try (e.g. first 3 or 4)
    final int maxKeywordsToTry = keywords.length;
    final List<String> toTry = keywords.take(maxKeywordsToTry).toList();

    for (var keyword in toTry) {
      final query = keyword.trim();
      if (query.isEmpty) continue;

      final uri =
          'https://dummyjson.com/products/search?q=${Uri.encodeComponent(query)}&limit=100&skip=0';
      print("Searching for \"$query\" → $uri");

      final response = await http.get(Uri.parse(uri));
      if (response.statusCode != 200) {
        print("API error for \"$query\": ${response.statusCode}");
        continue;
      }

      final jsonBody = jsonDecode(response.body);
      final List productsJson = jsonBody["products"] ?? [];
      print("Got ${productsJson.length} products for \"$query\"");

      for (var item in productsJson) {
        final id = item["id"] as int;
        if (seenIds.contains(id)) continue; // skip duplicates

        seenIds.add(id);
        combined.add({
          "id": id,
          "title": item["title"],
          "price": item["price"],
          "stock": item["stock"],
          "brand": item["brand"],
          "images": item["images"],
          "thumbnail": item["thumbnail"],
        });

        // Stop early if we have enough (e.g. 5) products
        if (combined.length >= 100) break;
      }

      if (combined.length >= 100) break;
    }

    // Finally, update the controller’s list
    geminiController.setProducts(combined);
    print(" Total products combined: ${combined.length}");
  }




  Future<void> geminiRecommendationProducts() async {
    try {
      setState(() { isLoading = true; });

      final List<String> geminiResult = geminiController
          .getProductKeywords(skinToneController.text, weatherController.text);
      print("Keywords from controller: $geminiResult");

      if (geminiResult.isNotEmpty) {
        await fetchShoppingProducts(geminiResult);
      } else {
        print(" No keywords generated");
        // Optionally clear old products if no keywords:
        geminiController.setProducts([]);
      }
    } catch (error) {
      print("Fetch failed: $error");
    } finally {
      setState(() { isLoading = false; });
    }
  }


}
