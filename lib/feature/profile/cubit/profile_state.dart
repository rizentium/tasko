part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final User? data;

  const ProfileState({this.data});
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({super.data});
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({super.data});
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({super.data, required this.message});
}

class ProfileSignedOut extends ProfileState {}
