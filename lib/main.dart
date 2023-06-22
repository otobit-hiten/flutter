import 'package:flutter/material.dart';
import 'package:flutter_note_app/noteModel.dart';

void main() {
  runApp(MaterialApp(
    title: 'Notes',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CRUD'),
          backgroundColor: Colors.black,

        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : data.isEmpty
                ? const Center(child: Text("No Data Available!!!"))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: index % 2 == 0
                            ? Colors.white
                            : Colors.white,
                        child: ListTile(
                            onLongPress: () => delete(data[index]['id']),
                            title: Text(data[index]['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400,color: Colors.black)),
                            subtitle: Text(data[index]['description'], style: const TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.w300)),
                            trailing: SizedBox(
                                child: IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.black),
                                    onPressed: () =>
                                        openDialog(data[index]['id'])))))),
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
            onPressed: () {
              openDialog(null);
            },
            child: const Icon(Icons.add,color: Colors.black,)));
  }

  void delete(int id) async {
    await DbHelper.deleteItem(id);
    getData();
  }

  openDialog(int? id) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SizedBox(
              height: 120,
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title')),
                  TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'description'))
                ],
              )),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Add'),
              onPressed: () async {
                if (id == null) {
                  await addData();
                } else {
                  await updateData(id);
                }
                titleController.text = '';
                descriptionController.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getData() async {
    final allData = await DbHelper.getItems();
    setState(() {
      data = allData;
      isLoading = false;
    });
  }

  Future<void> addData() async {
    await DbHelper.createItem(titleController.text, descriptionController.text);
    getData();
  }

  Future<void> updateData(int id) async {
    await DbHelper.updateItem(
        id, titleController.text, descriptionController.text);
    getData();
  }
}
