import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/services/constellation/constellation_connection_service.dart';
import 'package:constellation_app/core/services/constellation/constellation_layout_service.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/delete_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/get_all_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/save_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/notes/delete_note_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/notes/get_all_notes_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/notes/save_note_usecase.dart';
import 'package:constellation_app/features/home/external/datasources/home_datasource_impl.dart';
import 'package:constellation_app/features/home/home_routes.dart';
import 'package:constellation_app/features/home/infra/datasources/home_datasource.dart';
import 'package:constellation_app/features/home/infra/repositories/home_repository_impl.dart';
import 'package:constellation_app/features/home/presentation/cubits/constellation_cubits/constellation_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_cubit.dart';
import 'package:constellation_app/features/home/presentation/pages/edit_note_page.dart';
import 'package:constellation_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // ---------- 💾 DATASOURCES ----------
    i.addSingleton<IHomeDatasource>(
      () => HomeDatasourceImpl(Modular.get<INoteStorageService>()),
    );

    // ---------- 📦 REPOSITORIES ----------
    i.addSingleton<IHomeRepository>(
      () => HomeRepositoryImpl(Modular.get<IHomeDatasource>()),
    );

    // ---------- 🛠️ USECASES ----------
    i.add<GetFixedConstellationsUsecase>(
      () => GetFixedConstellationsUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<SaveNoteUsecase>(
      () => SaveNoteUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<GetAllNotesUsecase>(
      () => GetAllNotesUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<DeleteNoteUsecase>(
      () => DeleteNoteUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<SaveConstellationLinesUsecase>(
      () => SaveConstellationLinesUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<GetAllConstellationLinesUsecase>(
      () => GetAllConstellationLinesUsecase(Modular.get<IHomeRepository>()),
    );
    i.add<DeleteConstellationLinesUsecase>(
      () => DeleteConstellationLinesUsecase(Modular.get<IHomeRepository>()),
    );

    // ---------- 🧱 CUBITS ----------
    i.addSingleton<ConstellationCubit>(
      () => ConstellationCubit(
        connectionService: Modular.get<ConstellationConnectionService>(),
        getAllConstellationLinesUsecase:
            Modular.get<GetAllConstellationLinesUsecase>(),
        saveConstellationLinesUsecase:
            Modular.get<SaveConstellationLinesUsecase>(),
        deleteConstellationLinesUsecase:
            Modular.get<DeleteConstellationLinesUsecase>(),
      ),
    );
    i.addSingleton<HomeCubit>(
      () => HomeCubit(
        getFixedConstellationsUsecase:
            Modular.get<GetFixedConstellationsUsecase>(),
        saveNoteUsecase: Modular.get<SaveNoteUsecase>(),
        getAllNotesUsecase: Modular.get<GetAllNotesUsecase>(),
        deleteNoteUsecase: Modular.get<DeleteNoteUsecase>(),
      ),
    );
    i.add<EditNoteCubit>(
      () => EditNoteCubit(
        layoutService: Modular.get<ConstellationLayoutService>(),
        getFixedConstellationsUsecase:
            Modular.get<GetFixedConstellationsUsecase>(),
        saveNoteUsecase: Modular.get<SaveNoteUsecase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      HomeRoutes.init,
      child: (_) => HomePage(cubit: Modular.get<HomeCubit>()),
    );
    r.child(
      HomeRoutes.editNote,
      child: (_) {
        final args = Modular.args.data as Map<String, dynamic>;

        return EditNotePage(
          cubit: Modular.get<EditNoteCubit>(),
          existingNote: args['existingNote'] as NoteEntity?,
          allNotes: args['allNotes'] as List<NoteEntity>,
        );
      },
    );
  }
}
