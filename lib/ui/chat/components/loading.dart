import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
