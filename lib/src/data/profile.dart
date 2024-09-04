import 'package:flutter/material.dart';

import '../models/content.dart';

List<ProfileContent> MyAccount = [
  const ProfileContent(
      contenticons: Icon(Icons.info_outline_rounded),
      contenttitle: "Account informations"),
  const ProfileContent(
      contenticons: Icon(Icons.notifications),
      contenttitle: "notifications methods"),
];
List<ProfileContent> Application = [
  const ProfileContent(
      contenticons: Icon(Icons.upload_rounded),
      contenttitle: "Import ingrédients"),
  const ProfileContent(
      contenticons: Icon(Icons.upload_rounded), contenttitle: "import recipe"),
];
List<ProfileContent> Support = [
  const ProfileContent(contenticons: Icon(Icons.help), contenttitle: "Help us"),
  const ProfileContent(
      contenticons: Icon(Icons.phone), contenttitle: "Contact us"),
  const ProfileContent(
      contenticons: Icon(Icons.account_box), contenttitle: "Private data"),
];
