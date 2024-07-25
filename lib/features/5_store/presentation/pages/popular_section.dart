import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../4_history/presentation/manager/runner_data/runner_data_bloc.dart';
import '../../../4_history/presentation/manager/runner_data/runner_data_state.dart';



class StoreScreen extends StatefulWidget {


  const StoreScreen( {super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}
List <Map<String, dynamic>> runnerData = [
  {"name":"new","image":AppImage.newCard},
  {"name":"man","image":AppImage.manCard},
  {"name":"woman","image":AppImage.manCard},
  {"name":"kides","image":AppImage.kidsCard},
  {"name":"Equip","image":AppImage.equipCard},
  {"name":"Nutrition","image":AppImage.equipCard},

];
List <Map<String, dynamic>> brandList = [
  {"name":"Puma","image":AppImage.puma},
  {"name":"Reebok","image":AppImage.reebok},
  {"name":"Nike","image":AppImage.nike},
  {"name":"Adidas","image":AppImage.adidas},
  {"name":"UA","image":AppImage.ua},
  {"name":"Asics","image":''},
  {"name":"Reebok","image":AppImage.reebok},
  {"name":"See ALL","image":''},


];
class _StoreScreenState extends State<StoreScreen> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
     extendBodyBehindAppBar: true,

      body: SafeArea(
        child: BlocBuilder<RunnerHistoryDataBloc, RunnerHistoryDataState>(
          builder: (context, state) {
            print('ssssssssss');
            print(state);
            if (state is RunnerDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RunnerDataLoaded) {
              //state.StoreData.addAll(StoreData.toList());
              return     SingleChildScrollView(
                child: Column(
                  children: [


                    SizedBox(height: 80.h,width: double.infinity,
                      child:

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: runnerData.map((data)=>Column(
                                children: [
                                  Image.asset(data['image'],width: 65.w,
                                    height: 70,
                                   ),
                                  Text(data['name'],style: AppStyle.textStyle12GrayW400,),
                                ],
                              )).toList(),
                            ),
                          )),
                    SizedBox(width: double.infinity,
                        child:

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [1,2].map((data)=>  Container(
                                margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 8),

                                height: 125,width: 291,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: AppColors.storeCard[data],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Today’s Special',style: AppStyle.textStyle18WhiteW700,),
                                            Text('Get 2x point for every steps, only valid for today',style: AppStyle.textStyle12WhiteW400,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Image.asset(AppImage.card1Card,fit: BoxFit.cover,))
                                  ],
                                ),
                              ),).toList(),
                            ),
                          ),
                        )),

                    //storeContainerBrand

                    Container(padding: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
                      height: 164.h,width: double.infinity,
                      child: GridView(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        mainAxisExtent: 65.h
                      )
                        ,
                      children: brandList.map((e)=>
                      Container(
                        height: 73.h,width: 73.w,
                        decoration: BoxDecoration(
                          color: AppColors.storeContainerBrand,
                          border: Border.all(color: AppColors.white.withOpacity(.09)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8.h,),
                            e['image'].toString().isNotEmpty?
                            Image.asset(e['image'],width: 32.w,
                              height: 32.h,
                            ):SizedBox(height: 32.h,),
                            Text(e['name'],style: AppStyle.textStyle12GrayW400,),
                          ],
                        ),
                      )
                      ).toList(),
                      ),
                    ),

                  //  PopularSection(),

                  ],
                ),
              );

              // ListView(
              // children: [
              //  // if (widget.viewStore ?? false)
              //
              //
              //   // if (widget.viewPopular ?? false)
              //   //   PopularSection(popularData: state.popularData),
              // ],);

            } else {
              return Center(child: Text('Error loading data.'));
            }
          },
        ),
      ),
    );
  }
}



