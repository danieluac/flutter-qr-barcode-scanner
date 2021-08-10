import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF5f5e97);
const kPrimaryLightColor = Color(0xFF67595E);

const String apiMainUrl = "http://192.168.5.36:8013/xmlrpc/2/";
const apiDatabase = 'odoo-database';
const apiModelToAccess = 'product.product';
const apiMethodToExecute = 'your_customer_method';
const apiMethodParam = {"name": "barcode_data", "without_paid": true };