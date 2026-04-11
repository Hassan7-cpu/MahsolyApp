import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_assets.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/card_item.dart';
import 'package:save_plant/feature/home/data/model/item_model.dart';

class HomeViewBody extends StatefulWidget {
  final String searchQuery;

  const HomeViewBody({super.key, required this.searchQuery});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<ItemModel> items = [
    ItemModel(
      name: 'Wheat',
      image: AppAssets.wheat,
      waterNeeds: 'Every 15–20 days',
      sunNeeds: 'Full sun (6–8 hours)',
      soilNeeds: 'Fertile well-drained soil',
      commonDisease: 'Wheat Rust: Treat with fungicide such as Propiconazole',
      season: 'Winter – Spring',
    ),
    ItemModel(
      name: 'Banana',
      image: AppAssets.banana,
      waterNeeds: 'Every 2–3 days',
      sunNeeds: 'Full sun',
      soilNeeds: 'Rich moist soil',
      commonDisease: 'Panama Disease: Use disease-resistant varieties',
      season: 'All year in warm climates',
    ),
    ItemModel(
      name: 'Bell Pepper',
      image: AppAssets.bellPepper,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Rich clay soil',
      commonDisease: 'Aphids: Treat with neem oil spray',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Clover',
      image: AppAssets.clover,
      waterNeeds: 'Once a week',
      sunNeeds: 'Sun to partial shade',
      soilNeeds: 'Most soil types',
      commonDisease: 'Leaf Spot: Apply fungicide spray',
      season: 'Winter – Spring',
    ),
    ItemModel(
      name: 'Corn',
      image: AppAssets.corn,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Fertile well-drained soil',
      commonDisease: 'Corn Smut: Remove infected plants',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Cotton',
      image: AppAssets.cotton,
      waterNeeds: 'Once a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Sandy or clay soil',
      commonDisease: 'Cotton Bollworm: Use insecticide or biological control',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Cucumber',
      image: AppAssets.cucumber,
      waterNeeds: 'Every two days',
      sunNeeds: 'Full sun',
      soilNeeds: 'Light compost soil',
      commonDisease: 'Powdery Mildew: Spray sulfur fungicide',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Date Palm',
      image: AppAssets.datePalm,
      waterNeeds: 'When soil dries',
      sunNeeds: 'Full sun',
      soilNeeds: 'Sandy well-drained soil',
      commonDisease: 'Red Palm Weevil: Use insecticide treatment',
      season: 'Any time in warm regions',
    ),
    ItemModel(
      name: 'Eggplant',
      image: AppAssets.eggplant,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Slightly acidic soil',
      commonDisease: 'Flea Beetles: Use neem oil spray',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Fig',
      image: AppAssets.fig,
      waterNeeds: 'Once a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Well-drained soil',
      commonDisease: 'Fig Rust: Apply copper fungicide',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Garlic',
      image: AppAssets.garlic,
      waterNeeds: 'Once a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Loose nitrogen-rich soil',
      commonDisease: 'White Rot: Remove infected plants',
      season: 'Autumn – Winter',
    ),
    ItemModel(
      name: 'Guava',
      image: AppAssets.guava,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Organic rich soil',
      commonDisease: 'Fruit Fly: Use traps or insecticides',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Mango',
      image: AppAssets.mango,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Deep well-drained soil',
      commonDisease: 'Anthracnose: Spray fungicide',
      season: 'Summer planting',
    ),
    ItemModel(
      name: 'Onion',
      image: AppAssets.onion,
      waterNeeds: 'Once a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Loose fertile soil',
      commonDisease: 'Downy Mildew: Use fungicide spray',
      season: 'Autumn – Winter',
    ),
    ItemModel(
      name: 'Orange',
      image: AppAssets.orange,
      waterNeeds: 'Deep watering weekly',
      sunNeeds: 'Full sun',
      soilNeeds: 'Sandy clay soil',
      commonDisease: 'Citrus Canker: Remove infected leaves',
      season: 'Winter – Spring',
    ),
    ItemModel(
      name: 'Pepper',
      image: AppAssets.pepper,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Rich clay soil',
      commonDisease: 'Aphids: Treat with neem oil',
      season: 'Spring – Summer',
    ),
    ItemModel(
      name: 'Potato',
      image: AppAssets.potato,
      waterNeeds: 'Twice a week',
      sunNeeds: 'Full sun',
      soilNeeds: 'Loose slightly acidic soil',
      commonDisease: 'Late Blight: Spray fungicide',
      season: 'Autumn – Winter',
    ),
    ItemModel(
      name: 'Tomato',
      image: AppAssets.tomato,
      waterNeeds: 'Every two days',
      sunNeeds: 'Full sun',
      soilNeeds: 'Fertile clay soil',
      commonDisease: 'Blight: Use fungicide and remove infected leaves',
      season: 'Spring – Summer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.searchQuery.isEmpty
        ? items
        : items.where((plant) {
            return plant.name.toLowerCase().contains(
              widget.searchQuery.toLowerCase(),
            );
          }).toList();

    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.77,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return CardItem(item: filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
