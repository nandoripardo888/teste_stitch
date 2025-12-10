import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  DateTime? _selectedDate;
  Priority _selectedPriority = Priority.media;

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dueDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tarefas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _taskNameController,
                label: 'Nome da Tarefa',
                hint: 'Ex: Desenvolver nova landing page',
                icon: Icons.task_alt,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _descriptionController,
                label: 'Descrição',
                hint: 'Adicione mais detalhes sobre a tarefa...',
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              _buildDateField(context),
              const SizedBox(height: 24),
              _buildPriorityDropdown(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Handle task creation
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
          ),
          child: Text(
            'Criar Tarefa',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon) : null,
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.blueGrey[900] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, preencha este campo.';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data de Entrega', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dueDateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'mm/dd/yyyy',
            prefixIcon: const Icon(Icons.calendar_month),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.blueGrey[900] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onTap: () => _selectDate(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, selecione uma data.';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPriorityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prioridade', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<Priority>(
          value: _selectedPriority,
          items: Priority.values.map((Priority priority) {
            return DropdownMenuItem<Priority>(
              value: priority,
              child: Text(priority.toString().split('.').last[0].toUpperCase() + priority.toString().split('.').last.substring(1)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedPriority = newValue!;
            });
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.priority_high),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.blueGrey[900] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
