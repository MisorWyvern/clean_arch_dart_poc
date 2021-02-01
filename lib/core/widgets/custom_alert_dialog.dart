import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String bodyText;
  final Function onConfirm;

  const CustomAlertDialog({
    Key key,
    @required this.title,
    this.bodyText,
    @required this.onConfirm,
  })  : assert(title != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: bodyText != null
          ? SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(bodyText),
                ],
              ),
            )
          : null,
      actions: <Widget>[
        Container(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: onConfirm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.check,
                        color: Theme.of(context).textTheme.headline5.color,
                      ),
                      Text(
                        "Approve",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.delete,
                          color: Theme.of(context).textTheme.headline5.color),
                      Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
