import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/product_provider.dart';
import 'package:shop4/Provider/products_model.dart';

class EditUserProduct extends StatefulWidget {
  static const routeName = '/Edit_userProduct';

  @override
  State<StatefulWidget> createState() {
    return _EditUserProductState();
  }
}

class _EditUserProductState extends State<EditUserProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = ProductModel(
    id: null,
    title: '',
    price: 0,
    description: '',
    image: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'image': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateimage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'image': _editedProduct.image,
          'image': '',
        };
        _imageController.text = _editedProduct.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateimage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateimage() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
          !_imageController.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      Provider.of<ProductProvider>(context, listen: false).updateProduct(
        _editedProduct,
        _editedProduct.id,
      );
      setState(() {
        //Future<void>.delayed(Duration(seconds:2));
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editedProduct)
          . catchError((error){
            return showDialog(
              context: context,
              builder: (ctx)=>AlertDialog(
              title: Text("AN ERROR OCCURED",style: TextStyle(fontFamily:'Dosis'),),
              content: Text("SOMETHING WENT WRONG",style: TextStyle(fontFamily:'Dosis'),),
              actions: <Widget>[
                FlatButton(child: Text('OKAY'),onPressed: (){
                  Navigator.of(context).pop();
                },)
              ],
            ));
        })

          .then((_) {
        setState(() {
          //Future<void>.delayed(Duration(seconds:2));
          _isLoading = false;
        });

        Navigator.of(context).pop();
      });
    }
    // Navigator.of(context).pop();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductModel(
                            title: value,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            image: _editedProduct.image,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductModel(
                            title: _editedProduct.title,
                            price: double.parse(value),
                            description: _editedProduct.description,
                            image: _editedProduct.image,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductModel(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value,
                          image: _editedProduct.image,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageController,
                            focusNode: _imageFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = ProductModel(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                image: value,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                              );
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
