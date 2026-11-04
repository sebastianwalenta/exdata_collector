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

import 'package:exdata_collector/AboutScreen.dart';
import 'package:exdata_collector/Helpers/SelfTheme.dart';
import 'package:exdata_collector/Services/LocalDatabaseService/LocalDataManager.dart';
import 'package:exdata_collector/Services/SettingsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exdata_collector/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  void _deleteData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.deleteConfirmTitle),
          content: Text(l10n.deleteConfirmContent),
          actions: <Widget>[
            ElevatedButton(
              child: Text(l10n.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(l10n.delete),
              onPressed: () {
                LocalDataManager.shared.deleteAll();
                _loadItems();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        builder: (context) => addNewBoatScreen(),
      ),
    ).then((_){_loadItems();});
  }
  void _Synchronize() async {
    await OnlineSaver.Synchronize(context: context);
    await _loadItems();
  }


  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }
  void _navigateToAbout() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AboutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(l10n.appTitle),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'delete') {
                _deleteData();
              } else if (result == 'settings') {
                _navigateToSettings();
              } else if (result == "about")
              {
                _navigateToAbout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'settings',
                child: Text(l10n.settings),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text(l10n.deleteData),
              ),
              PopupMenuItem<String>(
                value: 'about',
                child: Text(l10n.about),
              ),
            ],
          ),
        ],
      ),
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

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'uniqueTag1',
            onPressed: () {_navigateToNewScreen(-1);},
            tooltip: l10n.addScore,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'uniqueTag2',
            onPressed: _navigateToNewBoat,
            tooltip: l10n.addBoat,
            child: const Icon(Icons.directions_boat),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'uniqueTag6',
            onPressed: _navigateNewRace,
            tooltip: l10n.addRace,
            child: const Icon(Icons.date_range),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'uniqueTag3',
            onPressed: _Synchronize,
            tooltip: l10n.synchronize,
            child: const Icon(Icons.sync),
          ),
        ],
      ),
    );
  }
}

