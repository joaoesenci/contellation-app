import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/services/note_storage/note_storage_service.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:constellation_app/features/home/domain/usecases/delete_note_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_all_notes_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/save_note_usecase.dart';
import 'package:constellation_app/features/home/external/datasources/home_datasource_impl.dart';
import 'package:constellation_app/features/home/home_routes.dart';
import 'package:constellation_app/features/home/infra/datasources/home_datasource.dart';
import 'package:constellation_app/features/home/infra/repositories/home_repository_impl.dart';
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

    // ---------- 🧱 CUBITS ----------
    i.addSingleton<HomeCubit>(
      () => HomeCubit(
        getFixedConstellationsUsecase:
            Modular.get<GetFixedConstellationsUsecase>(),
        saveNoteUsecase: Modular.get<SaveNoteUsecase>(),
        getAllNotesUsecase: Modular.get<GetAllNotesUsecase>(),
        deleteNoteUsecase: Modular.get<DeleteNoteUsecase>(),
      ),
    );
    i.addSingleton<EditNoteCubit>(
      () => EditNoteCubit(
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
      child: (_) => EditNotePage(
        cubit: Modular.get<EditNoteCubit>(),
        existingNote: Modular.args.data as NoteEntity?,
      ),
    );
  }
}
