import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const TodoApp());
}

// Dark charcoal background and surfaces
const Color _kBackground = Color(0xFF0E1014);
const Color _kSurface = Color(0xFF1A1D25);
const Color _kAccent = Color(0xFF6C63FF);

// ============================================================
// ASSIGNMENT 5: TODO LIST APP WITH STATE
// Concepts:
// - StatefulWidget
// - setState()
// - Add Todo
// - Delete Todo
// - Mark Todo as Complete / Incomplete
// ============================================================

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _kBackground,
        canvasColor: _kBackground,
        cardColor: _kSurface,
        colorScheme: const ColorScheme.dark(
          primary: _kAccent,
          secondary: _kAccent,
          surface: _kSurface,
          error: Color(0xFFFF5252),
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _kBackground,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _kAccent;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          side: const BorderSide(color: _kAccent, width: 1.6),
        ),
      ),
      home: const TodoScreen(),
    );
  }
}

// ============================================================
// TODO SCREEN - STATEFUL WIDGET
// ============================================================

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

// ============================================================
// STATE CLASS
// ============================================================

class _TodoScreenState extends State<TodoScreen> {
  // Controller to read text entered by the user
  final TextEditingController _controller = TextEditingController();

  // List containing all todo tasks
  final List<Todo> _todos = [
    Todo(title: 'Complete Flutter assignment'),
    Todo(title: 'Study StatefulWidget'),
    Todo(title: 'Practice setState'),
  ];

  // ==========================================================
  // ADD TODO
  // ==========================================================

  void _addTodo() {
    final String task = _controller.text.trim();

    // Do not add an empty task
    if (task.isEmpty) {
      return;
    }

    setState(() {
      _todos.add(
        Todo(title: task),
      );
    });

    // Clear input field after adding
    _controller.clear();

    // Hide keyboard
    FocusScope.of(context).unfocus();
  }

  // ==========================================================
  // DELETE TODO
  // ==========================================================

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  // ==========================================================
  // MARK TODO COMPLETE / INCOMPLETE
  // ==========================================================

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isCompleted =
          !_todos[index].isCompleted;
    });
  }

  // ==========================================================
  // DISPOSE CONTROLLER
  // ==========================================================

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD UI
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final int completedTasks =
        _todos.where((todo) => todo.isCompleted).length;

    return Scaffold(
      backgroundColor: _kBackground,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: _kBackground,
        title: const Text(
          'My Todo List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [

              // ======================================================
              // HEADER
              // ======================================================

              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _kAccent.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        const Icon(
                          Icons.check_circle_outline,
                          color: _kAccent,
                          size: 45,
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Stay Organized!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                '$completedTasks of ${_todos.length} tasks completed',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _todos.isEmpty
                            ? 0
                            : completedTasks / _todos.length,
                        minHeight: 8,
                        backgroundColor: Colors.white12,
                        color: _kAccent,
                      ),
                    ),
                  ],
                ),
              ),

              // ======================================================
              // ADD TODO FIELD
              // ======================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: _kAccent,

                        decoration: InputDecoration(
                          hintText: 'Enter a new task...',
                          hintStyle: const TextStyle(
                            color: Colors.white38,
                          ),
                          prefixIcon: const Icon(
                            Icons.edit_note,
                            color: _kAccent,
                          ),

                          filled: true,
                          fillColor: _kSurface,

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: _kAccent,
                              width: 1.5,
                            ),
                          ),
                        ),

                        // Pressing Enter also adds the task
                        onSubmitted: (_) => _addTodo(),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // ADD BUTTON
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: ElevatedButton(
                        onPressed: _addTodo,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),

                        child: const Icon(
                          Icons.add,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ======================================================
              // TODO LIST
              // ======================================================

              Expanded(
                child: _todos.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [

                            Icon(
                              Icons.task_alt,
                              size: 70,
                              color: _kAccent,
                            ),

                            SizedBox(height: 15),

                            Text(
                              'No tasks yet!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'Add a task to get started.',
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),

                        itemCount: _todos.length,

                        itemBuilder: (context, index) {

                          final Todo todo = _todos[index];

                          return Card(
                            color: _kSurface,
                            margin:
                                const EdgeInsets.only(
                              bottom: 10,
                            ),

                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.white10,
                              ),
                            ),

                            child: ListTile(

                              // ==================================================
                              // CHECKBOX
                              // ==================================================

                              leading: Checkbox(
                                value: todo.isCompleted,
                                activeColor: _kAccent,
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: _kAccent,
                                  width: 1.6,
                                ),

                                onChanged: (_) {
                                  _toggleTodo(index);
                                },
                              ),

                              // ==================================================
                              // TASK NAME
                              // ==================================================

                              title: Text(
                                todo.title,

                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,

                                  decoration:
                                      todo.isCompleted
                                          ? TextDecoration
                                              .lineThrough
                                          : TextDecoration.none,

                                  decorationColor:
                                      Colors.white38,

                                  color:
                                      todo.isCompleted
                                          ? Colors.white38
                                          : Colors.white,
                                ),
                              ),

                              // ==================================================
                              // STATUS
                              // ==================================================

                              subtitle: Text(
                                todo.isCompleted
                                    ? 'Completed'
                                    : 'Pending',
                                style: TextStyle(
                                  color: todo.isCompleted
                                      ? _kAccent
                                      : Colors.white54,
                                ),
                              ),

                              // ==================================================
                              // DELETE BUTTON
                              // ==================================================

                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFFFF5252),
                                ),

                                onPressed: () {
                                  _deleteTodo(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TODO MODEL
// ============================================================

class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}
