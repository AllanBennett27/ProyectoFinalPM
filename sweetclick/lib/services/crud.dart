import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDBakery {
   
  


  //CRUD
  //Create
  Future<void> UploadDessert({
    required String description,
    required String imageUrl,
    required String name,
    required double price,
    required String type
  }) async{
    try{
     final data = await FirebaseFirestore.instance.collection("Desserts").add({
       "date": FieldValue.serverTimestamp(),
        "description": description,
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
        "type": type
      });
      print(data.id);

    }catch(e){
      print(e);
    }
  }


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



  // //Create
  // Future<void> addNote(String title, String content, String type){
  //   return notas.add({
  //     'timestamp': Timestamp.now(),
  //     'title': title,
  //     'content': content,
  //     'type': type,

  //   });
  // }

  // //Read
  // Stream<QuerySnapshot> getNotasStream(){
  //   final notasStream = 
  //   notas.orderBy('timestamp',descending: true).snapshots();
  //   return notasStream;
  // }

  // //update
  // Future<void> updateNote(String docId, String nuevoTitulo, String nuevoContenido, String newType){
  //   return notas.doc(docId).update({
  //    'title': nuevoTitulo,
  //    'content': nuevoContenido,
  //    'type': newType,
  //    'timestamp': Timestamp.now(),
  //   });
  // }

  // //delete
  // Future<void> deleteNote(String docID) {
  //   return notas.doc(docID).delete();
  // }

  

}