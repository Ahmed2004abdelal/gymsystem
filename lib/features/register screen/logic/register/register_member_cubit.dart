// // import 'package:bloc/bloc.dart';
// // import 'package:gymsystem/core/networking/api_result.dart';
// // import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
// // import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
// // import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// // import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
// // import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';
// // import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';

// // class RegisterMemberCubit extends Cubit<RegisterMemberState> {
// //   final RegisterRepo _repo;
// //   RegisterMemberCubit(this._repo) : super(const RegisterMemberState());

// //   // ───────────────────────── Lookups (GET) ─────────────────────────

// //   /// بيجيب الباقات والمدربين والأنشطة حسب الجنس.
// //   /// بتتنادى تلقائياً بعد نجاح تسجيل العضو (createMember) وعند "إعادة المحاولة".
// //   Future<void> loadLookups([int? gender]) async {
// //     final g = gender ?? state.gender;
// //     emit(
// //       state.copyWith(
// //         gender: g,
// //         selectedPackage: null,
// //         selectedTrainer: null,
// //         lookupsError: null,
// //       ),
// //     );
// //     // await Future.wait([_loadPackages(g), _loadTrainers(g), _loadActivities(g)]);
// //     await Future.wait([_loadPackages(g), _loadTrainers(g)]);
// //   }

// //   /// تغيير الجنس قبل تسجيل العضو بس. التحميل بيحصل بعد نجاح التسجيل.
// //   void changeGender(int gender) {
// //     if (state.isMemberCreated || gender == state.gender) return;
// //     emit(state.copyWith(gender: gender));
// //   }

// //   Future<void> _loadPackages(int gender) async {
// //     emit(state.copyWith(packagesStatus: RegisterStatus.loading));
// //     final result = await _repo.getAvailablePackages(gender);
// //     if (isClosed || gender != state.gender) return; // رد قديم
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(packagesStatus: RegisterStatus.success, packages: data),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           packagesStatus: RegisterStatus.failure,
// //           lookupsError: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _loadTrainers(int gender) async {
// //     emit(state.copyWith(trainersStatus: RegisterStatus.loading));
// //     final result = await _repo.getAvailableTrainers(gender);
// //     if (isClosed || gender != state.gender) return;
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(trainersStatus: RegisterStatus.success, trainers: data),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           trainersStatus: RegisterStatus.failure,
// //           lookupsError: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   // Future<void> _loadActivities(int gender) async {
// //   //   emit(state.copyWith(activitiesStatus: RegisterStatus.loading));
// //   //   final result = await _repo.getAvailableActivities(gender);
// //   //   if (isClosed || gender != state.gender) return;
// //   //   result.when(
// //   //     success: (data) => emit(
// //   //       state.copyWith(
// //   //         activitiesStatus: RegisterStatus.success,
// //   //         activities: data,
// //   //       ),
// //   //     ),
// //   //     failure: (error) => emit(
// //   //       state.copyWith(
// //   //         activitiesStatus: RegisterStatus.failure,
// //   //         lookupsError: error.apiErrorModel.getAllErrorMessages(),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// //   /// للتجديد: بيحمّل الباقات والمدربين ويختار باقة ومدرب العضو الحاليين.
// //   Future<void> loadForRenewal({
// //     required int gender,
// //     String? currentPackage,
// //     String? currentTrainer,
// //   }) async {
// //     await loadLookups(gender);
// //     if (isClosed) return;

// //     PackageModel? pkg;
// //     for (final p in state.packages) {
// //       if (p.name == currentPackage) pkg = p; // عدّل name لو الحقل مختلف
// //     }
// //     TrainersModel? trainer;
// //     for (final t in state.trainers) {
// //       if (t.name == currentTrainer) trainer = t;
// //     }
// //     emit(
// //       state.copyWith(
// //         selectedPackage:
// //             pkg ?? (state.packages.isNotEmpty ? state.packages.first : null),
// //         selectedTrainer: trainer,
// //       ),
// //     );
// //   }

