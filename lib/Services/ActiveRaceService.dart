import 'dart:convert';

import 'package:exdata_collector/Models/ActiveRace.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveRaceService {
  static final ActiveRaceService shared = ActiveRaceService._internal();
  static const String _activeRaceKey = 'activeRaceKey';

  ActiveRace? _activeRace;
  ActiveRace? get activeRace => _activeRace;

  bool isRaceActive() => _activeRace != null;

  ActiveRaceService._internal() {
    tryLoadActiveRace();
  }

  Future<ActiveRace?> tryLoadActiveRace() async {
    var prefs = await SharedPreferences.getInstance();
    String? rawData = prefs.getString(_activeRaceKey);
    if (rawData == null || rawData.isEmpty) {
      _activeRace = null;
      return null;
    }
    try {
      ActiveRace ar = ActiveRace.fromJson(jsonDecode(rawData));
      _activeRace = ar;
      return ar;
    } catch (e) {
      _activeRace = null;
      return null;
    }
  }

  Future<void> setActiveRace(ActiveRace activeRace) async {
    _activeRace = activeRace;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeRaceKey, jsonEncode(activeRace.toJson()));
  }

  Future<void> clearActiveRace() async {
    _activeRace = null;
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeRaceKey);
  }
}
