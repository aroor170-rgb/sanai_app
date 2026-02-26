import 'package:flutter/material.dart';
import '../utils/mood_storage.dart';

class MoodBar extends StatelessWidget {
  final Map<MoodType, int> counts;
  final VoidCallback? onOpen;

  const MoodBar({
    super.key,
    required this.counts,
    this.onOpen,
  });

  // نفس درجات صفحة Check-in
  static const Color card = Color(0xFFF2F2F2);
  static const Color circleOff = Color(0xFFD9D9D9);
  static const Color iconOff = Color(0xFF8A8A8A);
  static const Color textMain = Color(0xFF222222);

  static const Color moodActive = Color(0xFF8BC6D7); // نفس الأزرق
  static const Color barBg = Color(0xFFE6E6E6); // خلفية شريط خفيفة

  @override
  Widget build(BuildContext context) {
    final total = counts.values.fold<int>(0, (a, b) => a + b);

    final pGreat = MoodStorage.percent(counts[MoodType.great] ?? 0, total);
    final pGood = MoodStorage.percent(counts[MoodType.good] ?? 0, total);
    final pNeutral = MoodStorage.percent(counts[MoodType.neutral] ?? 0, total);
    final pSad = MoodStorage.percent(counts[MoodType.sad] ?? 0, total);
    final pAwful = MoodStorage.percent(counts[MoodType.awful] ?? 0, total);

    int flexSafe(int p) => p == 0 ? 1 : p;

    return GestureDetector(
      onTap: onOpen,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mood Bar',
              style: TextStyle(
                color: textMain,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),

            // صف الدوائر + النسبة تحتها (نفس ستايل Check-in)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MoodBubble(icon: Icons.sentiment_very_satisfied, percent: pGreat),
                _MoodBubble(icon: Icons.sentiment_satisfied, percent: pGood),
                _MoodBubble(icon: Icons.sentiment_neutral, percent: pNeutral),
                _MoodBubble(icon: Icons.sentiment_dissatisfied, percent: pSad),
                _MoodBubble(icon: Icons.sentiment_very_dissatisfied, percent: pAwful),
              ],
            ),

            const SizedBox(height: 16),

            // الشريط (بنفس ألوان الصفحة: رمادي + الأزرق للي فيه نسبة)
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Row(
                children: [
                  Expanded(
                    flex: flexSafe(pGreat),
                    child: Container(height: 18, color: pGreat == 0 ? barBg : moodActive.withOpacity(0.25)),
                  ),
                  Expanded(
                    flex: flexSafe(pGood),
                    child: Container(height: 18, color: pGood == 0 ? barBg : moodActive.withOpacity(0.35)),
                  ),
                  Expanded(
                    flex: flexSafe(pNeutral),
                    child: Container(height: 18, color: pNeutral == 0 ? barBg : moodActive.withOpacity(0.45)),
                  ),
                  Expanded(
                    flex: flexSafe(pSad),
                    child: Container(height: 18, color: pSad == 0 ? barBg : moodActive.withOpacity(0.55)),
                  ),
                  Expanded(
                    flex: flexSafe(pAwful),
                    child: Container(height: 18, color: pAwful == 0 ? barBg : moodActive.withOpacity(0.65)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),
            const Text(
              'Last 7 days',
              style: TextStyle(color: iconOff, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodBubble extends StatelessWidget {
  final IconData icon;
  final int percent;

  const _MoodBubble({required this.icon, required this.percent});

  static const Color circleOff = Color(0xFFD9D9D9);
  static const Color iconOff = Color(0xFF8A8A8A);
  static const Color moodActive = Color(0xFF8BC6D7);

  @override
  Widget build(BuildContext context) {
    final active = percent > 0;
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: active ? moodActive : circleOff,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 26,
            color: active ? Colors.black54 : iconOff,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: active ? moodActive.withOpacity(0.25) : circleOff,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '$percent%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: active ? Colors.black54 : iconOff,
            ),
          ),
        ),
      ],
    );
  }
}