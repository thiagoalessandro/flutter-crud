import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

  @override
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (contexto) => UsersProvider()
      )
    ],
    child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            AppRoutes.HOME: (_) => UserList(),
            AppRoutes.USER_FORM: (_) => UserForm()
          },
        )
    );
  }
}
