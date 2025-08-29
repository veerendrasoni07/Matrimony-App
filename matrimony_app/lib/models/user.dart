import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullname;
  final String email;
  final String password;
  final String dob;
  final int age;
  final String height;
  final String weight;
  final String marital_status;
  final String state;
  final String city;
  final String address;
  final String religion;
  final String caste;
  final String subcaste;
  final String mother_tongue;
  final String gender;
  final String education;
  final String work;
  final String workRole;
  final String annual_income;
  final String diet;
  final String family_type;
  final String phone;
  final String image;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dob,
    required this.age,
    required this.height,
    required this.weight,
    required this.marital_status,
    required this.state,
    required this.city,
    required this.address,
    required this.religion,
    required this.caste,
    required this.subcaste,
    required this.mother_tongue,
    required this.gender,
    required this.education,
    required this.work,
    required this.workRole,
    required this.annual_income,
    required this.diet,
    required this.family_type,
    required this.phone,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'dob': dob,
      'age': age,
      'height': height,
      'weight': weight,
      'marital_status': marital_status,
      'state': state,
      'city': city,
      'address': address,
      'religion': religion,
      'caste': caste,
      'subcaste': subcaste,
      'mother_tongue': mother_tongue,
      'gender': gender,
      'education': education,
      'work': work,
      'workRole': workRole,
      'annual_income': annual_income,
      'diet': diet,
      'family_type': family_type,
      'phone': phone,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullname: map['fullname']  ?? '',
      email: map['email']  ?? '',
      password: map['password']  ?? '',
      dob: map['dob']  ?? '',
      age: map['age']  ?? 0,
      height: map['height']  ?? '',
      weight: map['weight'] ?? '',
      marital_status: map['marital_status'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      religion: map['religion'] ?? '',
      caste: map['caste'] ?? '',
      subcaste: map['subcaste'] ?? '',
      mother_tongue: map['mother_tongue'] ?? '',
      gender: map['gender'] ?? '',
      education: map['education'] ?? '',
      work: map['work'] ?? '',
      workRole: map['workRole'] ?? '',
      annual_income: map['annual_income'] ?? '',
      diet: map['diet'] ?? '',
      family_type: map['family_type'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  // ✅ copyWith method
  User copyWith({
    String? id,
    String? fullname,
    String? email,
    String? password,
    String? dob,
    String? height,
    String? weight,
    String? marital_status,
    String? state,
    int? age,
    String? city,
    String? address,
    String? religion,
    String? caste,
    String? subcaste,
    String? mother_tongue,
    String? gender,
    String? education,
    String? work,
    String? workRole,
    String? annual_income,
    String? diet,
    String? family_type,
    String? phone,
    String? image,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      dob: dob ?? this.dob,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      marital_status: marital_status ?? this.marital_status,
      state: state ?? this.state,
      age: age ?? this.age,
      city: city ?? this.city,
      address: address ?? this.address,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subcaste: subcaste ?? this.subcaste,
      mother_tongue: mother_tongue ?? this.mother_tongue,
      gender: gender ?? this.gender,
      education: education ?? this.education,
      work: work ?? this.work,
      workRole: workRole ?? this.workRole,
      annual_income: annual_income ?? this.annual_income,
      diet: diet ?? this.diet,
      family_type: family_type ?? this.family_type,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }
}
