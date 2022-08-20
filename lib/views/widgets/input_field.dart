import 'package:flutter/material.dart';

import 'package:shoptemp/control/bloc/cubit/drug_cubit.dart';

class InputField extends StatelessWidget {
  final String label;
  TextEditingController textEditingController;
  final IconData icon;
  InputField(
      {Key? key,
      required this.icon,
      required this.label,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        onSubmitted: ((v) {}),
        decoration: InputDecoration(
            suffix: Icon(icon),
            label: Text(label),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            )),
      ),
    );
  }

  void submitDrug(BuildContext context, String drugName) {
    DrugCubit.get(context).search(drugName);
  }
}

class DefaultFormField extends StatefulWidget {
  String hint;
  String label;
  IconData preIcon;
  bool visable;
  IconData? Suffix;
  TextEditingController textEditingController;
  DefaultFormField({
    Key? key,
    required this.hint,
    required this.label,
    required this.textEditingController,
    required this.preIcon,
    this.visable = false,
    this.Suffix,
  }) : super(key: key);

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: widget.visable,
        validator: ((value) {
          if (value!.isEmpty)
            return widget.label + "is too short";
          else
            return null;
        }),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            ),
            suffixIcon: (widget.label == "password")
                ? IconButton(
                    onPressed: () {
                      widget.visable = !widget.visable;
                      setState(() {});
                    },
                    icon: Icon(
                      widget.Suffix,
                      color:
                          widget.visable ? Colors.black : Colors.grey.shade300,
                    ),
                  )
                : null,
            prefixIcon: Icon(widget.preIcon),
            label: Text(widget.label),
            hintText: widget.hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            )),
        controller: widget.textEditingController,
      ),
    );
  }
}
