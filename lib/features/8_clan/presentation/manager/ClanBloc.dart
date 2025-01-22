import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:runner_app/features/6_profile/presentation/pages/profile_screen.dart';


import '../../../../core/const/const.dart';
import '../../data/models/ClanRequest.dart';
import 'ClanState.dart';


class ClanBloc extends Cubit<ClanState> {
  ClanBloc() : super(ClanInitial());



  void createClan() async {
    emit(ClanLoading());
    Clan clan = Clan(
      id: "123",
      name: "Sample Clan",
      description: "A sample clan",
      members: [
        AppData.currentUserDate.userId,
        AppData.currentUserDate.userId,
        AppData.currentUserDate.userId

      ],
      maxMembers: 50,
      leaderId:             AppData.currentUserDate.userId,
      coLeaderIds: [AppData.currentUserDate.userId, AppData.currentUserDate.userId],
    );
    try {
   final docRef =   await FirebaseFirestore.instance.collection('Clans').add(clan.toJson());

   clan.id = docRef.id;
   docRef.update(clan.toJson());
   // final docRef =   await FirebaseFirestore.instance.collection('Clans').add(clan.toJson());

   print(clan.id);
      await  getClan();
      // emit(ClanCreated(clan));
    } catch (e) {
      emit(ClanError('Failed to create clan'));
    }
  }

  Future<void> getClan() async {
    emit(ClanLoading());
    List<Clan> clans=[];
    try {
    final querySnapshot =  await FirebaseFirestore.instance.collection('Clans').get();
    querySnapshot.docs.forEach((doc) {
      print(doc.data());
      Clan clan = Clan.fromJson(doc.data());
      clans.add(clan);
    });
      emit(ClanLoaded(clans));
    } catch (e) {
      emit(ClanError('Failed to create clan'));
    }
  }


}

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


