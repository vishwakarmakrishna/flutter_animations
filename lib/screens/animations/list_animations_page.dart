import 'package:flutter/material.dart';

class ListAnimationsPage extends StatefulWidget {
  const ListAnimationsPage({super.key});

  @override
  State<ListAnimationsPage> createState() => _ListAnimationsPageState();
}

class _ListAnimationsPageState extends State<ListAnimationsPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [];

  void _addItem() {
    final int index = _items.length;
    _items.insert(index, 'Item ${index + 1}');
    _listKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 500));
  }

  void _removeItem(int index) {
    final String removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ),
        ),
        child: Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeItem(_items.indexOf(item)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: _items.isEmpty ? null : () => _removeItem(_items.length - 1),
            tooltip: 'Remove Last Item',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_items[index], animation);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
            ),
          ),
        ],
      ),
    );
  }
}