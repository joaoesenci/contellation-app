import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/helpers/app_border_radius.dart';
import 'package:constellation_app/shared/themes/helpers/app_insets.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/widgets.dart';

class EmptyListContainer extends StatelessWidget {
  final String text;

  const EmptyListContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final showEmote = text != AppStrings.emptySearchingNotes;

    return Container(
      padding: AppInsets.vSmall,
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: AppBorderRadius.allMedium,
      ),
      child: Center(
        child: Text(
          showEmote ? '$text 💤' : text,
          style: context.texts.bodyMedium!.copyWith(
            color: context.colors.onSecondary,
            fontFamily: AppStrings.nunitoFont,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
