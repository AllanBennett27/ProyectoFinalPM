import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDBakery {
   
  


  //CRUD
  //Create
  Future<void> UploadDessert({
    required String description,
    required String imageUrl,
    required String name,
    required double price,
  }) async{
    try{
     final data = await FirebaseFirestore.instance.collection("Desserts").add({
       "date": FieldValue.serverTimestamp(),
        "description": description,
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
      });
      print(data.id);

    }catch(e){
      print(e);
    }
  }


  //Read
     Future<List<QueryDocumentSnapshot>> getDesserts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Desserts').get();
      return querySnapshot.docs; 
    } catch (e) {
      print("Error getting desserts: $e");
      return []; 
    }
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