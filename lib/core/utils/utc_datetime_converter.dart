import 'package:freezed_annotation/freezed_annotation.dart';

/// السيرفر بيبعت UTC من غير Z، فبنضيفها عشان Dart يفهمها UTC مش local.
class UtcDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const UtcDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null || json.isEmpty) return null;
    final hasZone =
        json.endsWith('Z') || RegExp(r'[+-]\d\d:\d\d$').hasMatch(json);
    return DateTime.parse(hasZone ? json : '${json}Z');
  }

  @override
  String? toJson(DateTime? date) => date?.toUtc().toIso8601String();
}

class UtcDateTimeRequiredConverter implements JsonConverter<DateTime, String> {
  const UtcDateTimeRequiredConverter();

  @override
  DateTime fromJson(String json) {
    final hasZone =
        json.endsWith('Z') || RegExp(r'[+-]\d\d:\d\d$').hasMatch(json);
    return DateTime.parse(hasZone ? json : '${json}Z');
  }

  @override
  String toJson(DateTime date) => date.toUtc().toIso8601String();
}
