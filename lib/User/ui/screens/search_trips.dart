import 'package:app/User/page/event_editing_page.dart';
import 'package:app/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

class SearchTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 40.0, bottom: 50.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Agenda"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body:
            CalendarWidget(), //*Se manda llamar la funcion que creamos en el archivo de calendar_widget.dart

        //*Se agrego  un floatingActionButton para agregar una cita y que mande llamar un metodo que al terminar se cierre automaticamente.
        floatingActionButton: FloatingActionButton(
          //* Se declara su hijo y las proíedades del mismo, osea el icono y su tamaño y demas
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
          //* Color de fondo del boton
          backgroundColor: Colors.red,
          //* Funcion a llamar al presionarlo en este caso abre una nueva ventana la cual tiene a EventEditingPage la cual se cierra al aditarlo y terminar la accion.
          onPressed: (() => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage()),
              )),
        ),
      ),
    );
  }
}
