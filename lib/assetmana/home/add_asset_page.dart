import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class AddAssetPage extends StatefulWidget {
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;

  const AddAssetPage({
    Key? key,
    this.onScreenHideButtonPressed,
    this.hideStatus = false,
  }) : super(key: key);

  State<AddAssetPage> createState() => _AddAssetPage();

}
class _AddAssetPage extends State<AddAssetPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Text(''),

              ),

              SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
