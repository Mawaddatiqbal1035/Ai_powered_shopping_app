import 'package:ai_powered_shopping/core/share_service/firbase_firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/gemini_recommend_product_controller.dart';
import 'my_cart_Screen.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});

  final geminiController = Get.find<GeminiRecommendProductController>();
  final firbaseFirstoreDatabase = Get.find<FirbaseFirestoreDatabase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF152049),
        title: Text("Catalogs", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Obx(() {
        final products = geminiController.products2;

        if (products.isEmpty) {
          return Center(child: Text("No products to show."));
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              final productKey = product["title"];

              return Obx(() {
                final isAdded = firbaseFirstoreDatabase.addedProductIds.containsKey(productKey);

                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: product["thumbnail"] != null && product["thumbnail"] != ""
                            ? Image.network(product["thumbnail"], fit: BoxFit.cover)
                            : Icon(Icons.image_not_supported, size: 80),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product["title"] ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Price: \$${product["price"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAdded ? Colors.red :  Color(0xFF152049),
                          ),
                          onPressed: () async {
                            if (isAdded) {
                              // Delete product from Firestore
                              String? docId = firbaseFirstoreDatabase.addedProductIds[productKey];
                              if (docId != null) {
                                await firbaseFirstoreDatabase.deleteData(docId, context);
                                firbaseFirstoreDatabase.addedProductIds.remove(productKey);
                                firbaseFirstoreDatabase.addedProductIds.refresh();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${product["title"]} removed")),
                                );
                              }
                            } else {
                              // Add product to Firestore
                              String? docId = await firbaseFirstoreDatabase.saveDataToFirestore(product, context);
                              if (docId != null) {
                                firbaseFirstoreDatabase.addedProductIds[productKey] = docId;
                                firbaseFirstoreDatabase.addedProductIds.refresh();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Added to cart")),
                                );
                              }
                            }
                          },
                          child: Text(isAdded ? "Delete" : "Add to cart",style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyCartScreen()));
        },
        label: Text("Go to cart", style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        backgroundColor: Color(0xFF152049),
      ),
    );
  }
}
