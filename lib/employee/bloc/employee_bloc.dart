import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqlite_bloc/employee/bloc/bloc.dart';
import 'package:flutter_sqlite_bloc/employee/models/employee.dart';
import 'package:flutter_sqlite_bloc/repository/repository.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  Repository repository;

  EmployeeBloc({@required this.repository});

  @override
  EmployeeState get initialState => EmployeeLoading();

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    if (event is LoadEmployee) {
      yield EmployeeLoading();
      yield* _reload();
    } else if (event is Add) {
      await repository.save(event.employee);
      yield* _reload();
    } else if (event is Delete) {
      await repository.delete(event.id);
      yield* _reload();
    } else if (event is Update) {
      await repository.update(event.updateEmployee);
      yield* _reload();
    }
  }

  Stream<EmployeeState> _reload() async* {
    try {
      List<Employee> employeeList = await repository.getEmployees();
      yield EmployeeListLoaded(employeeList: employeeList);
    } catch (ex) {
      yield EmployeeError(message: ex.toString());
    }
  }
}
