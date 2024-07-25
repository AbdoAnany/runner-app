import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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

];List <Map<String, dynamic>> brandList = [
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

                    PopularSection(),

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


class PopularSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular',
                style:AppStyle.textStyle18WhiteW700,
              ),
              Text(
                'See All',
                style:AppStyle.textStyle14PrimaryW400,
              ),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0.w,),
          child: Row(
            children: [
              Expanded(child:
              PopularItem(
                image: AppImage.nike1,
                brand: 'Nike',
                model: 'Air Force 1 Low \'07',
                price: '1200',
                backgroundColor: Colors.lightBlue,
              )
              ),
              SizedBox(width: 16),
              Expanded(child: PopularItem(
                image: AppImage.nike2,
                brand: 'Nike',
                model: 'Air Lunaroll 1',
                price: '1200',
                backgroundColor: Colors.white,
              )),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class PopularItem extends StatelessWidget {
  final String image;
  final String brand;
  final String model;
  final String price;
  final Color backgroundColor;

  const PopularItem({
    Key? key,
    required this.image,
    required this.brand,
    required this.model,
    required this.price,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border1ContainerColor),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
        //    height: 120.h,


            decoration: BoxDecoration(
             // color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Center(child: Image.asset(image, fit: BoxFit.fill)),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.coin_1, color: Colors.white, size: 12.w),
                        SizedBox(width: 4,),
                        Text(
                          '$price',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

