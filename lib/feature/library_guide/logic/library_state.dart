part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

final class LoadingBooks extends LibraryState {}

final class SuccessBooks extends LibraryState {}

final class ErrorBooks extends LibraryState {}
