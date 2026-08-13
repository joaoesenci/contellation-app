import 'package:constellation_app/app/app_routes.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/home_routes.dart';
import 'package:constellation_app/features/home/presentation/components/sections/home_sections/home_initial_section.dart';
import 'package:constellation_app/features/home/presentation/components/sections/home_sections/home_loading_section.dart';
import 'package:constellation_app/features/home/presentation/components/sections/home_sections/home_problem_section.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/add_note_floating_button.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_state.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final HomeCubit cubit;

  const HomePage({super.key, required this.cubit});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit get _cubit => widget.cubit;

  late final TextEditingController _searchTextController;
  late final ScrollController _headerScrollController;
  late final ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();

    _searchTextController = TextEditingController();
    _headerScrollController = ScrollController();
    _listScrollController = ScrollController();

    _cubit.loadData();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _headerScrollController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void _onTapFloatingActionButton(List<NoteEntity> allNotes) async {
    await HapticFeedback.lightImpact();

    final isNoteSaved = await Modular.to.pushNamed<bool>(
      '${AppRoutes.home}${HomeRoutes.editNote}',
      arguments: {'allNotes': allNotes},
    );
    if (isNoteSaved == true && mounted) {
      _cubit.onRefreshNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,

      listenWhen: (previous, current) =>
          previous.feedbackStatus != current.feedbackStatus,

      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.allNotes != current.allNotes ||
          previous.filteredNotes != current.filteredNotes ||
          previous.foundNotes != current.foundNotes ||
          previous.selectedNotesIds != current.selectedNotesIds ||
          previous.isListMode != current.isListMode ||
          previous.isSearching != current.isSearching ||
          previous.isDeleting != current.isDeleting ||
          previous.selectedConstellationId != current.selectedConstellationId,

      listener: (context, state) {},

      builder: (context, state) {
        return PopScope(
          canPop: !state.isSearching && !state.isDeleting,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            await HapticFeedback.mediumImpact();

            if (state.isSearching) {
              _cubit.onClearSearch();
              _searchTextController.clear();
              return;
            }

            if (state.isDeleting) {
              _cubit.onClearDeleting();
            }
          },
          child: Scaffold(
            backgroundColor: context.colors.primary,
            floatingActionButton:
                state.status == HomeStatus.initial && !state.isDeleting
                ? AddNoteFloatingButton(
                    onTap: () => _onTapFloatingActionButton(state.allNotes),
                  )
                : null,
            body: switch (state.status) {
              HomeStatus.initial => HomeInitialSection(
                state: state,
                cubit: _cubit,
                textController: _searchTextController,
                headerScrollController: _headerScrollController,
                listScrollController: _listScrollController,
              ),
              HomeStatus.loading => const HomeLoadingSection(),
              HomeStatus.problem => const HomeProblemSection(),
            },
          ),
        );
      },
    );
  }
}
