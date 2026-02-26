import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum MoodType { great, good, neutral, sad, awful }

class MoodEntry {
  final String date; // yyyy-mm-dd
  final MoodType mood;

  MoodEntry({required this.date, required this.mood});

  Map<String, dynamic> toJson() => {
        'date': date,
        'mood': mood.name,
      };

  static MoodEntry fromJson(Map<String, dynamic> json) => MoodEntry(
        date: json['date'] as String,
        mood: MoodType.values.firstWhere((m) => m.name == json['mood']),
      );
}

class MoodStorage {
  static const _key = 'mood_entries_v1';

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  static Future<List<MoodEntry>> getAll() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(MoodEntry.fromJson).toList();
  }

  static Future<void> saveToday(MoodType mood) async {
    final sp = await SharedPreferences.getInstance();
    final all = await getAll();
    final today = _todayKey();

    // استبدال تسجيل اليوم إذا موجود
    final filtered = all.where((e) => e.date != today).toList();
    filtered.add(MoodEntry(date: today, mood: mood));

    // نخلي آخر 30 يوم فقط
    filtered.sort((a, b) => a.date.compareTo(b.date));
    final trimmed =
        filtered.length > 30 ? filtered.sublist(filtered.length - 30) : filtered;

    await sp.setString(
      _key,
      jsonEncode(trimmed.map((e) => e.toJson()).toList()),
    );
  }

  // إحصائيات آخر 7 أيام
  static Future<Map<MoodType, int>> last7DaysCounts() async {
    final all = await getAll();
    final now = DateTime.now();
    final from = now.subtract(const Duration(days: 6));

    bool inRange(String date) {
      final p = date.split('-');
      final d = DateTime(int.parse(p[0]), int.parse(p[1]), int.parse(p[2]));
      final start = DateTime(from.year, from.month, from.day);
      final end = DateTime(now.year, now.month, now.day);
      return !d.isBefore(start) && !d.isAfter(end);
    }

    final map = {
      MoodType.great: 0,
      MoodType.good: 0,
      MoodType.neutral: 0,
      MoodType.sad: 0,
      MoodType.awful: 0,
    };

    for (final e in all.where((e) => inRange(e.date))) {
      map[e.mood] = (map[e.mood] ?? 0) + 1;
    }
    return map;
  }

  static int percent(int part, int total) {
    if (total <= 0) return 0;
    return ((part / total) * 100).round();
  }
}