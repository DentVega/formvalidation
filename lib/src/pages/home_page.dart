import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final productosProvider = new ProductosProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
//      body: _crearForm(bloc),
      body: _crearListado(context, productosProvider),
      floatingActionButton: _creatBoton(context),
    );
  }

  Widget _crearForm(LoginBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Email: ${bloc.email}'),
        Divider(),
        Text('Password: ${bloc.password}')
      ],
    );
  }

  Widget _crearListado(BuildContext context, ProductosProvider productosProvider) {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }

  Widget _creatBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'producto');
      },
      child: Icon(Icons.add),
    );
  }
}
