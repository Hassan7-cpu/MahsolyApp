import 'package:flutter/material.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/app_drawer.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/home_view_body.dart';

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
        appBar: AppBar(title: HeaderSection(title: 'Mahsoly')),
        drawer: const AppDrawer(),
        body: HomeViewBody(searchQuery: searchQuery),
      ),
    );
  }
}
