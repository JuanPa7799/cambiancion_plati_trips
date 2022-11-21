import 'package:app/User/model/event.dart';
import 'package:app/User/provider/event_provider.dart';
import 'package:app/utils.dart';
import 'package:app/widgets/text_inputS.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  //* Este evento tiene todos nuestros datos, como son el titulo, las fechas y tambien la descripcion.
  final Event?
      event; //* El evento puede ser anulable por lo que se pone el signo "?" al final

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  //* Se crea la varible controlador de edicion de texto
  final titleController = TextEditingController();
  //* Se crea la varible controlador de edicion de texto
  final descriptionController = TextEditingController();
  //* Parametro de fecha inicial
  late DateTime fromDate;
  //* Parametro de fecha final
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      //* Si no titene datos los autollenamos con datos iniciales,
      //* En este caso con la fecha actual y la hora actual el primer parametro
      fromDate = DateTime.now();
      //* Y en este caso con la fecha actual y la hora actual + dos horas en el segundo parametro
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      //* Se mandan los parametros que ya se tienen para editarlos, MUCHO CUIDADO AQUI
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  //* Se crea dentro nuestro metodo de disposición
  @override
  void dispose() {
    //* dentro queremos volver a liverar el recurso del controlador
    titleController.dispose();

    super.dispose();
  }

  @override
  //* Pasamos al metodo de construccion "build"
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0, bottom: 50.0),
      child: Scaffold(
        //* Se comienza con la appBar o barra superior
        appBar: AppBar(
          backgroundColor: Colors.red,
          //* Se crea un boton para cerrar la ventana
          leading: const CloseButton(),
          //* Se crea un boton salvar los cambios con el metodo buildEditingActions
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          //* Se envolvieron los datos de la columna alrrededor de un formulario
          child: Form(
            //* Para el formulario se ocupa una llave de formulario haciendo necesario ingresar valores dentor del campo proporcionado
            key: _formKey,
            //* Se creo una columna que contenga objetos dentro de ella desplazables
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //* Se muestran los widgets que queremos mostrar e esta columna
              children: [
                //* Mandamos llamar nuestro constructor de widget de titulo
                buildTitle(),
                const SizedBox(height: 12),
                //* Se manda llamar el constructor de las fechas
                buildDateTimePickers(),
                //* Mandamos llamar nuestro constructor de widget de titulo
                buildDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //* Se construye el metodo para guardar los cambios
  List<Widget> buildEditingActions() => [
        //* Dentro se crea un boton elevado con un icono y un Texto
        ElevatedButton.icon(
          //* Se agrega un estilo para que combine con los colores de la aplicación.
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            //foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          //*Al presionar se ejecuta una funcionalidad para guardar toda la informacion proporcionada
          onPressed: saveForm,
          //* El icono es la palomita de guarardo y el texto es SAVE
          icon: const Icon(Icons.done),
          label: const Text('SAVE'),
        )
      ];

//* Se crea el constructor del titulo, par aloq ue se usa un campo de Texto 'TextFormField'
  Widget buildTitle() => TextFormField(
        //* Se le da el estilo que se queire al cmapo de texto
        style: const TextStyle(fontSize: 24),
        //* Se decora el mismo y se pone  que campo es
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'TITULO',
        ),
        onFieldSubmitted: (_) => saveForm(),
        //* Se agrega una validacion para nuestro campo de titulo y que no este vacio.
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        //* Este metodo ontrolador "controller" para despues poder llegar a controlar lo que se ve en el titulo
        controller: titleController,
      );

  //* Widget para el espacio de la descripcion
  Widget buildDescription() => TextInput(
        fontSize: 14.0,
        hintText: "Descripción",
        inputType: TextInputType.multiline,
        controller: descriptionController,
        maxLines: 4,
      );

  //* Metodo para llenar las fechas en una columna
  Widget buildDateTimePickers() => Column(
        children: [
          //* Se manda llamar el metodo constructor de fecha de inicio
          buildFrom(),
          //* Se llama el metodo para le fecha final
          buildTo(),
        ],
      );
  Widget buildFrom() => buiderHeader(
        //* Se pone el titulo del constructor desde el 'header'
        header: 'DESDE',
        child: Row(
          children: [
            Expanded(
              //* Gracias al formateo de flex se espacia mejor los recuadros dentro del contenedos
              flex: 2,
              //* Widget para el llenado de campos
              child: buildDropdownField(
                //* Se pone la fecha de inicio por lo que se crea un nuevo metodo 'Utils' para sacar la fecha como una cadena y ponerla en el widget 'buildDropdownField'
                text: Utils.toDate(fromDate),
                //* Se crea una accion para una vez picada la fecha 'pickFromDateTime' dando una funcion apra el tiempo incial.
                //* se elige si estamos seleccionando una fecha o una hora por lo que en este caso el parametro que se pasa es true.
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            //* Se crea en el mismo renglon otro campo con la hora
            Expanded(
              child: buildDropdownField(
                //* Se cambia el aprametro para poner la hora de comienzo
                text: Utils.toTime(fromDate),

                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  //* Se duplica el codigo de arriba
  Widget buildTo() => buiderHeader(
        header: 'HASTA',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                //* Se cambia el parametro por la fecha final 'toDate'
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                //* Se cambia el parametro por la fecha final 'toDate'
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  //* Se escribe un "Future" por que son valores que se van a recibir en un futuro
  Future pickFromDateTime({required bool pickDate}) async {
    //* Se crea una variable con los datos de otro metodo llamado "pickDateTime" el cual es un metodo que valida si pcicamos fecha o hora para modificarlo
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    //* Nos aseguramos de que no sea nulo y si no lo es..
    if (date == null) return;
    //* Si la fecha de inicio es despues de la fecha final que esta por defecto se igualan las fechas
    if (date.isAfter(toDate)) {
      toDate = DateTime(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
      );
      //* Sumando dos horas a la fecha incial en caso de que se pase
      toDate = toDate.add(const Duration(hours: 2));
    }
    //* Se cambian los datos generados en nuestra variable global
    setState(() => fromDate = date);
  }

  //* Se  duplica el codigo anterior solo se cmabia que ahora es hasta que fecha es la cita
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  //* Se crea este metodo espacializado para elegir una fecha o elegir una hora.
  Future<DateTime?> pickDateTime(
    //* se crea nuestro cosntructor, que recibe dos parametros, el boleano, para saber si es hora o fecha y los datos de la fecha u hora
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    //* Si el booleano es verdadero, comienza por elegir la fecha.
    if (pickDate) {
      //* Se comienza declarando una fecha al abrir el metodo "showDatePicker" regresa una varible al elegir la fecha y la guarda en la variable "date".
      final date = await showDatePicker(
        context: context,
        //*Se comienza declarando la fecha inicial
        initialDate: initialDate,
        //* Primer fecha que se muestra
        firstDate: firstDate ?? DateTime(2015, 8),
        //* Ultima fecha que se muestra
        lastDate: DateTime(2101),
      );
      //* Nos aseguramos que la fecha no sea ahora, en dado caso que asi sea se quede igual para no generar un error
      if (date == null) return null;
      //* Ponemos la hora inicial y los minutos
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      //* Nos aseguramos que regresa un valor con la fehca y le aderimos la hora para que no se modifique
      return date.add(time);
    }
    //* En dado caso que sea falso el boleano m ostramos la eleccion de la hora
    else {
      //* Creamos una varible con la eleccion de la hora y los mnutos gracias al 'ShowTimerPicker'
      final timeOfDay = await showTimePicker(
        //* Se pasa el contexto
        context: context,
        //* Se define la hora antes de seleccionar como la actual.
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      //* Nos aseguramos que la hora no sea ahora, en dado caso que asi sea se quede igual para no generar un error
      if (timeOfDay == null) return null;
      //* Ponemos la fecha previamente seleccionada
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      //* Ponemos la hora y los minutos seleccionados
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      //* se regresa los datos en un set con la hora y fecha juntos ya que estan jusntos arriba
      return date.add(time);
    }
  }

  //* Widget para el llenado de fecha y hora
  Widget buildDropdownField({
    //* Se ponen dos requerimientos el texto que tendra dentro y la funcion a realizar una vez picado el icono
    required String text,
    required Function() onClicked,
  }) =>
      ListTile(
        //*Se pone el titulo con el paramtro pasado
        title: Text(text),
        //* Pone el icono de flecha para dar a entender que se puede desplegar
        trailing: const Icon(Icons.arrow_drop_down),
        //* Se manda llamar el metodo necesario al hacer clicl en el icono
        onTap: onClicked,
      );

  //* Se crea el widget header para asi poder tener un titulo alinenado en dos filas el titulo y los recuadros de tiempo
  Widget buiderHeader({
    required String header,
    required Row child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Se escribe el titulo del texto
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //*En columna se pone el resto el formato
          child,
        ],
      );

  //* Se salva/guarda el formulario con este método
  Future saveForm() async {
    //* Con esta llave ingresaremos a nuestra llave de formulario para ver si si esta llenos los datos requeridos/obligatorios.
    final isValid = _formKey.currentState!.validate();

    //* Si tiene los datos requeridos...
    if (isValid) {
      //*Se crea un nuevo objeto del tipo EVENTO 'Event'
      final event = Event(
        //* En el mismo se guardan los datos del titulo
        title: titleController.text,
        //* Descripcion
        description: descriptionController.text,
        //* Fecha de inicio
        from: fromDate,
        //* FechaFinal
        to: toDate,
        //* Si es todo el dia, el cualno estamos usando ahora
        isAllDay: false,
      );

      final isEditing = widget.event != null;
      //* Se usa la gestion de estado del "Provider/provedoor"  y con el mismo obtenemos nuestro provedor de eventos y declaramos un objeto llamado "provider con este metodo"
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);

        Navigator.of(context).pop();
      } else {
        //* Se llama al metodo para agregar un nuevo evento, enviando nuestro metodo como información .
        provider.addEvent(event);
      }
      //* Y se cierra esta ventana para abrir la de incio
      Navigator.of(context).pop();
    }
  }
}
