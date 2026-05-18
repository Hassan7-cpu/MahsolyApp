import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/home/data/repo/dashboard_repository.dart';
import 'package:save_plant/feature/home/presentation/cubit/dashboard_cubit.dart';
import 'package:save_plant/feature/home/presentation/cubit/dashboard_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final WebViewController controller;
  bool isWebPageLoading = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isWebPageLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isWebPageLoading = false);
          },
          onWebResourceError: (error) {
            setState(() => isWebPageLoading = false);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(DashboardRepository(api: DioConsumer(dio: Dio())))
            ..fetchDashboardUrl(),
      child: Scaffold(
        appBar: AppBar(title: HeaderSection(title: 'Dashboard')),
        body: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {
            if (state is DashboardSuccess) {
              controller.loadRequest(Uri.parse(state.response.url));
            }
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Connecting to dashboard...",
                      style: AppTextStyle.giloryRegular16(context),
                    ),
                  ],
                ),
              );
            }

            if (state is DashboardFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red[400],
                        size: 70.r,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Something went wrong",
                        style: AppTextStyle.giloryBold22(context),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.errMessage,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.giloryRegular14(context),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<DashboardCubit>().fetchDashboardUrl();
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: Text(
                          "Try Again",
                          style: AppTextStyle.giloryRegular16(context),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is DashboardSuccess) {
              return Stack(
                children: [
                  WebViewWidget(controller: controller),
                  if (isWebPageLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.primaryColor,
                        ),
                      ),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
