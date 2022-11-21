import 'package:app/User/model/event.dart';
import 'package:app/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  //* Almacenamos nuestro estado donde queremos tener una lista de eventos y estos eventos son perte de nuestro calendarios.
  final List<Event> _events = [];

  //* Dentro de este clase se crea un metodo getter
  List<Event> get events => _events;

  //* Se crea un campo para la fecha seleccionada comenzado por seleccionar la fecha actual
  DateTime _selectedDate = DateTime.now();

  //* SE CREA UN METODO GETTER Y SETTER

  //*Se cambia el recuadro seleccionado por el que selecciones
  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  //*Por ultimo se crea un metodo eventos de la fecha seleccionada
  List<Event> get eventOfSelectedDate => _events;

  //* Tambien se crea un metodo parra agregar un nuevo evento. y aqui mismo se calcula todos los eventos de esa fecha especifica
  void addEvent(Event event) {
    //* Agregamos el evento a nuestra lista de eventos.
    _events.add(event);
    //* Y se llama a este notificador de eventos.
    notifyListeners();
  }

  //* Tambien un metodo para editar un evento.
  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;

    //* Y se llama a este notificador de eventos.
    notifyListeners();
  }

  //* Y tambien un metodo para borrar un evento.
  void deleteEvent(Event event) {
    _events.remove(event);

    //* Y se llama a este notificador de eventos.
    notifyListeners();
  }
}
