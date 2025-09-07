import 'package:flutter/material.dart';
import 'package:pmsn20252/widgets/item_row_widget.dart';
import 'package:pmsn20252/models/troop_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: troop.length,
      itemBuilder: (context, index) {
        return ItemRow(troop: troop[index]);
      },
    );
  }
}
