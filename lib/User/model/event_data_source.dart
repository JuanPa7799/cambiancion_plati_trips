import 'package:app/User/model/event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//* Se creo esta clase para que pueda prosesar los datos enviados y convertirlos a lo que entiende el "calendar event"
// TODO: Esta clase sera indispensable para traer los datos de la data firebase, clud_fire_bas0e

//* Extiende los datos que vienen de "CalendarDataSource"
class EventDataSource extends CalendarDataSource {
  //* Despues se define el constructor par amandarle nuestros eventos adentro
  EventDataSource(List<Event> appointments) {
    //* This.appoinments es parte del mismo "CalendarDataSource" mas se crea un lista dinamica
    this.appointments = appointments;
  }

  //* Por lo mismo se crea un getter de evento "getEvent" pudiendo de esta manera entrar al index de la lista y se vuelve a convertir en un objeto de evento por separado para entrar al objeto de evento en lugar de al objeto dinamico
  Event getEvent(int index) => appointments![index] as Event;

  //* Se anulan algunos emtodos para poder rellenarlos con nueva información (override)
  @override
  //* Dato de inicio de la cita o evento.
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  //* Dato del final de la cita o evento.
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  //* Dato del titulo del evento.
  String getSubject(int index) => getEvent(index).title;

  @override
  //* Dato del titulo del evento.
  String getNotes(int index) => getEvent(index).description;

  @override
  //* Dato del color de fondo.
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  //* Dato de si es todo el dia.
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
