import 'package:app/User/model/event_data_source.dart';
import 'package:app/User/page/event_viewing_page.dart';
import 'package:app/User/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    //* Se declara un provedor de eventos con los eventos seleccionados
    final provider = Provider.of<EventProvider>(context);
    //* Obtenemos todos los eventos seleccionados
    final selectedEvents = provider.eventOfSelectedDate;
    //* Si la fecha seleccionada no tiene eventos aqui se comprueba y se muestra un mensaje que no hay eventos este dia
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron eventos este día',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    //* Se retorna un calendario con la vista que quieras llegar a mostrar
    return SfCalendarTheme(
      //Aqui se puede dar un formato al celndario que se
      data: SfCalendarThemeData(
          timeTextStyle: TextStyle(fontSize: 14, color: Colors.white)),
      child: SfCalendar(
        //* Se muestra la forma en cmo quieres que se muestre el calendario en este caso es una linea de tiempo del dia
        view: CalendarView.timelineDay,
        //* Se pasa una fuente de datos y aqui dentro de nuestra fuente ponemos todos nuestros eventos dentro
        dataSource: EventDataSource(provider.events),
        //* S configura para que se localice en la fecha seleccionada
        initialDisplayDate: provider.selectedDate,
        //* Se crea un apuntadore o generador de citas con este Widget
        appointmentBuilder: appointmentBuilder,
        //* Reduce la altura del mes a cero y lo desparece
        headerHeight: 0,
        //* Muestra el dia en el que estas parado
        todayHighlightColor: Colors.blueGrey,
        //* Decora la seleccciona mas al tener opacidad de cero no se ve nada
        selectionDecoration: BoxDecoration(
          color: Colors.red.withOpacity(0),
        ),
        //* Se genera el onTap para que cada vez que se p´resione haga una accion en dado caso qeu hayas seleccioando un evento
        onTap: (details) {
          //* En caso de no seleccionar un evento no hace nada
          if (details.appointments == null) return;
          //* Se crea un evento que manda llamar los detalles del evento que se ha seleccionado
          final event = details.appointments!.first;
          //* Hace que se habra una nueva imagen
          Navigator.of(context).push(MaterialPageRoute(
            //* Se creo una nueva pagina llamada EvetinViewingPage y dentro ponemos nuestro evento para asi visualizar los datos del mismo.
            builder: (context) => EventViewingPage(event: event),
          ));
        },
      ),
    );
  }

  //* Generador de citas
  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    //* Se obtienen los datos del evento en primer lugar
    final event = details.appointments.first;
    //* Y se crea un contenedor y dentro obtenemos el ancho y alto del mismo
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        //*Se le da un poco de decoraciones
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      //* Se crea un widget de texto centrado
      child: Center(
        child: Text(
          //* Con texto como el titulo
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
