///Module
class Module {
  final List<Type>? imports;
  final List<Type>? controllers;
  final List<Type>? providers;
  const Module({this.imports, this.controllers, this.providers});
}
