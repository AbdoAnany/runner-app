import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/ClanRequest.dart';
import 'ClanEvent.dart';
import 'ClanState.dart';
class ClanBloc extends Bloc<ClanEvent, ClanState> {
  ClanBloc() : super(ClanInitial()) {
    on<LoadClan>(_onLoadClan);
    on<InviteMember>(_onInviteMember);
    on<PromoteMember>(_onPromoteMember);
    on<RemoveMember>(_onRemoveMember);
  }

  Future<void> _onLoadClan(LoadClan event, Emitter<ClanState> emit) async {
    emit(ClanLoading());
    try {
      // TODO: Implement API call to load clan data
      final clan = Clan(
        id: "123",
        name: "Sample Clan",
        description: "A sample clan",
        members: [],
        maxMembers: 50,
        leaderId: "leader123",
        coLeaderIds: ["co1", "co2"], joinRequests: [], createdAt: DateTime.now(),
      );
      emit(ClanLoaded(clan));
    } catch (e) {
      emit(ClanError("Failed to load clan"));
    }
  }

  Future<void> _onInviteMember(InviteMember event, Emitter<ClanState> emit) async {
    try {
      // TODO: Implement invite logic and notification
      emit(ClanActionSuccess("Invitation sent successfully"));
    } catch (e) {
      emit(ClanError("Failed to send invitation"));
    }
  }

  Future<void> _onPromoteMember(PromoteMember event, Emitter<ClanState> emit) async {
    try {
      // TODO: Implement promotion logic
      emit(ClanActionSuccess("Member promoted successfully"));
    } catch (e) {
      emit(ClanError("Failed to promote member"));
    }
  }

  Future<void> _onRemoveMember(RemoveMember event, Emitter<ClanState> emit) async {
    try {
      // TODO: Implement remove logic
      emit(ClanActionSuccess("Member removed successfully"));
    } catch (e) {
      emit(ClanError("Failed to remove member"));
    }
  }
}

// class ClanBloc extends Bloc<ClanEvent, ClanState> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   ClanBloc() : super(ClanInitial());
//
//   @override
//   Stream<ClanState> mapEventToState(ClanEvent event) async* {
//     if (event is RequestToJoinClan) {
//       await _firestore.collection('clans').doc(event.clanId).update({
//         'requests': FieldValue.arrayUnion([event.userId]),
//       });
//       yield ClanRequestSent();
//     } else if (event is AcceptInvite) {
//       await _firestore.collection('clans').doc(event.clanId).update({
//         'members': FieldValue.arrayUnion([event.userId]),
//         'requests': FieldValue.arrayRemove([event.userId]),
//       });
//       yield ClanInviteAccepted();
//     } else if (event is AddMemberToClan) {
//       await _firestore.collection('clans').doc(event.clanId).update({
//         'members': FieldValue.arrayUnion([event.userId]),
//       });
//       yield MemberAdded();
//     }
//   }
// }
