import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ClanEvent.dart';
import 'ClanState.dart';

class ClanBloc extends Bloc<ClanEvent, ClanState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ClanBloc() : super(ClanInitial());

  @override
  Stream<ClanState> mapEventToState(ClanEvent event) async* {
    if (event is RequestToJoinClan) {
      await _firestore.collection('clans').doc(event.clanId).update({
        'requests': FieldValue.arrayUnion([event.userId]),
      });
      yield ClanRequestSent();
    } else if (event is AcceptInvite) {
      await _firestore.collection('clans').doc(event.clanId).update({
        'members': FieldValue.arrayUnion([event.userId]),
        'requests': FieldValue.arrayRemove([event.userId]),
      });
      yield ClanInviteAccepted();
    } else if (event is AddMemberToClan) {
      await _firestore.collection('clans').doc(event.clanId).update({
        'members': FieldValue.arrayUnion([event.userId]),
      });
      yield MemberAdded();
    }
  }
}
