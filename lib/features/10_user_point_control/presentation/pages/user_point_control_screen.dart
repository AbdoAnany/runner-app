import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/share/text_field.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/main_buttom.dart';
import '../../../../dependency_injection.dart';
import '../../../../my_app.dart';
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
    return Scaffold(
      body: BlocBuilder<UserPointBloc, UserPointState>(

        builder: (context, state) {
          if (state is UserPointLoading) return LoadingWidget();
          if (state is UserDateListLoaded) {
            print(">>>>>>>>>>  state.userList.length")  ;
            print(state.userList.length)  ;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (c, i) =>
                    InkWell(
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
                                      SizedBox(height: 8,),
                                      Text(AppStrings.addPoint, style: AppStyle.textStyle21WhiteW700),
                                      MyTextField(
                                        controller: controller,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                                      ),
                                      MyMaterialButton(
                                        title: AppStrings.addPoint,
                                        onPressed: () {
                                          Navigator.of(context1).pop();
                                          context.read<UserPointBloc>().add(AddUserPointEvent(
                                            PointUserHistoryDataModel(
                                              id: Random().nextInt(1000000).toString(),
                                              date: DateTime.now().toIso8601String(),


                                              xp: int.tryParse(controller.text) ?? 0,
                                              userId:state.userList[i].userId.toString(),
                                            ),state.userList[i].fcmToken.toString()
                                          ));
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
                        margin: EdgeInsets.all(8),

                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                          Border.all(color: Colors.white),) ,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network((state.userList[i].photoUrl).toString()
                                ,errorBuilder: (c,s,a)=>Image.asset(AppImage.person  ,height: 50,width: 50,)
                                ,height: 50,width: 50,),
                              SizedBox(width: 8,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.userList[i].email.toString(),style: AppStyle.textStyle16GWhiteW800,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Rank  "+state.userList[i].rank.toString(),style: AppStyle.textStyle24GWhiteW800BebasNeue,),
                                        Text(state.userList[i].roles.toString().toUpperCase(),style: AppStyle.textStyle20GoldW800,),

                                      ],
                                    ),
                                    Text(state.userList[i].userId.toString().toUpperCase(),style: AppStyle.textStyle10GrayW400,),

                                  ],
                                ),
                              ),


                             SizedBox(width: 16,),
                              Column(
                                children: [
                                  Text(state.userList[i].currentLevel.toString(),style: AppStyle.textStyle24GWhiteW800BebasNeue,),

                                  Text("Level",style: AppStyle.textStyle24GWhiteW800BebasNeue,),

                                ],
                              ),
                              SizedBox(width: 16,),
                            ],
                          )),
                    ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

}
