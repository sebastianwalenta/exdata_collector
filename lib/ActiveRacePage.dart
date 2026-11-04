import 'package:flutter/material.dart';
import 'package:exdata_collector/Models/ActiveRace.dart';
import 'package:exdata_collector/Services/ActiveRaceService.dart';
import 'package:exdata_collector/l10n/app_localizations.dart';

class ActiveRacePage extends StatefulWidget {
  const ActiveRacePage({Key? key}) : super(key: key);

  @override
  State<ActiveRacePage> createState() => _ActiveRacePageState();
}

class _ActiveRacePageState extends State<ActiveRacePage> {
  ActiveRace? _activeRace;

  @override
  void initState() {
    super.initState();
    _loadActiveRace();
  }

  void _loadActiveRace() {
    setState(() {
      _activeRace = ActiveRaceService.shared.activeRace;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.races ?? 'Aktivní závod'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aktivní závod',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (_activeRace != null) ...[
              const SizedBox(height: 16),
              Text('ID závodu: ${_activeRace!.raceId}'),
            ],
          ],
        ),
      ),
    );
  }
}
