import 'package:flutter/material.dart';
import 'package:news_app/core/constants.dart';
class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,children: [
Image.asset('${AppConstants.imgPath}error.png',width: MediaQuery.of(context).size.width * .55,fit: BoxFit.cover,),
const SizedBox(height: 7,),
Text(message,style: const TextStyle(fontSize: AppConstants.body2),),
    ],),);
  }
}