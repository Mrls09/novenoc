import 'package:flutter/material.dart';

class ProfileClientScreen extends StatefulWidget{
  final String name;
  const ProfileClientScreen({super.key, required this.name});
  @override
  _ProfileClientScreenState createState() => _ProfileClientScreenState();
}

class _ProfileClientScreenState extends State<ProfileClientScreen> {
  @override
  void initState(){
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  closeState(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}