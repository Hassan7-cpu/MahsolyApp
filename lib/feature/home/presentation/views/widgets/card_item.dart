import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/feature/home/data/model/item_model.dart';
import 'package:save_plant/feature/home/presentation/views/plant_details_view.dart.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final cardWidth = (width - 48) / 2;
    final imageHeight = height * 0.18;
    final aspectRatio = cardWidth / imageHeight;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantDetailsView(item: item)),
        );
      },
      child: Card(
        color: Theme.of(context).cardTheme.color,
        margin: EdgeInsets.all(8.r),
        shape: Theme.of(context).cardTheme.shape,
        elevation: Theme.of(context).cardTheme.elevation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Image(image: item.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
