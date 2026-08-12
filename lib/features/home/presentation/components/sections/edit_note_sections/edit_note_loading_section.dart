import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class EditNoteLoadingSection extends StatelessWidget {
  const EditNoteLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colors.tertiary),
    );
  }
}
