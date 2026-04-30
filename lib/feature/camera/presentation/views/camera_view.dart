// ignore_for_file: unused_element

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';
import 'package:save_plant/feature/camera/data/repo/upload_plant_image_repo.dart';
import 'package:save_plant/feature/camera/presentation/cubit/Upload_plant_image_Cubit.dart';
import 'package:save_plant/feature/camera/presentation/cubit/upload_plant_image_state.dart';
import 'package:save_plant/feature/camera/presentation/views/result_view.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/build_camera_preview.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupCameraController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
      _cameraController = null;
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UploadPlantImageCubit(PlantRepo(DioConsumer(dio: Dio()))),
      child: BlocConsumer<UploadPlantImageCubit, UploadPlantImageState>(
        listener: (context, state) {
          if (state is UploadPlantImageSuccess) {
            final scanModel = ScanModel.fromJson(
              state.data as Map<String, dynamic>,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ResultView(data: scanModel)),
            );
          }
          if (state is UploadPlantImageError) {
            snackBarMessage(context, state.message, color: Colors.red);
          }
        },

        builder: (context, state) {
          if (state is UploadPlantImageLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is UploadPlantImageSuccess) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body:
                (_cameraController == null ||
                    !_cameraController!.value.isInitialized)
                ? const Center(child: CircularProgressIndicator())
                : BuildCameraPreview(cameraController: _cameraController!),
          );
        },
      ),
    );
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      _cameras = cameras;

      _cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.high,
      );

      try {
        await _cameraController!.initialize();

        if (!mounted) return;

        setState(() {});
      } catch (e) {
        debugPrint("Error initializing camera: $e");
      }
    }
  }
}
