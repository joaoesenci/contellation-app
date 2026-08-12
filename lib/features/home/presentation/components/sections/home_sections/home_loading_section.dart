import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class HomeLoadingSection extends StatelessWidget {
  const HomeLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colors.tertiary),
    );
  }
}
