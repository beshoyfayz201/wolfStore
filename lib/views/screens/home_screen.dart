import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/cubit/drug_cubit.dart';
import 'package:shoptemp/views/widgets/input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("drug price"),
          backgroundColor: Colors.blueGrey,
        ),
        body: BlocConsumer<DrugCubit, DrugState>(
          builder: (context, state) {
            DrugCubit drugCubit = DrugCubit.get(context);
            if (state is! SearchLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("enter your drug"),
                  Expanded(
                      child: ListView.builder(
                    itemCount: drugCubit.myDrugs.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(drugCubit.myDrugs[index].name),
                      subtitle:
                          Text("Price : " + drugCubit.myDrugs[index].price),
                    ),
                  ))
                ],
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ));
            }
          },
          listener: (context, state) {
            print(state);
          },
        ));
  }
}
