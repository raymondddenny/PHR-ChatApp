part of 'models.dart';

class Contact {
  final String id;
  final Timestamp addedOn;

  Contact({this.id, this.addedOn});

  Map toMap(Contact contact) {
    var contactData = Map<String, dynamic>();
    contactData['contact_id'] = contact.id;
    contactData['contact_addedOn'] = contact.addedOn;
    return contactData;
  }

  factory Contact.fromMap(Map<String, dynamic> mapContact) {
    return Contact(
      id: mapContact['contact_id'],
      addedOn: mapContact['contact_addedOn'],
    );
  }
}
