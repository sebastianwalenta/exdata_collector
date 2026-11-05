import 'Models/Boat.dart';
import 'Models/Race.dart';
import 'Services/OnlineSaver.dart';
import 'addNewBoatScreen.dart';
import 'addNewScoreScreen.dart';
import 'addNewRaceScreen.dart';
import 'runList.dart';
import "Models/Run.dart";
import 'settingsScreen.dart';
import 'raceRunList.dart';
import 'ActiveRacePage.dart';
import 'Components/bottom_menu.dart';

import 'package:exdata_collector/Services/LocalDatabaseService/LocalDataManager.dart';
import 'package:flutter/material.dart';
import 'package:exdata_collector/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Boat> _items = [];
  List<Race> races=[];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  _loadItems() async {
    List<Boat> loadedItems = await LocalDataManager.shared.loadAll<Boat>(Boat);
    List<Race> loadedRaces = await LocalDataManager.shared.loadAll<Race>(Race);
    setState(() {
      races=loadedRaces;
      _items = loadedItems;
    });
  }

  void _navigateToNewScreen(int from) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => addNewScoreScreen(from: from,),
      ),
    );
  }
  void  _navigateRunList(int boatID) async {
    List<Run> runlist=await LocalDataManager.shared.loadByParam<Run>(Run,"boatID",boatID.toString());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RunList(items: runlist,),
      ),
    ).then((_){_loadItems();});
  }
  void _navigateToRaceRunList(int raceId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RaceRunList(raceId: raceId),
      ),
    );
  }

  void  _navigateNewRace() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewRaceScreen(),
      ),
    ).then((_){_loadItems();});
  }

  void _navigateToNewBoat() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const addNewBoatScreen(),
      ),
    ).then((_){_loadItems();});
  }
  void _Synchronize() async {
    await OnlineSaver.Synchronize(context: context);
    await _loadItems();
  }

  void _navigateToActiveRace() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActiveRacePage(),
      ),
    );
    _loadItems();
  }

  void _navigateToSettings() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              l10n.boats,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_items[index].name.toString()),
                  subtitle: Text(_items[index].boatClass.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.list),
                    tooltip: l10n.viewRuns,
                    onPressed: () {
                      if (_items[index].dbID == 0) {
                        _navigateRunList(_items[index].bID);
                      } else {
                        _navigateRunList(_items[index].dbID);
                      }
                    },
                  ),
                  onTap: () {
                    _navigateToNewScreen(_items[index].bID);
                  },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              l10n.races,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: races.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(races[index].name.toString()),
                  subtitle: Text('${races[index].date.day.toString().padLeft(2, '0')}/${races[index].date.month.toString().padLeft(2, '0')}/${races[index].date.year}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.list),
                    tooltip: l10n.viewRuns,
                    onPressed: () {
                      _navigateToRaceRunList(races[index].rcid);
                    },
                  ),
                  onTap: () {
                    _navigateToRaceRunList(races[index].rcid);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(
        onAddScore: () => _navigateToNewScreen(-1),
        onAddBoat: _navigateToNewBoat,
        onAddRace: _navigateNewRace,
        onActiveRace: _navigateToActiveRace,
        onSynchronize: _Synchronize,
        onSettings: _navigateToSettings,
      ),
    );
  }
}
