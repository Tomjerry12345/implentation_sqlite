import 'dart:math';

import 'package:flutter/material.dart';

import '../models/contact.dart';

class EntryForm extends StatefulWidget {
  final Contact? contact;

  EntryForm(this.contact);

  @override
  EntryFormState createState() => EntryFormState(contact);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Contact? contact;

  EntryFormState(this.contact);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (contact != null) {
      nameController.text = contact!.name;
      phoneController.text = contact!.phone;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: contact == null ? const Text('Tambah') : const Text('Rubah'),
          leading: const Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // telepon
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (contact == null) {
                            // tambah data
                            contact = Contact(Random().nextInt(100),
                                nameController.text, phoneController.text);
                          } else {
                            // ubah data
                            contact?.name = nameController.text;
                            contact?.phone = phoneController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek contact
                          Navigator.pop(context, contact);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
