import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'package:validation_app/providers/product_form_provider.dart';
import 'package:validation_app/services/products_service.dart';
import 'package:validation_app/ui/input_decorations.dart';
import 'package:validation_app/widgets/widgets.dart';

class ProductPage extends StatelessWidget {

  const ProductPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductPageBody(productService: productService)
    );
  }

}

class _ProductPageBody extends StatelessWidget {
  const _ProductPageBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productFrm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct?.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white, size: 40)
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? photo = await _picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                      );

                      if (photo == null) {
                        return;
                      }

                      productService.updateSelectedProductImage(photo.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40)
                  )
                )
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
          ? const CircularProgressIndicator(color: Colors.white)
          : const Icon(Icons.save_outlined),
        onPressed: productService.isSaving
          ? null
          : () async {
            if (!productFrm.isValidForm()) {
              return;
            }

            final String? imageUrl = await productService.uploadImage();

            if (imageUrl != null) {
              productFrm.product.picture = imageUrl;
            }

            await productService.saveOrCreateProduct(productFrm.product);
          },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  const _ProductForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFrm = Provider.of<ProductFormProvider>(context);
    final product = productFrm.product;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 280,
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: Form(
            key: productFrm.frmKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto',
                    labelText: 'Nombre'
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: '${ product.price }',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    double.tryParse(value) == null
                    ? product.price = 0
                    : product.price = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '\$150',
                    labelText: 'Precio'
                  ),
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                  value: product.available,
                  title: const Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: productFrm.updateAvailability
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 5)
      )
    ]
  );

}
