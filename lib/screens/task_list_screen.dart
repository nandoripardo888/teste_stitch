import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import 'create_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data based on the design
    final List<Task> tasks = [
      Task(
        name: 'Atualizar design do dashboard',
        description: '',
        dueDate: DateTime(2024, 12, 25),
        status: Status.emProgresso,
      ),
      Task(
        name: 'Corrigir bug na tela de login',
        description: '',
        dueDate: DateTime(2024, 12, 28),
        status: Status.pendente,
      ),
      Task(
        name: 'Desenvolver nova feature de relatório',
        description: '',
        dueDate: DateTime(2025, 1, 15),
        status: Status.emProgresso,
      ),
      Task(
        name: 'Publicar app na App Store',
        description: '',
        dueDate: DateTime(2025, 2, 1),
        status: Status.bloqueado,
      ),
      Task(
        name: 'Reunião de planejamento Sprint 5',
        description: '',
        dueDate: DateTime(2024, 12, 20),
        status: Status.concluido,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Tarefas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterAndSortButtons(context),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _TaskCard(task: tasks[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget _buildFilterAndSortButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildButton(context, 'Filtrar', Icons.filter_list),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildButton(context, 'Ordenar', Icons.sort),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: TextButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.white : Colors.black87,
        backgroundColor: isDarkMode ? Colors.blueGrey[900] : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.blueGrey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Vence em: ${DateFormat('dd/MM/yyyy').format(task.dueDate)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _StatusTag(status: task.status),
        ],
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final Status status;

  const _StatusTag({required this.status});

  @override
  Widget build(BuildContext context) {
    final Map<Status, Color> statusColors = {
      Status.pendente: Colors.orange,
      Status.emProgresso: Colors.blue,
      Status.concluido: Colors.green,
      Status.bloqueado: Colors.purple,
    };
    final Map<Status, String> statusText = {
      Status.pendente: 'Pendente',
      Status.emProgresso: 'Em Progresso',
      Status.concluido: 'Concluído',
      Status.bloqueado: 'Bloqueado',
    };
    final color = statusColors[status] ?? Colors.grey;
    final text = statusText[status] ?? 'Desconhecido';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
