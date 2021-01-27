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
  }) : assert(name != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).textTheme.headline6.color,),
        title: Text(
          name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: IconButton(
          icon: Icon(Icons.check_circle, color: Theme.of(context).accentColor,),
          onPressed: onCheckIconPressed,
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
