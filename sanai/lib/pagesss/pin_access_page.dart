import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';

class QuickAccessPinWidget extends StatefulWidget {
  const QuickAccessPinWidget({super.key});

  static String routeName = 'quickAccessPin';
  static String routePath = '/quickAccessPin';

  @override
  State<QuickAccessPinWidget> createState() => _QuickAccessPinWidgetState();
}

class _QuickAccessPinWidgetState extends State<QuickAccessPinWidget> {
  String _pin = '';
  bool _isLoading = false;
  final LocalAuthentication _auth = LocalAuthentication();

  // ================= INIT =================
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  // ================= HASH =================
  String _hashPin(String pin, String uid) {
    const pepper = 'SANAI_APP_V1';
    final bytes = utf8.encode('$pepper|$uid|$pin');
    return sha256.convert(bytes).toString();
  }

  // ================= GET SAVED PIN =================
  Future<String?> _getSavedPinHash() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return doc.data()?['pinHash'];
  }

  // ================= SAVE PIN =================
  Future<void> _savePin(String pin) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final hash = _hashPin(pin, user.uid);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'pinEnabled': true,
      'pinHash': hash,
      'pinUpdatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ================= VERIFY PIN =================
  Future<void> _verifyPin() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    final savedHash = await _getSavedPinHash();

    // أول مرة → خزّن PIN
    if (savedHash == null) {
      await _savePin(_pin);

      if (!mounted) return;

      setState(() {
        _pin = '';
        _isLoading = false;
      });

      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // تحقق
    final enteredHash = _hashPin(_pin, user.uid);

    if (enteredHash == savedHash) {
      if (!mounted) return;

      setState(() {
        _pin = '';
        _isLoading = false;
      });

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _pin = '';
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN')),
      );
    }
  }

  // ================= KEYPAD =================
  void _onNumberTap(String number) {
    if (_pin.length < 6) {
      setState(() => _pin += number);

      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < _pin.length
                ? const Color(0xFF105A4A)
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildNumber(String number) {
    return InkWell(
      onTap: () => _onNumberTap(number),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final numbers = ['1','2','3','4','5','6','7','8','9','','0','⌫'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 80),
          const Icon(Icons.lock,
              size: 80, color: Color(0xFF105A4A)),
          const SizedBox(height: 20),
          const Text('Quick Access',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          _buildPinDots(),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60),
              itemCount: numbers.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (_, i) {
                if (numbers[i] == '') return const SizedBox();
                if (numbers[i] == '⌫') {
                  return IconButton(
                    icon: const Icon(
                        Icons.backspace_outlined,
                        size: 30),
                    onPressed: _onBackspace,
                  );
                }
                return _buildNumber(numbers[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
} 
