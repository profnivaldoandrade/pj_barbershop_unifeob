import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/constants.dart';

class BarberShopLoader extends StatelessWidget {
  const BarberShopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: ColorsConstants.brow,
        size: 60,
      ),
    );
  }
}
