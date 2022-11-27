import 'package:app/User/ui/screens/search_trips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:app/User/bloc/bloc_user.dart';
import 'Place/ui/screens/home_trips.dart';
import 'User/ui/screens/profile_trips.dart';
import 'package:app/User/ui/screens/tareas_del_dia.dart';

class PlatziTripsCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_sharp, color: Colors.indigo),
              label: "Itinerario"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined, color: Colors.indigo),
              label: "Agregar"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.indigo), label: "Perfil"),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => Tareas_Del_dia(),
              );
            //break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => SearchTrip(),
              );
            //break;
            case 2:
              return CupertinoTabView(builder: (BuildContext context) {
                return BlocProvider<UserBloc>(
                    child: ProfileTrips(), bloc: UserBloc());
              });
            //break;
            default:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider<UserBloc>(
                      child: HomeTrips(), bloc: UserBloc());
                },
              );
          }
        },
      ),
    );
  }
}
