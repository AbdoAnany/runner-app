import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/share/badge_level_type.dart';
import '../../../../core/share/text_field.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/main_buttom.dart';
import '../../../../dependency_injection.dart';
import '../../../4_history/data/models/history_data_model.dart';
import '../manager/userpoint_bloc.dart';

class UserPointControlBlocProvider extends StatelessWidget {
  const UserPointControlBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPointBloc>(
      create: (context) => locator<UserPointBloc>(),
      child: const UserPointControlScreen(),
    );
  }
}

class UserPointControlScreen extends StatefulWidget {
  const UserPointControlScreen({super.key});

  @override
  State<UserPointControlScreen> createState() => _UserPointControlScreenState();
}

class _UserPointControlScreenState extends State<UserPointControlScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    context.read<UserPointBloc>().add(GetUserListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPointBloc, UserPointState>(
      builder: (context, state) {
        if (state is UserPointLoading) return LoadingWidget();
        if (state is UserDateListLoaded) {
          print(">>>>>>>>>>  state.userList.length");
          print(state.userList.length);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.userList.length,
              itemBuilder: (c, i) => InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context1) {
                      return Dialog(
                        backgroundColor: AppColors.bgContainerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 200.h,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(AppStrings.addPoint,
                                    style: AppStyle.fWhiteS21W700),
                                MyTextField(
                                  controller: controller,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true, signed: false),
                                ),
                                MyMaterialButton(
                                  title: AppStrings.addPoint,
                                  onPressed: () {
                                    Navigator.of(context1).pop();
                                    context.read<UserPointBloc>().add(
                                        AddUserPointEvent(
                                            PointUserHistoryDataModel(
                                              id: Random()
                                                  .nextInt(1000000)
                                                  .toString(),
                                              date: DateTime.now()
                                                  .toIso8601String(),
                                              xp: int.tryParse(
                                                      controller.text) ??
                                                  0,
                                              userId: state.userList[i].userId
                                                  .toString(),
                                            ),
                                            state.userList[i].fcmToken
                                                .toString()));
                                  },
                                  width: 326.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.bgContainerColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.border1ContainerColor, width: 4),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const BadgeLevelFrame(
                          image: AppImage.person,
                          levelType: BadgeLevelTypeFrame.Advance,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.userList[i].name.isEmpty
                                    ? "NO Name"
                                    : "${state.userList[i].name}",
                                style: AppStyle.fWhiteS16W800,
                              ),
                              Text(
                                state.userList[i].email.toString(),
                                style: AppStyle.fWhiteS12W400,
                              ),

                              Text(
                                "Rank  ${state.userList[i].rank}",
                                style: AppStyle.fWhiteS24W800BebasNeue
                                    .copyWith(letterSpacing: 1.2),
                              ),

                              Text(
                                state.userList[i].userId
                                    .toString()
                                    .toUpperCase(),
                                style: AppStyle.textStyle10GrayW400,
                              ),
                              //       Text(state.userList[i].fcmToken.toString().toUpperCase(),style: AppStyle.textStyle10GrayW400,),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.userList[i].roles.toString().toUpperCase(),
                              style: AppStyle.textStyle16GoldW800,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              // margin: EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                border: Border.all(
                                    width: 2,
                                    color: AppColors.border1ContainerColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    state.userList[i].currentLevel.toString(),
                                    style: AppStyle.fWhiteS24W800BebasNeue
                                        .copyWith(height: 1),
                                  ),
                                  Text(
                                    "Level",
                                    style: AppStyle.fWhiteS21W400BebasNeue
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
