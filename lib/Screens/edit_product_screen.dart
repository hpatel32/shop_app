import 'package:flutter/material.dart';
import 'package:shop_app/Model/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isinit = true;
  var _initValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _editedProduct =
      Product(id: null, title: '', description: '', imageUrl: '', price: 0);

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValue = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
        };
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    var _isValid = _form.currentState.validate();
    if (!_isValid) return;
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                      isFavourite: _editedProduct.isFavourite,
                      id: _editedProduct.id,
                      title: val,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(val) == null) {
                    return 'Please enter valid number';
                  }
                  if (double.parse(val) <= 0) {
                    return 'Please enter price greater than 0.';
                  }
                  return null;
                },
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (val) {
                  _editedProduct = Product(
                      isFavourite: _editedProduct.isFavourite,
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(val),
                      imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValue['description'],
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Please enter description';
                  }
                  if (val.length < 10) {
                    return 'Should have minimum 10 character';
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                      isFavourite: _editedProduct.isFavourite,
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: val,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageController.text.isEmpty
                        ? Text('Enter Url')
                        : Image.network(
                            _imageController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageController,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (value) {
                        _saveForm();
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter image url';
                        }
                        if (!val.startsWith('http') &&
                            !val.startsWith('https')) {
                          return 'Please enter valid url';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedProduct = Product(
                            isFavourite: _editedProduct.isFavourite,
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: val);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
