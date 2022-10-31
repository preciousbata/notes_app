import 'package:get_it/get_it.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/repository/archive_note_repository.dart';
import 'package:notes_app/repository/note_repository.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => NoteRepository(sl.get()));
  sl.registerSingleton(() => FirestoreDatabaseService(sl.get()));
  sl.registerLazySingleton(() => ArchiveNoteRepository(sl.get(), sl.get()));
}