import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite_bloc/employee/models/employee.dart';

@immutable
abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeLoading extends EmployeeState {
  @override
  List<Object> get props => [];
}

class ShowTextField extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeListLoaded extends EmployeeState {
  List<Employee> employeeList;
  EmployeeListLoaded({@required this.employeeList});

  @override
  List<Object> get props => [employeeList];
}

class EmployeeError extends EmployeeState {
  final message;
  EmployeeError({@required this.message});
  @override
  List<Object> get props => [message];
}
