import 'package:flutter/material.dart';
class OverlayScreen {

  overlay(BuildContext context,int value){
    OverlayState overlayState=Overlay.of(context);
    OverlayEntry overlayEntry=OverlayEntry(
      builder: (context)=>Positioned(
        top:40,
        right: 10,
        child:CircleAvatar(radius: 10.0,
        backgroundColor: Colors.red,
        child: Text(value.toString()),)
      )
    );
    
    overlayState.insert(overlayEntry);

  }

}