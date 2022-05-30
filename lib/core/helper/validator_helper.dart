import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:varcore_flutter_base/core/app/app_constant.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';

class SizeValidator {
  static Future<bool> lessThan(String filepath, int sizeMb) async {
    var file = File(filepath);
    int bytes = await file.length();
    var size = (bytes/1024)/1000;
    debugPrint("Size Validator : $size MB");
    if(size >= sizeMb) {
      Toast.show(AppConst.validSize);
      return false;
    }
    return true;
  }
}

class FieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Kolom tidak boleh kosong!";
    }
    return null;
  }
}

class TelephoneFieldValidator {
  static String? validate(String value) {
    // if (value.isEmpty || !PhoneNumberValidator.validate(value)) {
    //   return "No.Telepon tidak valid!";
    // }
    return null;
  }
}

class EmailFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty || !EmailValidator.validate(value)) {
      return "Email tidak valid!";
    }
    return null;
  }
}

class PasswordLoginFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong!";
    }
    return null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong!";
    } else if (!PasswordValidator.validateAll(value)) {
      return "Password tidak valid!";
    }
    return null;
  }
}

class NikFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "NIK tidak boleh kosong!";
    } else if (value.length != 16) {
      return "NIK tidak valid";
    }
    return null;
  }
}

class NpwpFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "NPWP tidak boleh kosong!";
    } else if (value.length != 15) {
      return "NPWP tidak valid";
    }
    return null;
  }
}

class KodePosFieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Kode Pos tidak boleh kosong!";
    } else if (!KodePosValidator.validate(value)) {
      return "Kode Pos tidak valid!";
    }
    return null;
  }
}

//--------------------------------------------------------------------
//                          REGEX
//--------------------------------------------------------------------

class PhoneNumberValidator {
  static validate(String phoneNumber) {
    RegExp regex = RegExp(r"^(08)(\d{3,4}-?){2}\d{3,4}$");
    if (!regex.hasMatch(phoneNumber)) {
      return false;
    } else {
      return true;
    }
  }
}

// Minimum 8 characters, at least one uppercase letter, one lowercase letter and one number:
// ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$

// Minimum 8 characters, at least one uppercase, one lowercase, and one number:
// (?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+=-{};:'",<.>?`\/\|~-]{8,}

// Minimum 8 characters, at least one uppercase, one lowercase, one number and one special character:
// ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+=-{};:'",<.>?`\/\|~-])[A-Za-z\d!@#$%^&*()_+=-{};:'",<.>?`\/\|~-]{8,}$

class PasswordValidator {
  static validateAll(String password) {
    RegExp regex = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+=-{};:',<.>?`\/\|~-]{8,}$");
    if (!regex.hasMatch(password)) {
      return false;
    }
    return true;
  }

  static containUppercase(String password) {
    RegExp regex = RegExp(r"^(?=.*[A-Z])");
    if (!regex.hasMatch(password)) {
      return false;
    }
    return true;
  }

  static containLowercase(String password) {
    RegExp regex = RegExp(r"^(?=.*[a-z])");
    if (!regex.hasMatch(password)) {
      return false;
    }
    return true;
  }

  static containNumber(String password) {
    RegExp regex = RegExp(r"^(?=.*\d)");
    if (!regex.hasMatch(password)) {
      return false;
    }
    return true;
  }
}

class EmailValidator {
  static validate(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(email)) {
      return false;
    } else {
      return true;
    }
  }
}

class KodePosValidator {
  static validate(String phoneNumber) {
    RegExp regex = RegExp(r"^([1-9])[0-9]{4}$");
    if (!regex.hasMatch(phoneNumber)) {
      return false;
    } else {
      return true;
    }
  }
}
