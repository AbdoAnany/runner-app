import 'package:cloud_firestore/cloud_firestore.dart';

class RoleService {
  final CollectionReference _rolesCollection = FirebaseFirestore.instance.collection('roles');

  Future<Map<String, dynamic>> getRolePermissions(String role) async {
    try {
      DocumentSnapshot doc = await _rolesCollection.doc(role).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Role not found');
      }
    } catch (e) {
      print('Error fetching role permissions: $e');
      return {};
    }
  }
}
