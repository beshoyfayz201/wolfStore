import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/models/drug.dart';
import 'package:shoptemp/repo/fakerepo.dart';

part 'drug_state.dart';

class DrugCubit extends Cubit<DrugState> {
  FakeRepo fakeRepo;
  List<Drug> myDrugs = [];
  DrugCubit(this.fakeRepo) : super(DrugInitial());

  static DrugCubit get(BuildContext context) => BlocProvider.of(context);
  search(String name) async {
    emit(SearchLoading());
    myDrugs = await fakeRepo.fetchDrug(name);
    emit(DrugLoaded());
  }
}
