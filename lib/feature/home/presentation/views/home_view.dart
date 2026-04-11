import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/home_view_body.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/search_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 110,
          title: SearchAppBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            onClear: () {
              setState(() {
                searchQuery = '';
              });
            },
          ),
        ),
        body: HomeViewBody(searchQuery: searchQuery),
      ),
    );
  }
}