// //   // ───────────────────────── Selections ─────────────────────────

// //   void selectPackage(PackageModel package) =>
// //       emit(state.copyWith(selectedPackage: package));

// //   /// null = بدون مدرب
// //   void selectTrainer(TrainersModel? trainer) =>
// //       emit(state.copyWith(selectedTrainer: trainer));

// //   // ───────────────────────── Step 1: create member ─────────────────────────

// //   Future<void> createMember(CreateMemberModel model) async {
// //     if (state.createMemberStatus == RegisterStatus.loading ||
// //         state.isMemberCreated) {
// //       return;
// //     }
// //     emit(
// //       state.copyWith(
// //         createMemberStatus: RegisterStatus.loading,
// //         errorMessage: null,
// //       ),
// //     );
// //     final result = await _repo.createNewMember(model);
// //     if (isClosed) return;
// //     result.when(
// //       success: (data) {
// //         emit(
// //           state.copyWith(
// //             createMemberStatus: RegisterStatus.success,
// //             createdMember: data,
// //           ),
// //         );
// //         loadLookups(); // GET: الباقات + المدربين + الأنشطة بعد نجاح التسجيل
// //       },
// //       failure: (error) => emit(
// //         state.copyWith(
// //           createMemberStatus: RegisterStatus.failure,
// //           errorMessage: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   // ───────────────────────── Step 2: subscription ─────────────────────────

// //   /// لو فشل الاشتراك العضو يفضل متسجل، فالمحاولة التانية ما بتنشئش عضو جديد.
// //   Future<void> createSubscription() async {
// //     final member = state.createdMember;
// //     if (member == null || state.isSubscribed) return;
// //     await _submitSubscription(member.id);
// //   }

// //   /// تجديد اشتراك لعضو موجود (من غير createMember).
// //   Future<void> renewSubscription(int memberId) => _submitSubscription(memberId);

