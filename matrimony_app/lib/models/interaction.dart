// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Interaction {
  final String fromUser;
  final String toUser;
  final String status;

  Interaction({required this.fromUser, required this.toUser, required this.status});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromUser': fromUser,
      'toUser': toUser,
      'status': status,
    };
  }

  factory Interaction.fromMap(Map<String, dynamic> map) {
    return Interaction(
      fromUser: map['fromUser'] as String,
      toUser: map['toUser'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Interaction.fromJson(String source) => Interaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
