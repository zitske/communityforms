String exeptionset(int _error) {
  print("Exeption found");

  switch (_error) {
    case 0:
      print("Case 0");
      return "Email value Can\'t Be Empty";
      break;
    case 1:
      print("Case 1");
      return "Password value Can\'t Be Empty";
      break;
    case 2:
      print("Case 2");

      return "The password must contain at least 6 characters";
      break;
    case 3:
      print("Case 3");
      return "Invalid email format";
      break;
    case 4:
      print("Case 4");
      return "Wrong credentials/not registred";
      break;
    case 5:
      print("Case 5");
      print("All right");
      break;
  }
}
