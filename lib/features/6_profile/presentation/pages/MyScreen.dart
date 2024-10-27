import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/notification_service/NotificationItem.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/notification/notification_bloc.dart';
import '../../../../core/notification_service/notifcation_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",style: AppStyle.fWhiteS20W800,),
      ),
      backgroundColor: AppColors.bgColor,
      body: StreamBuilder<List<NotificationItem>>(
        stream: NotificationService().notifications,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
         else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
         else if (!snapshot.hasData) {
            return const Center(child:   Text('No notifications'),);
          }

          final notifications = snapshot.data!;

         final unread = notifications.where((n) => !n.isRead).toList();
         final read = notifications.where((n) => n.isRead).toList();
          return
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Unread",style:AppStyle.fWhiteS18W700,),
                      SizedBox(height: 10,),
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: AppStyle.decorationHome,
                        child:
                        unread.isEmpty ?  Center(child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text("No Unread Notifications"
                              ,style: AppStyle.fWhiteS14W700
                          ),
                        ),) :
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,

                            itemBuilder: (context,index) {
                              final message = unread[index];
                              return GestureDetector(
                                onTap: (){
                                  NotificationService().markAsRead(message.id);
                                },
                                child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2.0, // Set the border width
                                            color:AppColors.primary,// Set the border color
                                          ),
                                          shape: BoxShape.circle
                                      ),
                                      child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor:  AppColors.primary.withOpacity(0.3),
                                          child: const Icon(Icons.notifications_active_outlined,
                                            color:AppColors.white,)),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(message.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.fWhiteS18W800Quicksand,
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(message.body,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.fWhiteS12W400,
                                              maxLines: 3,),
                                          ],
                                        ))

                                  ],
                                ),
                                                            ),
                              );
                            },
                            separatorBuilder: (context,index)=>Divider(),
                            itemCount: unread.length),
                      ),
                      SizedBox(height: 15,),
                      Text("Past Notifications",style: AppStyle.fWhiteS18W700,),
                      SizedBox(height: 15,),
                      Container(
                        // padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                        decoration: AppStyle.decorationHome,
                        child:
                        read.isEmpty ?  Center(child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text("No past notifications"
                          ,style: AppStyle.fWhiteS14W700
                          ),
                        ),) :
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,

                            itemBuilder: (context,index) {
                              final message = read[index];
                              return GestureDetector(
                                onTap: (){
                                  NotificationService().markAsRead(message.id);
                                },child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2.0, // Set the border width
                                              color:AppColors.border1ContainerColor,// Set the border color
                                            ),
                                            shape: BoxShape.circle
                                        ),
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:  AppColors.primary.withOpacity(0.3),
                                            child: const Icon(Icons.notifications_outlined,color:AppColors.white,)),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(message.title,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyle.fWhiteS18W800Quicksand,
                                              ),
                                              const SizedBox(height: 5,),
                                              Text(message.body,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyle.fWhiteS12W400,
                                                maxLines: 3,),
                                            ],
                                          ))

                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context,index)=>Divider(),
                            itemCount: read.length),
                      ),

                    ],
                  ),
                ),
              ),
            );


        },
      ),
    );
  }
}


// class Notifications extends StatelessWidget {
//   const Notifications({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotificationBloc,NotificationState>(builder: (context,state)=> Scaffold(
//
//         body:Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: SingleChildScrollView(
//             child: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Text("Unread",style:AppStyle.textStyle18WhiteW700,),
//                   SizedBox(height: 10,),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                     decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: ListView.separated(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemBuilder: (context,index)=>Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       width: 2.0, // Set the border width
//                                       color:AppColors.primary,// Set the border color
//                                     ),
//                                     shape: BoxShape.circle
//                                 ),
//                                 child: CircleAvatar(
//                                     radius: 30,
//                                     backgroundColor:  AppColors.primary.withOpacity(0.3),
//                                     child: Icon(Icons.notifications_active,color:AppColors.primary,)),
//                               ),
//                               SizedBox(width: 10,),
//                               Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("#Order 52133",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppStyle.textStyle14PrimaryW400,
//                                       ),
//                                       SizedBox(height: 5,),
//                                       Text("Hi there! Here is the Notifications mobile app UI/UX design with iPhone X Screen Size ready to kickstart your design process!",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppStyle.textStyle12WhiteW400,
//                                         maxLines: 3,),
//                                     ],
//                                   ))
//
//                             ],
//                           ),
//                         ),
//                         separatorBuilder: (context,index)=>Divider(),
//                         itemCount: 3),
//                   ),
//                   SizedBox(height: 15,),
//                   Text("Past Notifications",style: AppStyle.textStyle14PrimaryW400,),
//                   SizedBox(height: 15,),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                     decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: ListView.separated(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemBuilder: (context,index)=>Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: AppColors.primary.withOpacity(0.3),
//                                   child: Icon(Icons.notifications_active,color: AppColors.primary,)),
//                               SizedBox(width: 10,),
//                               Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("#Order 52133",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppStyle.textStyle14PrimaryW400,
//                                       ),
//                                       SizedBox(height: 5,),
//                                       Text("Hi there! Here is the Notifications mobile app UI/UX design with iPhone X Screen Size ready to kickstart your design process!",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppStyle.textStyle12WhiteW400,
//                                         maxLines: 3,),
//                                     ],
//                                   ))
//
//                             ],
//                           ),
//                         ),
//                         separatorBuilder: (context,index)=>Divider(),
//                         itemCount: 15),
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ))
//
//     );
//   }
// }
