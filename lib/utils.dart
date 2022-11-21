//* Packete necesario para poder conectar el calendario
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  //* Para construirlo se manda llamar el formato de tiempo
  //* Se formateo nuestro objeto de tiempo a una cadena
  static String toDate(DateTime dateTime) {
    //* Aqui definimos el fromato excato que queremos mostrar
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  //* Para construirlo se manda llamar el formato de tiempo
  static String toTime(DateTime dateTime) {
    //* Aqui definimos el fromato excato que queremos mostrar que en este caso son horas y minutos
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }

  //* Metodo para borrar los datos
  static DateTime removeTime(DateTime dateTime) => DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      );
}
