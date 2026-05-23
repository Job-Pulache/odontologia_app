import 'package:cloud_firestore/cloud_firestore.dart';

class UserValidationService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> isAuthorizedUser(String phone) async {
    final result = await _firestore
        .collection('odontologos')
        .where('telefono', isEqualTo: phone)
        .where('activo', isEqualTo: true)
        .get();

    return result.docs.isNotEmpty;
  }
}
