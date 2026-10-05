//TODO Add here validators for form fields



class Validator {
 String? validateEmail(String value) {

  if(value.isEmpty|| value.isEmpty ) {

    return 'Fill something in';

  }
  else if (!value.contains('@')) {
    return 'Fill a valid email in';
  }
  return null;
 } 


// use this package for phonenumbers
// https://pub.dev/packages/dlibphonenumber
//  String? validatePhone(String value) {

//   if('^[+]{1}(?:[0-9-()/.]s?){6, 15}[0-9]{1}$') {

//   }
//   return null;
//  }
}

