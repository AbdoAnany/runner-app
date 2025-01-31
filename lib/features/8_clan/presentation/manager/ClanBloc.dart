import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:runner_app/features/6_profile/presentation/pages/profile_screen.dart';


import '../../../../core/const/const.dart';
import '../../data/models/ClanRequest.dart';
import 'ClanState.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClanCubit extends Cubit<ClanState> {
  ClanCubit() : super(ClanInitial());

  // Method to create a new clan
  void createClan({String name="No Name", String description='', int maxMembers=10}) async {
    emit(ClanLoading());
    Clan clan = Clan(
      id: "", // ID will be assigned by Firestore
      name: name,
      description: description,
      members: [AppData.currentUserDate.userId],
      maxMembers: maxMembers,
      leaderId: AppData.currentUserDate.userId,
      coLeaderIds: [],
    );
    try {
      final docRef = await FirebaseFirestore.instance.collection('Clans').add(clan.toJson());
      clan.id = docRef.id;
      await docRef.update(clan.toJson());
      emit(ClanCreated(clan));
    } catch (e) {
      emit(ClanError('Failed to create clan'));
    }
  }

  // Method to get all clans
  Future<void> getClans() async {
    emit(ClanLoading());
    List<Clan> clans = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('Clans').get();
      querySnapshot.docs.forEach((doc) {
        Clan clan = Clan.fromJson(doc.data());
        clans.add(clan);
      });
      emit(ClanLoaded(clans));
    } catch (e) {
      emit(ClanError('Failed to get clans'));
    }
  }

  // Method to get details of a specific clan
  Future<void> getClanDetails(String clanId) async {
    emit(ClanLoading());
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('Clans').doc(clanId).get();
      if (docSnapshot.exists) {
        Clan clan = Clan.fromJson(docSnapshot.data()!);
        emit(ClanDetailsLoaded(clan));
      } else {
        emit(ClanError('Clan not found'));
      }
    } catch (e) {
      emit(ClanError('Failed to get clan details'));
    }
  }

  // Method to add a member to a clan
  Future<void> addMember(String clanId, String userId) async {
    emit(ClanLoading());
    try {
      await FirebaseFirestore.instance.collection('Clans').doc(clanId).update({
        'members': FieldValue.arrayUnion([userId]),
      });
      await getClanDetails(clanId); // Refresh clan details
    } catch (e) {
      emit(ClanError('Failed to add member'));
    }
  }

  // Method to remove a member from a clan
  Future<void> removeMember(String clanId, String userId) async {
    emit(ClanLoading());
    try {
      await FirebaseFirestore.instance.collection('Clans').doc(clanId).update({
        'members': FieldValue.arrayRemove([userId]),
      });
      await getClanDetails(clanId); // Refresh clan details
    } catch (e) {
      emit(ClanError('Failed to remove member'));
    }
  }

  // Method to accept an invitation (assuming invitations are stored in a separate collection)
  Future<void> acceptInvitation(String invitationId) async {
    emit(ClanLoading());
    try {
      // Logic to accept invitation and add user to clan
      // This is just a placeholder, you need to implement the actual logic
      emit(ClanInvitationAccepted());
    } catch (e) {
      emit(ClanError('Failed to accept invitation'));
    }
  }

  // Method to reject an invitation
  Future<void> rejectInvitation(String invitationId) async {
    emit(ClanLoading());
    try {
      // Logic to reject invitation
      // This is just a placeholder, you need to implement the actual logic
      emit(ClanInvitationRejected());
    } catch (e) {
      emit(ClanError('Failed to reject invitation'));
    }
  }

  // Method to delete a clan
  Future<void> deleteClan(String clanId) async {
    emit(ClanLoading());
    try {
      await FirebaseFirestore.instance.collection('Clans').doc(clanId).delete();
      emit(ClanDeleted());
    } catch (e) {
      emit(ClanError('Failed to delete clan'));
    }
  }
}

// // Clan model class
// class Clan {
//   String id;
//   String name;
//   String description;
//   List<String> members;
//   int maxMembers;
//   String leaderId;
//   List<String> coLeaderIds;
//
//   Clan({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.members,
//     required this.maxMembers,
//     required this.leaderId,
//     required this.coLeaderIds,
//   });
//
//   factory Clan.fromJson(Map<String, dynamic> json) {
//     return Clan(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       members: List<String>.from(json['members']),
//       maxMembers: json['maxMembers'],
//       leaderId: json['leaderId'],
//       coLeaderIds: List<String>.from(json['coLeaderIds']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'members': members,
//       'maxMembers': maxMembers,
//       'leaderId': leaderId,
//       'coLeaderIds': coLeaderIds,
//     };
//   }
// }

// Clan states


// class ClanBloc extends Bloc<ClanEvent, ClanState> {
//   ClanBloc() : super(ClanInitial()) {
//     on<LoadClan>(_onLoadClan);
//     on<InviteMember>(_onInviteMember);
//     on<PromoteMember>(_onPromoteMember);
//     on<RemoveMember>(_onRemoveMember);
//   }
//
//   Future<void> _onLoadClan(LoadClan event, Emitter<ClanState> emit) async {
//     emit(ClanLoading());
//     try {
//       // TODO: Implement API call to load clan data
//       final clan = Clan(
//         id: "123",
//         name: "Sample Clan",
//         description: "A sample clan",
//         members: [],
//         maxMembers: 50,
//         leaderId: "leader123",
//         coLeaderIds: ["co1", "co2"], joinRequests: [], createdAt: DateTime.now(),
//       );
//       emit(ClanLoaded(clan));
//     } catch (e) {
//       emit(ClanError("Failed to load clan"));
//     }
//   }
//
//   Future<void> _onInviteMember(InviteMember event, Emitter<ClanState> emit) async {
//     try {
//       // TODO: Implement invite logic and notification
//       emit(ClanActionSuccess("Invitation sent successfully"));
//     } catch (e) {
//       emit(ClanError("Failed to send invitation"));
//     }
//   }
//
//   Future<void> _onPromoteMember(PromoteMember event, Emitter<ClanState> emit) async {
//     try {
//       // TODO: Implement promotion logic
//       emit(ClanActionSuccess("Member promoted successfully"));
//     } catch (e) {
//       emit(ClanError("Failed to promote member"));
//     }
//   }
//
//   Future<void> _onRemoveMember(RemoveMember event, Emitter<ClanState> emit) async {
//     try {
//       // TODO: Implement remove logic
//       emit(ClanActionSuccess("Member removed successfully"));
//     } catch (e) {
//       emit(ClanError("Failed to remove member"));
//     }
//   }
// }


