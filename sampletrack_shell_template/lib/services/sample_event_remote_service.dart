import '../models/sample_event.dart';

/// Punto de inicio para la fuente remota.
///
/// La shell no incluye Firebase ni Cloud Firestore como dependencias.
class SampleEventRemoteService {
  Future<List<SampleEvent>> getEvents() async {
    // TODO: implementar lectura remota.
    throw UnimplementedError();
  }

  Future<void> saveEvent(SampleEvent event) async {
    // TODO: implementar escritura remota.
    throw UnimplementedError();
  }
}
