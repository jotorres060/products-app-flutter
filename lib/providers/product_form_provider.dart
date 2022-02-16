import 'package:flutter/material.dart';

import 'package:validation_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> frmKey = GlobalKey();
  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return frmKey.currentState?.validate() ?? false;
  }

}
