import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqlite_bloc/employee/bloc/bloc.dart';
import 'package:flutter_sqlite_bloc/employee/employee.dart';
import 'package:flutter_sqlite_bloc/repository/repository.dart';
import 'package:flutter_sqlite_bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(repository: Repository()),
      child: MaterialApp(
        title: 'Flutter SQLite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Home(),
      ),
    );
  }
}
