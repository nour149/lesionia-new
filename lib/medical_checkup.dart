import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lesionia_project/bloc/checkup_bloc.dart';
import 'package:new_lesionia_project/bloc/checkup_event.dart';
import 'package:new_lesionia_project/bloc/checkup_state.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/widgets/checkup_bloc.dart';
import 'package:new_lesionia_project/widgets/checkup_event.dart';
import 'package:new_lesionia_project/widgets/checkup_state.dart';

class medical_checkup extends StatelessWidget {
  const medical_checkup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // On fournit le BLoC à la page et on lance le chargement
    return BlocProvider(
      create: (context) => CheckupBloc()..add(FetchCheckups()),
      child: Scaffold(
        body: const MedicalCheckupView(),
      ),
    );
  }
}

class MedicalCheckupView extends StatelessWidget {
  const MedicalCheckupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/patientsDetail');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff088274), Colors.greenAccent],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, '/patientsDetail'),
          ),
          title: const Center(child: Text("Medical Checkups")), // Tu peux injecter l'ID ici via le State
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)),
          child: BlocBuilder<CheckupBloc, CheckupState>(
            builder: (context, state) {

              // 1. GESTION DU CHARGEMENT
              if (state is CheckupLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }

              // 2. GESTION DES DONNÉES (LOADED)
              if (state is CheckupLoaded) {
                final filteredList = state.filteredCheckups;
                final bool hasNoContent = filteredList.isEmpty || filteredList.contains('no content');

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // BARRE DE RECHERCHE
                      _buildSearchField(context),

                      // COMPTEUR
                      _buildCounter(hasNoContent, filteredList.length),

                      const SizedBox(height: 20),

                      // BOUTON AJOUTER
                      _buildAddButton(context),

                      const SizedBox(height: 15),

                      // AFFICHAGE DE LA LISTE OU DU "NO CONTENT"
                      hasNoContent
                          ? _buildNoContentPlaceholder()
                          : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final user = filteredList[index];
                            return getCard(
                                context,
                                user['idmed'],
                                user['hospital'],
                                user['clinical_STATE'],
                                user['lesnum'],
                                user['gendesc'],
                                user['date_MED'],
                                index);
                          }),
                    ],
                  ),
                );
              }

              // 3. GESTION ERREUR
              if (state is CheckupError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  // --- TES WIDGETS DE DESIGN (GARDÉS À L'IDENTIQUE) ---

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        onChanged: (text) => context.read<CheckupBloc>().add(SearchCheckup(text)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget _buildCounter(bool noContent, int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Row(
        children: [
          Text(
            noContent ? "Total check-ups : 0" : "Total check-ups : $length",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _buildNoContentPlaceholder() {
    return Column(
      children: [
        const SizedBox(height: 90),
        const Center(child: Text('There is no medical check-up yet !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(50),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: const DecorationImage(image: AssetImage("assets/nocontent.png"), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, '/addcheckup'),
      child: Row(children: [
        const SizedBox(width: 80),
        Container(
            decoration: BoxDecoration(
                boxShadow: const [BoxShadow(offset: Offset(0.0, 20.0), blurRadius: 30.0, color: Colors.black12)],
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.0)),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                decoration: const BoxDecoration(
                    color: Color(0xFF077064),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(95.0), topLeft: Radius.circular(95.0), bottomRight: Radius.circular(200.0))),
                child: const Text('Add Medical Checkup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 50, child: Image.asset("assets/checkup.png")),
            ]))
      ]),
    );
  }

  Widget getCard(context, idmed, hospital, clinicalSTATE, lesnum, phone, dateMED, int index) {
    final List<Color> colors = <Color>[const Color(0xff042F39), const Color(0xff075264), const Color(0xff0A758F), const Color(0xff0D98BA)];

    return Container(
      margin: const EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: colors[index % colors.length], spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: const Color(0xFFF5F6F9)),
          onPressed: () {
            AuthService.setCheckupID(idmed);
            Navigator.pushReplacementNamed(context, '/updatecheckup');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 65, height: 65, child: Image.asset("assets/checkup.png"))]),
              const SizedBox(height: 10),
              Text('Check-up ID : $idmed', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 10),
              Text('Check-up Date : $dateMED', style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 10),
              Text('Clinical State : $clinicalSTATE', style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 10),
              Text('Hospital : $hospital', style: const TextStyle(color: Colors.black45)),
            ],
          )),
    );
  }
}