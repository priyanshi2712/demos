import 'package:flutter/material.dart';

class CoustomTextFild extends StatefulWidget {
  const CoustomTextFild(
      {Key? key,
      required this.customController,
      required this.text,
      required this.textLabel,
      required this.icons})
      : super(key: key);

  final TextEditingController? customController;
  final String? text;
  final Widget? textLabel;
  final Widget? icons;
  
  @override
  State<CoustomTextFild> createState() => _CoustomTextFildState();
}

class _CoustomTextFildState extends State<CoustomTextFild> {
  // final GlobalKey<FormState> _insertFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: TextFormField(
            controller: widget.customController,
            validator: (value) {
              if (value != null) {
                return widget.text;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: widget.textLabel,
              prefixIcon: widget.icons,
            ),
          ),
        )
      ],
    );
  }
}
