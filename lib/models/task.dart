enum Priority { baixa, media, alta, urgente }

enum Status { pendente, emProgresso, concluido, bloqueado }

class Task {
  final String name;
  final String description;
  final DateTime dueDate;
  final Priority priority;
  final Status status;

  Task({
    required this.name,
    required this.description,
    required this.dueDate,
    this.priority = Priority.media,
    this.status = Status.pendente,
  });
}
