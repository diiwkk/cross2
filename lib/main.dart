import 'package:flutter/material.dart';

void main() {
  runApp(const ListApp());
}

class ListItem {
  String id;
  String name;
  String group;

  ListItem({required this.id, required this.name, required this.group});
}

class ListApp extends StatelessWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListItem> items = [
    ListItem(id: '1', name: 'Item 1', group: 'Group A'),
    ListItem(id: '2', name: 'Item 2', group: 'Group B'),
    ListItem(id: '3', name: 'Item 3', group: 'Group C'),
  ];

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController groupController = TextEditingController();

  void addItem(ListItem newItem) {
    setState(() {
      items.add(newItem);
    });
  }

  void updateItem(int index, ListItem updatedItem) {
    setState(() {
      items[index] = updatedItem;
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: groupController,
                  decoration: const InputDecoration(labelText: 'Group'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                addItem(ListItem(
                  id: idController.text,
                  name: nameController.text,
                  group: groupController.text,
                ));
                idController.clear();
                nameController.clear();
                groupController.clear();
                Navigator.of(context).pop();
                setState(() {}); // Add this line to update UI
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showUpdateItemDialog(BuildContext context, int index) {
    idController.text = items[index].id;
    nameController.text = items[index].name;
    groupController.text = items[index].group;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: groupController,
                  decoration: const InputDecoration(labelText: 'Group'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                updateItem(index, ListItem(
                  id: idController.text,
                  name: nameController.text,
                  group: groupController.text,
                ));
                idController.clear();
                nameController.clear();
                groupController.clear();
                Navigator.of(context).pop();
                setState(() {}); // Add this line to update UI
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteItemDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteItem(index);
                Navigator.of(context).pop();
                setState(() {}); // Add this line to update UI
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List App'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.group),
              onTap: () {
                showUpdateItemDialog(context, index);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDeleteItemDialog(context, index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItemDialog(context);
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
