import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDBakery {
   
  


  //CRUD Desserts
  //Create
  Future<void> UploadDessert({
    required String description,
    required String imageUrl,
    required String name,
    required double price,
    required String type,
  
  }) async{
    try{

    final docRef = FirebaseFirestore.instance.collection("Desserts").doc();

    await docRef.set({
      "id": docRef.id, 
      "date": FieldValue.serverTimestamp(),
      "description": description,
      "imageUrl": imageUrl,
      "name": name,
      "price": price,
      "type": type,
    });
      print(docRef.id);

    }catch(e){
      print(e);
    }
  }

//read
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDesserts() {
    try {
      return FirebaseFirestore.instance
          .collection('Desserts')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs);
    } catch (e) {
      print("Error getting desserts: $e");
      return Stream.value([]); 
    }
  }


  //update

  Future<void> updateDessert(
    String docID,
     String description,
   String imageUrl,
    String name,
     double price,
     String type  
  ) async{
    try{
      final dessert =FirebaseFirestore.instance.collection("Desserts");
         return dessert.doc(docID).update   ({
       "date": FieldValue.serverTimestamp(),
        "description": description,
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
        "type": type
      });
   

    }catch(e){
      print(e);
    }
  }



  //delete
 
  Future<void> deleteDessert(String docID) {
  final dessert =FirebaseFirestore.instance.collection("Desserts");

    return dessert.doc(docID).delete();
  }


//CRUD carrito

//create
Future<void> addToCart({
  required String userId, 
  required String dessertId,
   String imageUrl = "",
  required int quantity,
  required double price,
  required String name,
}) async {
  try {
    final cartRef = FirebaseFirestore.instance.collection("Carts").doc(userId);
    final cartDoc = await cartRef.get();

    if (cartDoc.exists) {

      final List<dynamic> items = cartDoc.data()!["items"];
      final index = items.indexWhere((item) => item["dessertId"] == dessertId);

      if (index != -1) {
       
        items[index]["quantity"] += quantity;
      } else {
     
        items.add({
          "dessertId": dessertId,
          "quantity": quantity,
          "price": price,
          "imageUrl": imageUrl,
          "name": name,
        });
      }

      
      double total = items.fold(0, (sum, item) => sum + (item["quantity"] * item["price"]));

      await cartRef.update({
        "items": items,
        "total": total,
      });
    } else {
      await cartRef.set({
        "userId": userId,
        "items": [
          {
          
            "dessertId": dessertId,
            "quantity": quantity,
            "price": price,
            "imageUrl": imageUrl,
            "name": name
          }
        ],
        "total": price * quantity,
      });
    }
  } catch (e) {
    print("Error adding to cart: $e");
  }
}


//read
Stream<DocumentSnapshot<Map<String, dynamic>>> getCart(String userId) {
  try {
    return FirebaseFirestore.instance
        .collection("Carts")
        .doc(userId)
        .snapshots();
  } catch (e) {
    print("Error getting cart: $e");
    return const Stream.empty();
  }
}

//Delete
Future<void> removeFromCart({
  required String userId,
  required String dessertId,
}) async {
  try {
    final cartRef = FirebaseFirestore.instance.collection("Carts").doc(userId);
    final cartDoc = await cartRef.get();

    if (cartDoc.exists) {
      final List<dynamic> items = cartDoc.data()!["items"];
      items.removeWhere((item) => item["dessertId"] == dessertId);

      
      double total = items.fold(0, (sum, item) => sum + (item["quantity"] * item["price"]));

      await cartRef.update({
        "items": items,
        "total": total,
      });
    }
  } catch (e) {
    print("Error removing from cart: $e");
  }
}

//DeleteAll

Future<void> clearCart(String userId) async {
  try {
    await FirebaseFirestore.instance.collection("Carts").doc(userId).delete();
  } catch (e) {
    print("Error clearing cart: $e");
  }
}



}