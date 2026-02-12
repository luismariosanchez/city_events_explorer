import 'package:city_events_explorer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeFilterSheet extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTimeRange?) onDateRangeSelected;

  const DateRangeFilterSheet({
    super.key,
    this.startDate,
    this.endDate,
    required this.onDateRangeSelected,
  });

  Future<void> openDateTimeRange(BuildContext context, bool hasRange) async {
    {
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        initialDateRange: hasRange
            ? DateTimeRange(start: startDate!, end: endDate!)
            : null,
      );

      if (picked != null) {
        onDateRangeSelected(picked);
      }
    }
  }

  String getRangeText(
      bool hasRange,
      DateFormat formatter,
      AppLocalizations l10n,
      ) {
    return hasRange
        ? '${formatter.format(startDate!)} - ${formatter.format(endDate!)}'
        : l10n.filterByRangeDateHint;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final formatter = DateFormat('dd MMM yyyy');

    final hasRange = startDate != null && endDate != null;

    final rangeText = getRangeText(hasRange, formatter, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          l10n.filterTitle,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => openDateTimeRange(context, hasRange),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1F),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white70),
                const SizedBox(width: 16),
                Text(rangeText, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),

        const Spacer(),

        if (hasRange)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => onDateRangeSelected(null),
              child: Text(
                l10n.clearFilter,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
      ],
    );
  }
}
