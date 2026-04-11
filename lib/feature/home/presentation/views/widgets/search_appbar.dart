import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/widgets/custom_textfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';

class SearchAppBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchAppBar({
    super.key,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSection(title: 'Mahsoly'),
        SizedBox(height: 20.h),
        CustomTextfield(
          controller: _controller,
          prefixIcon: Icon(Icons.search, size: 22.sp),
          onChanged: widget.onChanged,
          hintText: 'Search plants...',
          enabled: true,
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              _controller.clear();
              widget.onClear();
            },
            icon: Icon(Icons.close, size: 22.sp),
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
