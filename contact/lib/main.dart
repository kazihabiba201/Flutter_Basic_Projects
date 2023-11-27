import 'package:flutter/material.dart';

void main() => runApp(const ContactList());

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListS(),
    );
  }
}

class ContactListS extends StatelessWidget {
  final List<Contacts> contacts = [
    Contacts(
      name: 'John Doe',
      email: 'johndoe@gmail.com',
      phone: '0165874356',
    ),
    Contacts(
      name: 'Jane Smith',
      email: 'janesmith@gmail.com',
      phone: '0146436874',
    ),
    Contacts(
      name: 'Alice Johnson',
      email: 'alicejohnsone@gmail.com',
      phone: '0177645454',
    ),
  ];

  ContactListS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ContactDetails(contact: contact),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final Contacts contact;

  const ContactDetails({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Contact Details',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Name: ${contact.name}'),
          const SizedBox(height: 4),
          Text('Email: ${contact.email}'),
          const SizedBox(height: 4),
          Text('Phone Number: ${contact.phone}'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Contacts {
  final String name;
  final String email;
  final String phone;

  Contacts({
    required this.name,
    required this.email,
    required this.phone,
  });
}
