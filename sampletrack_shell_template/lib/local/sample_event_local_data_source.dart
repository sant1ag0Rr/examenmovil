import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../models/sample_event.dart';

class SampleEventLocalDataSource {
  SampleEventLocalDataSource(this.db);

  final AppDatabase db;

  SampleEvent _toDomain(SampleEventRow row) {
    return SampleEvent(
      id: row.id,
      sampleId: row.sampleId,
      type: row.type,
      createdAt: row.createdAt,
    );
  }

  SampleEventsCompanion _toCompanion(SampleEvent event) {
    return SampleEventsCompanion.insert(
      id: event.id,
      sampleId: event.sampleId,
      type: event.type,
      createdAt: event.createdAt,
    );
  }

  // 1. Guardar o actualizar un evento sin duplicarlo
  Future<void> saveEvent(SampleEvent event) async {
    await db.into(db.sampleEvents).insertOnConflictUpdate(_toCompanion(event));
  }

  // 2. Guardar como caché los eventos traídos de Firestore
  Future<void> saveEvents(List<SampleEvent> events) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.sampleEvents,
        events.map(_toCompanion).toList(),
      );
    });
  }

  // 3. Consultar solo los eventos de una muestra
  Future<List<SampleEvent>> getEventsForSample(String sampleId) async {
    final rows = await (db.select(db.sampleEvents)
          ..where((tbl) => tbl.sampleId.equals(sampleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();
    return rows.map(_toDomain).toList();
  }

  // 4. Consultar todos los eventos guardados
  Future<List<SampleEvent>> getAllEvents() async {
    final rows = await db.select(db.sampleEvents).get();
    return rows.map(_toDomain).toList();
  }
}