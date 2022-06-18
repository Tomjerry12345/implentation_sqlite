import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../helpers/dbHelper.dart';
import '../models/contact.dart';
import 'entryform.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Contact>? contactList;

  @override
  Widget build(BuildContext context) {
    contactList ??= <Contact>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dafter Data-Data'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          addContact(contact);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact? contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              contactList![index].name,
              style: textStyle,
            ),
            subtitle: Text(contactList![index].phone),
            trailing: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                deleteContact(contactList![index]);
              },
            ),
            onTap: () async {
              var contact =
                  await navigateToEntryForm(context, contactList![index]);
              editContact(contact);
            },
          ),
        );
      },
    );
  }

  //buat contact
  void addContact(Contact object) async {
    print("contact => ${object.toMap()}");
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  //edit contact
  void editContact(Contact object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete contact
  void deleteContact(Contact object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = dbHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList;
          count = contactList.length;
        });
      });
    });
  }
}
