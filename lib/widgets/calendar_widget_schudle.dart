import 'package:app/User/model/event_data_source.dart';
import 'package:app/User/provider/event_provider.dart';
import 'package:app/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidgetSchedule extends StatelessWidget {
  //* En el metodo constructor se llenan los eventos ya creados en el 'EventProvider'
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      //*Regresa un SfCalendar, que es una vista del widget de calendario ya cargado por la libreria 'package:syncfusion_flutter_calendar/calendar.dart'.
      //* Es el modo de ver el calendario, se puede modificar para verlo de la mejor manera posible, en este caso por mes
      // TODO: Puede llegarse a cambiar en el futuro por la decicion del usuario
      view: CalendarView.schedule,
      //* Se manda llamar una fuente de datos y se usa el 'dataSource: EventDataSource(events)', con los "events" para enviarle la informacion ya guardada
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      // headerStyle: CalendarHeaderStyle(
      //     textStyle: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
      //     textAlign: TextAlign.center,
      //     backgroundColor: Colors.grey),
      //cellBorderColor: Colors.transparent,
      //* Al presionar durnate un largo tiepo se abre esta funcion
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        //* Se guarda la fecha llamando a nuestro proveedor de eventos y se pasan los detalles
        provider.setDate(details.date!);
        //* Este metodo "showModalBottomSheet" muestra el modelo de la hoja inferior y le pasamos un nuevo widget
        showModalBottomSheet(
          context: context,
          //* El widget que se pasa es el de "TasksWidget"
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}
