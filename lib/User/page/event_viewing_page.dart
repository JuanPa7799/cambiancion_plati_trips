import 'package:app/User/model/event.dart';
import 'package:app/User/page/event_editing_page.dart';
import 'package:app/User/provider/event_provider.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Widgets de texto par apodemos mosytrar todos los dtos necesarios
class EventViewingPage extends StatelessWidget {
  //* Es necesaio recibir un evento
  final Event event;
  //* Constructor
  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  //* Se sobreescribe el widget
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 35.0, bottom: 50.0),
        child: Scaffold(
          //* Se crea un appBar con un boton de cerrar y este finaliza todo y regresa a la pagina anterior
          appBar: AppBar(
            //* Boton de cerrar
            leading: CloseButton(),
            //* Se crean unas acciones las cuales estan predeterminadas en el lado superior derecho
            actions: [
              //* La primera accion es un boton de editar el cual abre unanueva ventana y edita la informacion enviando los datos del evento y la cierra una vez terminada la edicion
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    //* manda llamar el widget EventEditingPage par apoder modificarlo
                    builder: (context) => EventEditingPage(event: event),
                  ),
                ),
              ),
              //* La segunda accion es un boton de borrar el cual borra la informacion y los datos del evento y la cierra una vez terminada la accion.
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                  Provider.of<EventProvider>(context, listen: false)
                      //*Manda llamar el metodo delete de  provider, apra borrar ese evento desde adentro
                      .deleteEvent(event),
                  //* Cierra la ventana
                  Navigator.pop(context),
                },
              ),
            ],
            //actions: buildViewingActions(context, event),
          ),
          //* Es la forma en como se observa el contenido
          body: ListView(
            padding: EdgeInsets.all(32),
            children: [
              //* Desde este punto o fecgha madando llamar el metodo de utils para mostrar el formato ya creado
              Text(
                "DESDE: \n${Utils.toDate(event.from)} ${Utils.toTime(event.from)}\n ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                //* Hasta este punto o fecgha madando llamar el metodo de utils para mostrar el formato ya creado
              ),
              Text(
                "HASTA: \n${Utils.toDate(event.to)} ${Utils.toTime(event.from)}\n",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ), //buildDateTime(event),
              SizedBox(height: 32),
              //* Se crea el texto par amoestrar el titulo y sus cualidades
              Text(
                event.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              //* Se crea el texto para mostrar la descripción y sus cualidades
              Text(
                event.description,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
      );
}

// !POR SI LO LLEGO A OCUPAR

// Widget buildDateTime(Event event) {
//   return Column(
//     children: [
//       buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
//       if (!event.isAllDay) buildDate('To', event.to),
//     ],
//   );
// }

// Widget buildDate(String title, DateTime date) {

// }

// List<Widget> buildViewingActions(BuildContext context, Event event) {
//   IconButton(
//     icon: Icon(Icons.edit),
//     onPressed: () => Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => EventEditingPage(event: event),
//       ),
//     ),
//   );
// IconButton(
//     icon: Icon(Icons.delete),
//     onPressed: () {
//       final provider = Provider.of<EventProvider>(context, listen: false);

//       provider.deleteEvent(event);
//     });
// }
