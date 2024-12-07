import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final newsCollection = FirebaseFirestore.instance.collection('news');

  Future<String?> uploadImage(Uint8List imageData, String newsTitle) async {
    try {
      Reference ref = _storage.ref().child('$newsTitle/image');
      UploadTask uploadTask = ref.putData(imageData);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> addNews(String id) {
    return newsCollection.doc(id).set(
      {
        'likes': 0,
        'id': id,
      },
    );
  }
}
