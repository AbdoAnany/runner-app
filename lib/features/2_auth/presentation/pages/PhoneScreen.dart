import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/core/constants/app_images.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/widgets/main_buttom.dart';

import '../../../whats_app.dart';
import '../widgets/LogoWithTitle.dart';
import 'otp_verification .dart'; // استدعاء الخدمة

class PhoneScreen extends StatefulWidget {
  PhoneScreen({super.key});

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final WhatsAppVerificationService _whatsAppService = WhatsAppVerificationService();

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneController.text.trim();

      await _whatsAppService.sendWhatsAppOtp(phoneNumber: phoneNumber);
      Navigator.of(context).pushNamed('/verification', arguments: phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: LogoWithTitle(
        title: 'Phone',
        subText: "Enter your phone number to receive an OTP via WhatsApp.",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _phoneController,
                decoration: AppStyle.inputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter a valid phone number' : null,
              ),
            ),
          ),
          MyMaterialButton(
            width: double.infinity,
            onPressed: _sendOtp,
            title: 'Next',
          ),
        ],
      ),
    );
  }
}
