import 'package:flutter/material.dart';
import 'package:permission/permission.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String get = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Permisos Demo'),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              RaisedButton(onPressed: getPermissionStatus, child: new Text("Estado de todos los permisos")),
              RaisedButton(onPressed: requestPermissions, child: new Text("Respuesta de permiso camara y storage")),
              RaisedButton(onPressed: requestPermission, child: new Text("Respuesta de un permiso")),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Abrir configuración")),
              Text(get),
            ],
          ),
        ),
      ),
    );
  }

  getPermissionStatus() async {
    get = '';
    List<Permissions> permissions = await Permission.getPermissionStatus([PermissionName.Camera, PermissionName.Storage]);
    permissions.forEach((permission) {
      get += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      get;
    });
  }

  requestPermissions() async {
    final res = await Permission.requestPermissions([PermissionName.Camera, PermissionName.Storage]);
    res.forEach((permission) {
      if(permission.permissionStatus == PermissionStatus.allow){
        _Toast("Tienes todos los permisos",Colors.green);
      }else{
        _Toast("No tienes permisos",Colors.red);
        Permission.openSettings();
      }

    });
  }

  requestPermission() async {
    final res = await Permission.requestSinglePermission(PermissionName.Storage);
      if(res == PermissionStatus.allow){
        _Toast("Tienes el permiso de almacenamiento",Colors.green);
      }else{
        _Toast( "No tienes el permiso de almacenamiento",Colors.red);
        Permission.openSettings();
      }
  }

  void _Toast(String text, Color color){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: color,
        textColor: Colors.white
    );
  }
}