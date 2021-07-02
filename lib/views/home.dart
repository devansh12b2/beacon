// TODO: display list of beacons of a specific user in a sliding panel
import 'package:beacon/components/create_join_dialog.dart';
import 'package:beacon/components/hike_button.dart';
import 'package:beacon/components/shape_painter.dart';
import 'package:beacon/utilities/constants.dart';
import 'package:beacon/view_model/home_view_model.dart';
import 'package:beacon/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(builder: (context, model, child) {
      return model.isBusy
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: ModalProgressHUD(
                inAsyncCall: model.isCreatingHike,
                child: Stack(
                  children: <Widget>[
                    Scaffold(
                      body: Container(
                        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Center(
                          child: Image(
                            image: AssetImage('images/hikers_group.png'),
                          ),
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height),
                      painter: ShapePainter(),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          HikeButton(
                            text: 'Create Hike',
                            textColor: Colors.white,
                            borderColor: Colors.white,
                            buttonColor: kYellow,
                            buttonWidth: 64,
                            onTap: () {
                              CreateJoinBeaconDialog.createHikeDialog(
                                  context, model);
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 20,
                          ),
                          HikeButton(
                            text: 'Join a Hike',
                            textColor: kYellow,
                            borderColor: kYellow,
                            buttonColor: Colors.white,
                            buttonWidth: 64,
                            onTap: () async {
                              CreateJoinBeaconDialog.joinBeaconDialog(
                                  context, model);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}