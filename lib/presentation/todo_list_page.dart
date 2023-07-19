import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/state/todo.dart';

import '../provider/todo_list_provider.dart';
import 'todo_list_page/todo_list_tile.dart';

class TodoListPage extends ConsumerWidget {
  final todoContentTextController = TextEditingController();
  final todoContentTextFocusNode = FocusNode();

  TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TodoListProvider
    List<Todo> todoList = ref.watch(todoListProvider);
    TodoListNotifier todoListNotifier = ref.read(todoListProvider.notifier);

    // 追加ボタン押下
    onPressedAddButton() {
      String content = todoContentTextController.text;
      todoContentTextController.clear();

      // 新規TodoアイテムのidはListの最後の要素のid+1とする。ただし、空の場合は1とする。
      int id = (todoList.isEmpty) ? 1 : todoList.last.id + 1;

      // 新規Todoアイテム
      Todo todo = Todo(
        id: id,
        content: content,
        completed: false,
      );

      todoListNotifier.addTodo(todo);

      // Todoリストを追加したあと、TextFieldにFocusを移動
      FocusScope.of(context).requestFocus(todoContentTextFocusNode);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoContentTextController,
                    focusNode: todoContentTextFocusNode,
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressedAddButton,
                  child: const Text('追加'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TodoListTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
