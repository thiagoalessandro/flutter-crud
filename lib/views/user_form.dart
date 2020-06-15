import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState(); 
}

class _UserFormState extends State<UserForm> {

  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = Map();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
                Provider.of<UsersProvider>(context, listen: false).put(User(
                  id: _formData['id'],
                  name: _formData['nome'],
                  email: _formData['email'],
                  avatarUrl: _formData['url'],
                ));
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['nome'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.length <= 3) {
                    return 'Nome inválido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['nome'] = value;
                },
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) {
                  _formData['email'] = value;
                },
              ),
              TextFormField(
                initialValue: _formData['url'],
                decoration: InputDecoration(labelText: 'URL Avatar'),
                onSaved: (value) {
                  _formData['url'] = value;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loadFormData(User user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['nome'] = user.name;
      _formData['email'] = user.email;
      _formData['url'] = user.avatarUrl;
    }
  }
}
