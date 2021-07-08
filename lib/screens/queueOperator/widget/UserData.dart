class UserData {

  static List<String> users = [];
  static List repos = [];
  static List tempRepo = [];




  static List<String> getSuggestions(String query) {
    tempRepo = [];
    List<String> temp = [];
    print('${repos.length} ${users.length}');
    for (int i = 0; i<users.length; i++){
      final lowerQuery = query.toLowerCase();
      final lowerUser = users[i].toLowerCase();
      if(lowerUser.contains(lowerQuery)){
        temp.add(users[i]);
        tempRepo.add(repos[i]);
      }
    }
    return temp;
  }
}
