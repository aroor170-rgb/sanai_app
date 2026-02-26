import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/mood_storage.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  // 0..4
  int selectedMood = 2;

  bool showActivities = true;
  final Set<String> selectedActivities = {};

  final List<_Item> activities = const [
    _Item('Games', Icons.sports_esports),
    _Item('Podcast', Icons.podcasts),
    _Item('Daily\nMotivation', Icons.lightbulb),
    _Item('Breathing\nExercises', Icons.air),
  ];

  // ===== Colors (مطابقة للصورة) =====
  static const Color bg = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFF2F2F2);
  static const Color circleOff = Color(0xFFD9D9D9);
  static const Color iconOff = Color(0xFF8A8A8A);
  static const Color textMain = Color(0xFF222222);

  static const Color moodActive = Color(0xFF8BC6D7); // الأزرق الفاتح (المحدد)
  static const Color doneButton = Color(0xFFC9F0F9); // زر Done

  @override
  Widget build(BuildContext context) {
    final titleDate = _formatToday();
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.fromLTRB(14, 8, 14, 150 + bottomInset),
              children: [
                _header(titleDate),
                const SizedBox(height: 14),

                // Card 1: Mood
                _card(
                  child: Column(
                    children: [
                      const Text(
                        'How was your day?',
                        style: TextStyle(
                          color: textMain,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _moodRow(),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Card 2: Activities (Collapsible)
                _card(
                  child: Column(
                    children: [
                      _sectionHeader(
                        title: 'Activities',
                        expanded: showActivities,
                        onToggle: () =>
                            setState(() => showActivities = !showActivities),
                      ),
                      if (showActivities)
                        _gridActivities(
                          items: activities,
                          selected: selectedActivities,
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Done Button fixed bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: doneButton,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _onDone,
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Header (مثل الصورة: رجوع + تاريخ + إعدادات) =====
  Widget _header(String titleDate) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        Expanded(
          child: Center(
            child: Text(
              titleDate,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ],
    );
  }

  // ===== Card style =====
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }

  // ===== Section header with arrow =====
  Widget _sectionHeader({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onToggle,
          icon: Icon(
            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // ===== Mood row (دوائر رمادي + المحدد أزرق) =====
  Widget _moodRow() {
    final moodIcons = [
      Icons.sentiment_very_satisfied,
      Icons.sentiment_satisfied,
      Icons.sentiment_neutral,
      Icons.sentiment_dissatisfied,
      Icons.sentiment_very_dissatisfied,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (i) {
        final active = selectedMood == i;
        return GestureDetector(
          onTap: () => setState(() => selectedMood = i),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: active ? moodActive : circleOff,
              shape: BoxShape.circle,
            ),
            child: Icon(
              moodIcons[i],
              size: 30,
              color: active ? Colors.black54 : iconOff,
            ),
          ),
        );
      }),
    );
  }

  // ===== Activities grid (مطابق للصورة) =====
  Widget _gridActivities({
    required List<_Item> items,
    required Set<String> selected,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 6),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isOn = selected.contains(item.label);

        return GestureDetector(
          onTap: () async {
            // تحديد خفيف (اختياري)
            setState(() {
              if (isOn) {
                selected.remove(item.label);
              } else {
                selected.add(item.label);
              }
            });

            // فتح خارج التطبيق (غيري الروابط براحتك)
            if (item.label == 'Games') {
              await _openUrl(
                  'https://www.google.com/search?q=relaxing+games');
            } else if (item.label == 'Podcast') {
              await _openUrl(
                  'https://www.youtube.com/results?search_query=mental+health+podcast');
            } else if (item.label == 'Daily\nMotivation') {
              await _openUrl(
                  'https://www.google.com/search?q=daily+motivation+quotes');
            } else if (item.label == 'Breathing\nExercises') {
              await _openUrl(
                  'https://www.youtube.com/results?search_query=breathing+exercise+5+minutes');
            }
          },
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isOn ? moodActive.withOpacity(0.25) : circleOff,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 24,
                  color: isOn ? Colors.black54 : iconOff,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: textMain, fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ما قدرت أفتح الرابط')),
      );
    }
  }

  // ===== Done: يحفظ المزاج ويرجع للهوم =====
  Future<void> _onDone() async {
    final mood = switch (selectedMood) {
      0 => MoodType.great,
      1 => MoodType.good,
      2 => MoodType.neutral,
      3 => MoodType.sad,
      _ => MoodType.awful,
    };

    await MoodStorage.saveToday(mood);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  String _formatToday() {
    final now = DateTime.now();
    const weekdays = [
      'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
    ];
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }
}

class _Item {
  final String label;
  final IconData icon;
  const _Item(this.label, this.icon);
}
