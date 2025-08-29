import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony_app/models/user.dart';

class UserProvider extends StateNotifier<User?>{
  UserProvider():super(
    User(
        id: '',
        fullname: '',
        email: '',
        password: '',
        dob: '',
        height: '',
        weight: '',
        marital_status: '',
        state: '',
        age: 0,
        city: '',
        address: '',
        religion: '',
        caste: '',
        subcaste: '',
        mother_tongue: '',
        gender: '',
        education: '',
        work: '',
        workRole: '',
        annual_income: '',
        diet: '',
        family_type: '',
        phone: '',
        image: ''
    )
  );

  void setUser(String userJson){
    state = User.fromJson(userJson);
  }

  //
  // void setProfilePic(String image){
  //   state = new User(
  //       id: state!.id,
  //       fullname: state!.fullname,
  //       email: state!.email,
  //       password: state!.password,
  //       dob: state!.dob,
  //       age: state!.age,
  //       height: state!.height,
  //       weight: state!.weight,
  //       marital_status: state!.marital_status,
  //       state: state!.state,
  //       city: state!.city,
  //       address: state!.address,
  //       religion: state!.religion,
  //       caste: state!.caste,
  //       subcaste: state!.subcaste,
  //       mother_tongue: state!.mother_tongue,
  //       gender: state!.gender,
  //       education: state!.education,
  //       work: state!.work,
  //       workRole: state!.workRole,
  //       annual_income: state!.annual_income,
  //       diet: state!.diet,
  //       family_type: state!.family_type,
  //       phone: state!.phone,
  //       image: image
  //   );
  // }
  //
  void setProfilePic(String image){
    state = state!.copyWith(image: image);
  }

  void signOut(){
    state = null;
  }


}

final userProvider = StateNotifierProvider<UserProvider,User?>((ref) => UserProvider());