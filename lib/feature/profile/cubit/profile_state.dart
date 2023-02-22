part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSignedOut extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure({required this.message});
}
