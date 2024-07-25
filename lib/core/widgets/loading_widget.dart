import 'package:flutter/material.dart';
import 'package:runner_app/core/helper/extension.dart';

import '../style/color.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: context.height/1.5,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}