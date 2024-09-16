class AppUtility {

  // Regular expression to allow only alphabets, spaces, and apostrophes
  static bool isValidName(String name) =>
      RegExp(r"^[a-zA-Z\s']+").hasMatch(name);

  // Regular expression to allow only Number
  static bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
          .hasMatch(value ?? '');

  // Regular expression to allow only vlaid email
  static bool isEmailValid(String email) =>
      RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
          .hasMatch(email);

}
