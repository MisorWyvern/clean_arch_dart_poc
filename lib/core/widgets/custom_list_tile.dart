import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Function onTap;
  final Function onLongPress;
  final Function onCheckIconPressed;

  const CustomListTile({
    Key key,
    @required this.name,
    @required this.description,
    this.icon = Icons.wysiwyg,
    this.onTap,
    this.onLongPress,
    this.onCheckIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).textTheme.headline6.color,
        ),
        title: Text(
          name ?? "",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          description ?? "",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Container(
          width: 8.0 * 7,
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: onCheckIconPressed,
            child: Icon(
              Icons.check,
              color: Theme.of(context).textTheme.headline5.color,
            ),
          ),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
