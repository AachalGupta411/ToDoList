# 📋 Todo List App

A Flutter Todo List application developed as part of the Flutter Development coursework. The project demonstrates local state management using `StatefulWidget` and `setState()`.

The application allows users to add new tasks, mark tasks as completed, and delete tasks. The interface updates immediately whenever the task state changes.

## 🎯 Assignment Objective

Build a fully functional Todo List application using:

- `StatefulWidget`
- `setState()`
- Add task functionality
- Delete task functionality
- Mark task as completed functionality

## ✨ Features

- ➕ Add new tasks
- ✅ Mark tasks as completed
- 🗑️ Delete tasks
- 📊 Display completed task count
- 🔄 Real-time UI updates using `setState()`
- ✏️ Strike-through effect for completed tasks
- 🌙 Modern dark-themed interface
- 📱 Responsive Flutter UI

## 🛠️ Technologies Used

- **Flutter** – UI and application development
- **Dart** – Programming language
- **StatefulWidget** – Local state management
- **setState()** – Updating application state and rebuilding the UI
- **Material Design** – UI components

## 🧠 State Management

The application uses Flutter's built-in state management through `StatefulWidget` and `setState()`.

The task list is maintained inside the state of the widget. Whenever a task is added, completed, or deleted, `setState()` is called so that Flutter rebuilds the UI with the updated information.

### Add Task

When the user enters a task and presses the add button, the new task is added to the task list and the interface updates immediately.

### Complete Task

Each task contains a checkbox. Selecting the checkbox changes the completion state of that task and displays a strike-through effect.

### Delete Task

The delete button removes the selected task from the list and updates the interface immediately.

### Progress Tracking

The application keeps track of the number of completed tasks and displays the progress at the top of the screen.

## 📱 Application Interface

The application consists of:

1. **App Header** – Displays the Todo List title.
2. **Progress Section** – Shows the number of completed tasks.
3. **Task Input Field** – Allows users to enter new tasks.
4. **Todo List** – Displays all available tasks.
5. **Task Controls** – Provides options to complete or delete tasks.

##
<img width="2940" height="1912" alt="image" src="https://github.com/user-attachments/assets/30535ec4-fa68-4ad0-9083-addcd0c78b96" />
<img width="2940" height="1912" alt="image" src="https://github.com/user-attachments/assets/4ff7a791-7f71-44fe-b45f-1f12106f97e8" />

## 📂 Project Structure

```text
ToDoList/
│
├── lib/
│   └── main.dart
│
├── test/
│   └── widget_test.dart
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── README.md
└── .gitignore



