import 'package:equatable/equatable.dart';
 
class AuthEntity extends Equatable {
  final String? id;
  
  final String? image;
  final String email;
 
  final String firstName;
  final String password;
  final String lastName;
 
  const AuthEntity({
    this.id,
    
    this.image,
    required this.email,
    required this.firstName,
    required this.password,
    required this.lastName,
  });
 
  @override
  List<Object?> get props =>
      [id,  image, firstName, password,email, lastName];

      
}
 