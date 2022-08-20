import 'package:flutter/material.dart';
import 'package:shoptemp/models/category_model.dart';

List<IconData> icons = [
  Icons.electric_bolt_outlined,
  Icons.coronavirus_outlined,
  Icons.sports_basketball_outlined,
  Icons.light,
  Icons.person
];

List<Color> Acolors = [
  Color.fromARGB(255, 94, 208, 153),
  Colors.amberAccent.shade700,
  Colors.redAccent.shade700,
  Colors.blueAccent
];

class CategoryWidget extends StatelessWidget {
  final CategoryDataItem categoryDataItem;
  final int index;
  const CategoryWidget(
      {Key? key, required this.categoryDataItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Icon(icons[index]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(categoryDataItem.name!),
              ),
              Container(
                width: size.width * 0.26,
                height: 5,
                decoration: BoxDecoration(
                  color: Acolors[index % 4],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
