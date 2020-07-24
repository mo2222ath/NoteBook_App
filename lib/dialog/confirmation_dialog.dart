import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/localization/demo_localization.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatelessWidget {
  String msg;

  ConfirmationDialog(this.msg);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'images/sad.png',
                  height: 120,
                  width: 120,
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              msg,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                DemoLocalizations.of(context).getTranslateValue("ConfirmationDialogHint"),
                style: TextStyle(color: Colors.lime, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      DemoLocalizations.of(context).getTranslateValue("no"),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  RaisedButton(
                    onPressed: () {
                      return Navigator.of(context).pop(true);
                    },
                    child: Text(
                      DemoLocalizations.of(context).getTranslateValue("yes"),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.redAccent,
                  )
                ],
              ),
            )

          ],
        ),
      );
}
