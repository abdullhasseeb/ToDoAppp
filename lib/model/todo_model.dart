class TodoModel{
  final int? id;
  final String title;
  final String description;
  int checkbox;

  TodoModel({
    required this.title,
    required this.description,
    this.id,
    this.checkbox = 0
  });

  factory TodoModel.fromMap(Map<String, dynamic> map){
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      checkbox: map['checkbox']
    );
  }

  Map<String, Object?> toMap(){
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'checkbox' : checkbox
    };
  }


}


