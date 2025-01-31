import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/widgets/main_buttom.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../whats_app.dart';
import '../widgets/LogoWithTitle.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final WhatsAppVerificationService _whatsAppService = WhatsAppVerificationService();
  String? phoneNumber;
  String? verificationId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneNumber = ModalRoute.of(context)!.settings.arguments as String?;
  }

  void _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      String otpCode = _otpController.text.trim();
      if (verificationId != null) {
        await _whatsAppService.verifyWhatsAppOtp(
          phoneNumber: phoneNumber!,
          code: otpCode,
          verificationId: verificationId!,
        );
      } else {
        print('Verification ID is missing.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: LogoWithTitle(
        title: 'Verification',
        subText: "Enter the OTP sent to your WhatsApp",
        children: [
          Text(phoneNumber ?? "", style: AppStyle.fWhiteS12W400),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _otpController,
                  decoration: AppStyle.inputDecoration(hintText: 'Enter OTP'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter the OTP' : null,
                ),
                SizedBox(height: 32.0),
                MyMaterialButton(
                  width: double.infinity,
                  onPressed: _verifyOtp,
                  title: 'Verify',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
