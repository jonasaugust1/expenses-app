import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    super.key,
    required this.label,
    required this.textController,
    required this.onSubmitted,
    this.keyboardType
  });

  final String label;
  final TextEditingController textController;
  final Function onSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ?
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        onSubmitted: (_) => onSubmitted(),
        controller: textController,
        placeholder: label,
        keyboardType: keyboardType,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 6, vertical: 12),
      ),
    )
    :
    TextField(
      controller: textController,
      keyboardType: keyboardType,
      onSubmitted: (_) => onSubmitted(),
      decoration: InputDecoration(
        labelText: label
      ),
    )
    ;
  }
}