// //   Future<void> _submitSubscription(int memberId) async {
// //     final package = state.selectedPackage;
// //     if (package == null || state.subscriptionStatus == RegisterStatus.loading) {
// //       return;
// //     }
// //     emit(
// //       state.copyWith(
// //         subscriptionStatus: RegisterStatus.loading,
// //         errorMessage: null,
// //       ),
// //     );
// //     final result = await _repo.createNewSubscription(
// //       GymSubscriptionModel(
// //         memberId: memberId,
// //         packageId: package.id,
// //         trainerId: state.selectedTrainer?.id,
// //       ),
// //     );
// //     if (isClosed) return;
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(
// //           subscriptionStatus: RegisterStatus.success,
// //           subscription: data,
// //         ),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           subscriptionStatus: RegisterStatus.failure,
// //           errorMessage: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:bloc/bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
// import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';
// import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';

// class RegisterMemberCubit extends Cubit<RegisterMemberState> {
//   final RegisterRepo _repo;
//   RegisterMemberCubit(this._repo) : super(const RegisterMemberState());

//   // ───────────────────────── Lookups (GET) ─────────────────────────

//   /// بيجيب الباقات والمدربين والأنشطة حسب الجنس.
//   /// بتتنادى تلقائياً بعد نجاح تسجيل العضو (createMember) وعند "إعادة المحاولة".
//   Future<void> loadLookups([int? gender]) async {
//     final g = gender ?? state.gender;
//     emit(
//       state.copyWith(
//         gender: g,
//         selectedPackage: null,
//         selectedTrainer: null,
//         selectedActivity: null,
//         lookupsError: null,
//       ),
//     );
//     await Future.wait([_loadPackages(g), _loadTrainers(g), _loadActivities(g)]);
//   }

//   /// تغيير الجنس قبل تسجيل العضو بس. التحميل بيحصل بعد نجاح التسجيل.
//   void changeGender(int gender) {
//     if (state.isMemberCreated || gender == state.gender) return;
//     emit(state.copyWith(gender: gender));
//   }

//   Future<void> _loadPackages(int gender) async {
//     emit(state.copyWith(packagesStatus: RegisterStatus.loading));
//     final result = await _repo.getAvailablePackages(gender);
//     if (isClosed || gender != state.gender) return; // رد قديم
//     result.when(
//       success: (data) => emit(
//         state.copyWith(packagesStatus: RegisterStatus.success, packages: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           packagesStatus: RegisterStatus.failure,
//           lookupsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> _loadTrainers(int gender) async {
//     emit(state.copyWith(trainersStatus: RegisterStatus.loading));
//     final result = await _repo.getAvailableTrainers(gender);
//     if (isClosed || gender != state.gender) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(trainersStatus: RegisterStatus.success, trainers: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           trainersStatus: RegisterStatus.failure,
//           lookupsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> _loadActivities(int gender) async {
//     emit(state.copyWith(activitiesStatus: RegisterStatus.loading));
//     final result = await _repo.getAvailableActivities(gender);
//     if (isClosed || gender != state.gender) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           activitiesStatus: RegisterStatus.success,
//           activities: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           activitiesStatus: RegisterStatus.failure,
//           lookupsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// للتجديد: بيحمّل الباقات والمدربين ويختار باقة ومدرب العضو الحاليين.
//   Future<void> loadForRenewal({
//     required int gender,
//     String? currentPackage,
//     String? currentTrainer,
//   }) async {
//     await loadLookups(gender);
//     if (isClosed) return;

//     PackageModel? pkg;
//     for (final p in state.packages) {
//       if (p.name == currentPackage) pkg = p; // عدّل name لو الحقل مختلف
//     }
//     TrainersModel? trainer;
//     for (final t in state.trainers) {
//       if (t.name == currentTrainer) trainer = t;
//     }
//     emit(
//       state.copyWith(
//         selectedPackage:
//             pkg ?? (state.packages.isNotEmpty ? state.packages.first : null),
//         selectedTrainer: trainer,
//       ),
//     );
//   }

//   // ───────────────────────── Selections ─────────────────────────

//   /// الضغط على الباقة المختارة تاني بيلغي اختيارها (الباقة اختيارية).
//   /// بعد نجاح اشتراك الجيم الاختيار بيتقفل.
//   void selectPackage(PackageModel package) {
//     if (state.isGymDone) return;
//     final same = state.selectedPackage?.id == package.id;
//     emit(
//       state.copyWith(
//         selectedPackage: same ? null : package,
//         // من غير باقة مفيش مدرب
//         selectedTrainer: same ? null : state.selectedTrainer,
//       ),
//     );
//   }

//   /// null = بدون مدرب
//   void selectTrainer(TrainersModel? trainer) {
//     if (state.isGymDone) return;
//     emit(state.copyWith(selectedTrainer: trainer));
//   }

//   /// الضغط على النشاط المختار تاني بيلغي اختياره (النشاط اختياري).
//   void selectActivity(ActivitiesModel activity) {
//     if (state.isActivityDone) return;
//     final same = state.selectedActivity?.id == activity.id;
//     emit(state.copyWith(selectedActivity: same ? null : activity));
//   }

//   // ───────────────────────── Step 1: create member ─────────────────────────

//   Future<void> createMember(CreateMemberModel model) async {
//     if (state.createMemberStatus == RegisterStatus.loading ||
//         state.isMemberCreated) {
//       return;
//     }
//     emit(
//       state.copyWith(
//         createMemberStatus: RegisterStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.createNewMember(model);
//     if (isClosed) return;
//     result.when(
//       success: (data) {
//         emit(
//           state.copyWith(
//             createMemberStatus: RegisterStatus.success,
//             createdMember: data,
//           ),
//         );
//         loadLookups(); // GET: الباقات + المدربين + الأنشطة بعد نجاح التسجيل
//       },
//       failure: (error) => emit(
//         state.copyWith(
//           createMemberStatus: RegisterStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── Step 2: subscriptions ─────────────────────────

//   /// بينفّذ اللي مختاره المستخدم بس:
//   ///  • باقة فقط      → اشتراك جيم
//   ///  • نشاط فقط      → اشتراك نشاط
//   ///  • الاتنين       → الاتنين مع بعض
//   /// لو واحد فشل والتاني نجح، إعادة المحاولة بتنفّذ اللي فشل بس
//   /// (والعضو يفضل متسجل فمفيش إنشاء عضو جديد).
//   Future<void> createSubscription() async {
//     final member = state.createdMember;
//     if (member == null) return;
//     await _submit(member.id);
//   }

//   /// تجديد اشتراك لعضو موجود (من غير createMember).
//   Future<void> renewSubscription(int memberId) => _submit(memberId);

//   Future<void> _submit(int memberId) async {
//     if (state.isSubmitting) return;
//     final needGym = state.selectedPackage != null && !state.isGymDone;
//     final needActivity =
//         state.selectedActivity != null && !state.isActivityDone;
//     if (!needGym && !needActivity) return;

//     await Future.wait([
//       if (needGym) _subscribeGym(memberId),
//       if (needActivity) _subscribeActivity(memberId),
//     ]);
//   }

//   Future<void> _subscribeGym(int memberId) async {
//     final package = state.selectedPackage!;
//     final trainerId = state.selectedTrainer?.id;
//     emit(
//       state.copyWith(
//         subscriptionStatus: RegisterStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.createNewSubscription(
//       GymSubscriptionModel(
//         memberId: memberId,
//         packageId: package.id,
//         trainerId: trainerId,
//       ),
//     );
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           subscriptionStatus: RegisterStatus.success,
//           subscription: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           subscriptionStatus: RegisterStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> _subscribeActivity(int memberId) async {
//     final activity = state.selectedActivity!;
//     emit(
//       state.copyWith(
//         activitySubStatus: RegisterStatus.loading,
//         activityError: null,
//       ),
//     );
//     final result = await _repo.createActivitySubscription(
//       MakeActivitySubRequestModel(memberId: memberId, activityId: activity.id),
//     );
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           activitySubStatus: RegisterStatus.success,
//           activitySubscription: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           activitySubStatus: RegisterStatus.failure,
//           activityError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
// import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';
// import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';

// class RegisterMemberCubit extends Cubit<RegisterMemberState> {
//   final RegisterRepo _repo;
//   RegisterMemberCubit(this._repo) : super(const RegisterMemberState());

//   // ───────────────────────── Lookups (GET) ─────────────────────────

//   /// بيجيب الباقات والمدربين والأنشطة حسب الجنس.
//   /// بتتنادى تلقائياً بعد نجاح تسجيل العضو (createMember) وعند "إعادة المحاولة".
//   Future<void> loadLookups([int? gender]) async {
//     final g = gender ?? state.gender;
//     emit(
//       state.copyWith(
//         gender: g,
//         selectedPackage: null,
//         selectedTrainer: null,
//         lookupsError: null,
//       ),
//     );
//     // await Future.wait([_loadPackages(g), _loadTrainers(g), _loadActivities(g)]);
//     await Future.wait([_loadPackages(g), _loadTrainers(g)]);
//   }

//   /// تغيير الجنس قبل تسجيل العضو بس. التحميل بيحصل بعد نجاح التسجيل.
//   void changeGender(int gender) {
//     if (state.isMemberCreated || gender == state.gender) return;
//     emit(state.copyWith(gender: gender));
//   }

//   Future<void> _loadPackages(int gender) async {
//     emit(state.copyWith(packagesStatus: RegisterStatus.loading));
//     final result = await _repo.getAvailablePackages(gender);
//     if (isClosed || gender != state.gender) return; // رد قديم
//     result.when(
//       success: (data) => emit(
//         state.copyWith(packagesStatus: RegisterStatus.success, packages: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           packagesStatus: RegisterStatus.failure,
//           lookupsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> _loadTrainers(int gender) async {
//     emit(state.copyWith(trainersStatus: RegisterStatus.loading));
//     final result = await _repo.getAvailableTrainers(gender);
//     if (isClosed || gender != state.gender) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(trainersStatus: RegisterStatus.success, trainers: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           trainersStatus: RegisterStatus.failure,
//           lookupsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   // Future<void> _loadActivities(int gender) async {
//   //   emit(state.copyWith(activitiesStatus: RegisterStatus.loading));
//   //   final result = await _repo.getAvailableActivities(gender);
//   //   if (isClosed || gender != state.gender) return;
//   //   result.when(
//   //     success: (data) => emit(
//   //       state.copyWith(
//   //         activitiesStatus: RegisterStatus.success,
//   //         activities: data,
//   //       ),
//   //     ),
//   //     failure: (error) => emit(
//   //       state.copyWith(
//   //         activitiesStatus: RegisterStatus.failure,
//   //         lookupsError: error.apiErrorModel.getAllErrorMessages(),
//   //       ),
//   //     ),
//   //   );
//   // }

//   /// للتجديد: بيحمّل الباقات والمدربين ويختار باقة ومدرب العضو الحاليين.
//   Future<void> loadForRenewal({
//     required int gender,
//     String? currentPackage,
//     String? currentTrainer,
//   }) async {
//     await loadLookups(gender);
//     if (isClosed) return;

//     PackageModel? pkg;
//     for (final p in state.packages) {
//       if (p.name == currentPackage) pkg = p; // عدّل name لو الحقل مختلف
//     }
//     TrainersModel? trainer;
//     for (final t in state.trainers) {
//       if (t.name == currentTrainer) trainer = t;
//     }
//     emit(
//       state.copyWith(
//         selectedPackage:
//             pkg ?? (state.packages.isNotEmpty ? state.packages.first : null),
//         selectedTrainer: trainer,
//       ),
//     );
//   }

//   // ───────────────────────── Selections ─────────────────────────

//   void selectPackage(PackageModel package) =>
//       emit(state.copyWith(selectedPackage: package));

//   /// null = بدون مدرب
//   void selectTrainer(TrainersModel? trainer) =>
//       emit(state.copyWith(selectedTrainer: trainer));

//   // ───────────────────────── Step 1: create member ─────────────────────────

//   Future<void> createMember(CreateMemberModel model) async {
//     if (state.createMemberStatus == RegisterStatus.loading ||
//         state.isMemberCreated) {
//       return;
//     }
//     emit(
//       state.copyWith(
//         createMemberStatus: RegisterStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.createNewMember(model);
//     if (isClosed) return;
//     result.when(
//       success: (data) {
//         emit(
//           state.copyWith(
//             createMemberStatus: RegisterStatus.success,
//             createdMember: data,
//           ),
//         );
//         loadLookups(); // GET: الباقات + المدربين + الأنشطة بعد نجاح التسجيل
//       },
//       failure: (error) => emit(
//         state.copyWith(
//           createMemberStatus: RegisterStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── Step 2: subscription ─────────────────────────

//   /// لو فشل الاشتراك العضو يفضل متسجل، فالمحاولة التانية ما بتنشئش عضو جديد.
//   Future<void> createSubscription() async {
//     final member = state.createdMember;
//     if (member == null || state.isSubscribed) return;
//     await _submitSubscription(member.id);
//   }

//   /// تجديد اشتراك لعضو موجود (من غير createMember).
//   Future<void> renewSubscription(int memberId) => _submitSubscription(memberId);

//   Future<void> _submitSubscription(int memberId) async {
//     final package = state.selectedPackage;
//     if (package == null || state.subscriptionStatus == RegisterStatus.loading) {
//       return;
//     }
//     emit(
//       state.copyWith(
//         subscriptionStatus: RegisterStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.createNewSubscription(
//       GymSubscriptionModel(
//         memberId: memberId,
//         packageId: package.id,
//         trainerId: state.selectedTrainer?.id,
//       ),
//     );
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           subscriptionStatus: RegisterStatus.success,
//           subscription: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           subscriptionStatus: RegisterStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';

class RegisterMemberCubit extends Cubit<RegisterMemberState> {
  final RegisterRepo _repo;
  RegisterMemberCubit(this._repo) : super(const RegisterMemberState());

  // ───────────────────────── Lookups (GET) ─────────────────────────

  /// بيجيب الباقات والمدربين والأنشطة حسب الجنس.
  /// بتتنادى تلقائياً بعد نجاح تسجيل العضو (createMember) وعند "إعادة المحاولة".
  Future<void> loadLookups([int? gender]) async {
    final g = gender ?? state.gender;
    emit(
      state.copyWith(
        gender: g,
        selectedPackage: null,
        selectedTrainer: null,
        selectedActivity: null,
        lookupsError: null,
      ),
    );
    await Future.wait([_loadPackages(g), _loadTrainers(g), _loadActivities(g)]);
  }

  /// تغيير الجنس قبل تسجيل العضو بس. التحميل بيحصل بعد نجاح التسجيل.
  void changeGender(int gender) {
    if (state.isMemberCreated || gender == state.gender) return;
    emit(state.copyWith(gender: gender));
  }

  Future<void> _loadPackages(int gender) async {
    emit(state.copyWith(packagesStatus: RegisterStatus.loading));
    final result = await _repo.getAvailablePackages(gender);
    if (isClosed || gender != state.gender) return; // رد قديم
    result.when(
      success: (data) => emit(
        state.copyWith(packagesStatus: RegisterStatus.success, packages: data),
      ),
      failure: (error) => emit(
        state.copyWith(
          packagesStatus: RegisterStatus.failure,
          lookupsError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> _loadTrainers(int gender) async {
    emit(state.copyWith(trainersStatus: RegisterStatus.loading));
    final result = await _repo.getAvailableTrainers(gender);
    if (isClosed || gender != state.gender) return;
    result.when(
      success: (data) => emit(
        state.copyWith(trainersStatus: RegisterStatus.success, trainers: data),
      ),
      failure: (error) => emit(
        state.copyWith(
          trainersStatus: RegisterStatus.failure,
          lookupsError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> _loadActivities(int gender) async {
    emit(state.copyWith(activitiesStatus: RegisterStatus.loading));
    final result = await _repo.getAvailableActivities(gender);
    if (isClosed || gender != state.gender) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          activitiesStatus: RegisterStatus.success,
          activities: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          activitiesStatus: RegisterStatus.failure,
          lookupsError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// للتجديد: بيحمّل الباقات والمدربين ويختار باقة ومدرب العضو الحاليين.
  Future<void> loadForRenewal({
    required int gender,
    String? currentPackage,
    String? currentTrainer,
  }) async {
    await loadLookups(gender);
    if (isClosed) return;

    PackageModel? pkg;
    for (final p in state.packages) {
      if (p.name == currentPackage) pkg = p; // عدّل name لو الحقل مختلف
    }
    TrainersModel? trainer;
    for (final t in state.trainers) {
      if (t.name == currentTrainer) trainer = t;
    }
    emit(
      state.copyWith(
        selectedPackage:
            pkg ?? (state.packages.isNotEmpty ? state.packages.first : null),
        selectedTrainer: trainer,
      ),
    );
  }

  // ───────────────────────── Selections ─────────────────────────

  /// الضغط على الباقة المختارة تاني بيلغي اختيارها (الباقة اختيارية).
  /// بعد نجاح اشتراك الجيم الاختيار بيتقفل.
  void selectPackage(PackageModel package) {
    if (state.isGymDone) return;
    final same = state.selectedPackage?.id == package.id;
    emit(
      state.copyWith(
        selectedPackage: same ? null : package,
        // من غير باقة مفيش مدرب
        selectedTrainer: same ? null : state.selectedTrainer,
      ),
    );
  }

  /// null = بدون مدرب
  void selectTrainer(TrainersModel? trainer) {
    if (state.isGymDone) return;
    emit(state.copyWith(selectedTrainer: trainer));
  }

  /// الضغط على النشاط المختار تاني بيلغي اختياره (النشاط اختياري).
  void selectActivity(ActivitiesModel activity) {
    if (state.isActivityDone) return;
    final same = state.selectedActivity?.id == activity.id;
    emit(state.copyWith(selectedActivity: same ? null : activity));
  }

  // ───────────────────────── Step 1: create member ─────────────────────────

  Future<void> createMember(CreateMemberModel model) async {
    if (state.createMemberStatus == RegisterStatus.loading ||
        state.isMemberCreated) {
      return;
    }
    emit(
      state.copyWith(
        createMemberStatus: RegisterStatus.loading,
        errorMessage: null,
      ),
    );
    final result = await _repo.createNewMember(model);
    if (isClosed) return;
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            createMemberStatus: RegisterStatus.success,
            createdMember: data,
          ),
        );
        loadLookups(); // GET: الباقات + المدربين + الأنشطة بعد نجاح التسجيل
      },
      failure: (error) => emit(
        state.copyWith(
          createMemberStatus: RegisterStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  // ───────────────────────── Step 2: subscriptions ─────────────────────────

  /// بينفّذ اللي مختاره المستخدم بس:
  ///  • باقة فقط      → اشتراك جيم
  ///  • نشاط فقط      → اشتراك نشاط
  ///  • الاتنين       → الاتنين مع بعض
  /// لو واحد فشل والتاني نجح، إعادة المحاولة بتنفّذ اللي فشل بس
  /// (والعضو يفضل متسجل فمفيش إنشاء عضو جديد).
  Future<void> createSubscription() async {
    final member = state.createdMember;
    if (member == null) return;
    await _submit(member.id);
  }

  /// تجديد اشتراك لعضو موجود (من غير createMember).
  Future<void> renewSubscription(int memberId) => _submit(memberId);

  Future<void> _submit(int memberId) async {
    if (state.isSubmitting) return;
    final needGym = state.selectedPackage != null && !state.isGymDone;
    final needActivity =
        state.selectedActivity != null && !state.isActivityDone;
    if (!needGym && !needActivity) return;

    await Future.wait([
      if (needGym) _subscribeGym(memberId),
      if (needActivity) _subscribeActivity(memberId),
    ]);
  }

  Future<void> _subscribeGym(int memberId) async {
    final package = state.selectedPackage!;
    final trainerId = state.selectedTrainer?.id;
    emit(
      state.copyWith(
        subscriptionStatus: RegisterStatus.loading,
        errorMessage: null,
      ),
    );
    final result = await _repo.createNewSubscription(
      GymSubscriptionModel(
        memberId: memberId,
        packageId: package.id,
        trainerId: trainerId,
      ),
    );
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          subscriptionStatus: RegisterStatus.success,
          subscription: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          subscriptionStatus: RegisterStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> _subscribeActivity(int memberId) async {
    final activity = state.selectedActivity!;
    emit(
      state.copyWith(
        activitySubStatus: RegisterStatus.loading,
        activityError: null,
      ),
    );
    final result = await _repo.createActivitySubscription(
      MakeActivitySubRequestModel(memberId: memberId, activityId: activity.id),
    );
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          activitySubStatus: RegisterStatus.success,
          activitySubscription: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          activitySubStatus: RegisterStatus.failure,
          activityError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }
}
