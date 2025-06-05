import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirbaseFirestoreDatabase extends GetxController {
  RxMap<String, String> addedProductIds = <String, String>{}.obs;

  Future<String?> saveDataToFirestore(Map<String, dynamic> product, BuildContext context) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('products').add(product);
      String docId = docRef.id;
      await docRef.update({"id": docId});
      return docId;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add product to cart")));
      return null;
    }
  }

  Future<void> deleteData(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection("products").doc(docId).delete();
      print("Document $docId deleted");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete product")),
      );
    }
  }

  // Load cart on app start ya jab chahein
  Future<void> loadCartFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data != null && data["title"] != null) {
        addedProductIds[data["title"]] = doc.id;
      }
    }
    addedProductIds.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    loadCartFromFirestore();
  }
}
