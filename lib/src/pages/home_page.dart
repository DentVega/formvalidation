import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
//  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
//      body: _crearForm(bloc),
      body: Container(
          padding: EdgeInsets.all(20.0), child: _crearListado(context, productosBloc)),
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

  Widget _crearListado(BuildContext context, ProductosBloc productosBloc) {
    return StreamBuilder(
          stream: productosBloc.productosStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
            if (snapshot.hasData) {
              final productos = snapshot.data;
              return ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, i) => _crearItem(productos[i], context, productosBloc));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
    );
  }

  Widget _crearItem(ProductoModel producto, BuildContext context, ProductosBloc productosBloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => productosBloc.borrarProducto(producto.id),
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(producto.fotoUrl),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto),
            )
          ],
        ),
      ),
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
