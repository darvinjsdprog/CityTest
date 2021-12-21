import 'package:city_test/widgets/masterView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  Text _getCountryText(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic country = ModalRoute.of(context)!.settings.arguments;
    return View(
      title: toBeginningOfSentenceCase(country['country'])!,
      viewType: 'Pais',
      centerTitle: true,
      requiredBackButton: true,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Material(
            elevation: 2,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(10),
              child: Image.network(
                country['image'],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.90,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Center(
                      child: Text('Cargando imagen...'),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Text('Ha ocurrido un error!'),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                Center(child: _getCountryText(country['city'])),
                Center(child: _getCountryText(country['name'])),
                Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                Container(
                  child: Text(
                    country['description'],
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
