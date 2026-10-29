import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/home/data/models/member_checkin_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';

part 'reception_state.freezed.dart';

@freezed
abstract class ReceptionState with _$ReceptionState {
  const factory ReceptionState({
    @Default(ReceptionStatus.initial) ReceptionStatus memberCheckinStatus,
    @Default(ReceptionStatus.initial) ReceptionStatus memberLogedinStatus,
    @Default(ReceptionStatus.initial) ReceptionStatus memberShowCardStatus,
    @Default(ReceptionStatus.initial) ReceptionStatus liveAttendanceStatus,
    @Default(ReceptionStatus.initial) ReceptionStatus sessionsCheckInStatus,
    @Default(ReceptionStatus.initial) ReceptionStatus renewSubscriptionStatus,
    @Default(ReceptionStatus.initial)
    ReceptionStatus firstFiveAttendancesStatus,
    @Default([]) List<MemberLogedinResponseModel> fiveAttendancesData,
    MemberCheckintModel? memberCheckinData,
    List<MemberLogedinResponseModel>? liveAttendanceData,
    MemberShowCardModel? memberShowCardData,
    String? errorMessage,
  }) = _ReceptionState;
}

enum ReceptionStatus { initial, loading, success, failure }
