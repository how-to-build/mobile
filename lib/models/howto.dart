class HowTo {
    final int id;
    final String role;
    final String avatar;    
    final String username;
    final int howToId;
    final String title;
    final String description;
    final int likes;


HowTo.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['id'],
    role = jsonMap['role'],
    avatar = jsonMap['avatar'],
    username = jsonMap['username'],
    howToId = jsonMap['howToId'],
    title = jsonMap['title'],    
    description = jsonMap['description'],
    likes = jsonMap['likes'];
}