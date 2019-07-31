class Todo {
  String id;
  String note;
  String task;
  bool isDone = false;

  Todo({this.id, this.note, this.isDone = false, this.task});
  
  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        id: data['id'],
        note: data['note'],
        task: data['task'],
        isDone: data['isDone'] == 0 ? false : true,
  );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "note": this.note,
        "task": this.task,
        "isDone": this.isDone == false ? 0 : 1,
  };

  Todo copyWith({bool isDone, String id, String note, String task}) {
    return Todo(
      id: id ?? this.id,
      note: note ?? this.note,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }
}