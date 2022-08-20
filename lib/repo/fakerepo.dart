import 'package:shoptemp/models/drug.dart';

class FakeRepo {
  Future<List<Drug>> fetchDrug(String name) {
    return Future.delayed(Duration(seconds: 1),
        () => drugtest.where((durg) => durg.name.contains(name)).toList());
  }
}
