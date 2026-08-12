import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/tokens/app_sizes.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  static const smallSize = AppSizes.small;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: smallSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contellation',
            style: context.texts.headlineSmall!.copyWith(
              color: context.colors.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Midnight Notes',
            style: context.texts.bodyMedium!.copyWith(
              color: context.colors.onSecondary,
              fontWeight: FontWeight.w300,
              fontFamily: AppStrings.nunitoFont,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
