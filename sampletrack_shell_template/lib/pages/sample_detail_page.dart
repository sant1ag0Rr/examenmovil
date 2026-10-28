import 'package:flutter/material.dart';

import '../models/sample.dart';

class SampleDetailPage extends StatelessWidget {
  const SampleDetailPage({
    super.key,
    required this.sample,
  });

  final Sample sample;

  void _showPendingMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad a implementar durante el examen.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sample.id)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SampleHeader(sample: sample),
          const SizedBox(height: 24),
          Text(
            'Historial de procesamiento',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          const _EmptyHistory(),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => _showPendingMessage(context),
            icon: const Icon(Icons.add),
            label: const Text('Registrar primer evento'),
          ),
        ],
      ),
    );
  }
}

class _SampleHeader extends StatelessWidget {
  const _SampleHeader({required this.sample});

  final Sample sample;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.science_outlined,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sample.id,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      const Chip(label: Text('Sin eventos')),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _InfoField(label: 'Tipo', value: sample.type),
                _InfoField(label: 'Origen', value: sample.origin),
                _InfoField(label: 'Prioridad', value: sample.priority),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.timeline_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'Esta muestra aun no tiene eventos de procesamiento.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
