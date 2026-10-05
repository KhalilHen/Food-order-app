// !! An extra model specific for users personal information email, phonenumber, name. 
class AccountPersonalInformation {

final String email;
final String? firstName;
final String? phoneNumber;


const AccountPersonalInformation ({

  required this.email,
  this.firstName,
  this.phoneNumber
});

factory AccountPersonalInformation.fromJson(Map<String, dynamic> json )   {

return  AccountPersonalInformation(


email: json['email'] as String, 
firstName: json['first_name'] as String?, 
phoneNumber:  json['phone_number' ] as String?,

);

}

//TODO Add here  json method 
}

