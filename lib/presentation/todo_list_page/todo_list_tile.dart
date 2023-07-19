import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/todo_list_provider.dart';

class TodoListTile extends ConsumerWidget {
  const TodoListTile(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.read(todoListProvider)[index];
    final notifier = ref.read(todoListProvider.notifier);
    return Row(
      children: [
        Text(todoState.id.toString()),
        const SizedBox(width: 20),
        Text(todoState.content),
        const SizedBox(width: 20),
        Text(todoState.completed.toString()),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => notifier.removeTodo(todoState.id),
          child: const Text('削除'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => notifier.toggleCompleted(todoState.id),
          child: const Text('ステータス切替'),
        ),
      ],
    );
  }
}
