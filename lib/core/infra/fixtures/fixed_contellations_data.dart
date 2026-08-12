import 'package:constellation_app/core/infra/models/constellation_model.dart';
import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';

abstract class FixedContellationsData {
  const FixedContellationsData._();

  static const list = <ConstellationModel>[
    ConstellationModel(
      id: AppStrings.driftingThoughtsId,
      name: AppStrings.driftingThoughtsName,
      description: AppStrings.driftingThoughtsDescription,
      firstExample: AppStrings.driftingThoughtsExample1,
      secondExample: AppStrings.driftingThoughtsExample2,
      icon: AppIcons.meteor,
    ),
    ConstellationModel(
      id: AppStrings.quietMomentsId,
      name: AppStrings.quietMomentsName,
      description: AppStrings.quietMomentsDescription,
      firstExample: AppStrings.quietMomentsExample1,
      secondExample: AppStrings.quietMomentsExample2,
      icon: AppIcons.moonStars,
    ),
    ConstellationModel(
      id: AppStrings.tomorrowsOrbitId,
      name: AppStrings.tomorrowsOrbitName,
      description: AppStrings.tomorrowsOrbitDescription,
      firstExample: AppStrings.tomorrowsOrbitExample1,
      secondExample: AppStrings.tomorrowsOrbitExample2,
      icon: AppIcons.saturn,
    ),
    ConstellationModel(
      id: AppStrings.deepFocusId,
      name: AppStrings.deepFocusOrbitName,
      description: AppStrings.deepFocusOrbitDescription,
      firstExample: AppStrings.deepFocusOrbitExample1,
      secondExample: AppStrings.deepFocusOrbitExample2,
      icon: AppIcons.rocket,
    ),
  ];
}
