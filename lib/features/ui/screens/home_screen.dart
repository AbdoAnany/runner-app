import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/ui/screens/runner_data_screen.dart';



import '../../blocs/runner_data/runner_data_bloc.dart';
import '../../blocs/runner_data/runner_data_state.dart';
import '../../services/role_service.dart';

class HomeScreen extends StatefulWidget {
  final dynamic user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _rolePermissions;

  @override
  void initState() {
    super.initState();
    _rolePermissions = RoleService().getRolePermissions('admin');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runner App'),
      ),
      body: Stack(

        children: [
          Positioned(top: 0,right: 0,
            child: Container(width: 375.w,height: 375.h,
              decoration: BoxDecoration(

             
                gradient: RadialGradient(
                  colors: [AppColors.primary,AppColors.primary.withOpacity(0) ],
               
                ),
              ),
            ),
          ),

          FutureBuilder<Map<String, dynamic>>(
            future: _rolePermissions,
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading permissions'));
              } else {
                final permissions = snapshot.data ?? {};

                return RunnerDataScreen(
                  viewHistory: permissions['canViewHistory'],
                  viewPopular: permissions['canViewPopular'],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
