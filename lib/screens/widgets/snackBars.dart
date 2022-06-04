import 'package:flutter/material.dart';

const noInternetSnackBar = SnackBar(
  content: Text('No Internet'),
);
const apiErrorSnackBar = SnackBar(
  content: Text('apiErrorSnackBar'),
);
// const noInternetSnackBar = SnackBar(
//   content: Text('No Internet'),
// );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
