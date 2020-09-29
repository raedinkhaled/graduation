import 'package:flutter/material.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class EditMedicScreen extends StatefulWidget {
  @override
  _EditMedicScreenState createState() => _EditMedicScreenState();
  final Medic medic;
  EditMedicScreen({this.medic});
}

class _EditMedicScreenState extends State<EditMedicScreen> {
  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String lab = "";
  double presentation = 0;
  double ci = 0;
  double cmax = 0;
  double cmin = 0;
  double volume = 0;
  double prix = 0;
  double stabilite = 0;

  @override
  void initState() {
    super.initState();
    if (widget.medic != null) {
      nom = widget.medic.medicNom;
      lab = widget.medic.medicLab;
      presentation = widget.medic.presentation;
      ci = widget.medic.cI;
      cmax = widget.medic.cMax;
      cmin = widget.medic.cMin;
      prix = widget.medic.prix;
      stabilite = widget.medic.stabilite;
    }
  }

  _submit(BuildContext context) {
    final medicCubit = context.bloc<MedicsCubit>();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final medicT = MedicsCompanion(
          medicNom: moor.Value(nom),
          medicLab: moor.Value(lab),
          presentation: moor.Value(presentation),
          cI: moor.Value(ci),
          cMax: moor.Value(cmax),
          cMin: moor.Value(cmin),
          prix: moor.Value(prix),
          stabilite: moor.Value(stabilite));
      if (widget.medic == null) {
        medicCubit.medicDao.insertMedic(medicT);
      } else {
        final updatedMedic = widget.medic.copyWith(
            medicNom: nom,
            medicLab: lab,
            presentation: presentation,
            cI: ci,
            cMax: cmax,
            cMin: cmin,
            prix: prix,
            stabilite: stabilite);
        medicCubit.medicDao.updateMedic(updatedMedic);
      }
      Navigator.pop(context);
    }
  }

  _delete(BuildContext context) {
    final medicCubit = context.bloc<MedicsCubit>();
    medicCubit.medicDao.deleteMedics(widget.medic);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: t5DarkNavy,
        title: Text(
          widget.medic == null ? 'Ajouter Medicament' : 'Modifier Medicament',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Nom du medicament",
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez le Nom du medicament'
                              : null,
                          onSaved: (input) => nom = input,
                          initialValue: nom,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Laboratoire",
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez le Laboratoire'
                              : null,
                          onSaved: (input) => lab = input,
                          initialValue: lab,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Presentation",
                            labelText: "Presentation",
                            suffixText: 'mg/ml',
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez la Presentation'
                              : null,
                          onSaved: (input) =>
                              presentation = double.parse(input),
                          initialValue: presentation.toString(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Concentration initiale",
                            labelText: "CI",
                            suffixText: 'mg/ml',
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez la Concentration initiale'
                              : null,
                          onSaved: (input) => ci = double.parse(input),
                          initialValue: ci.toString(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Concentration minimale",
                            labelText: "CMax",
                            suffixText: 'mg/ml',
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez la Concentration minimale'
                              : null,
                          onSaved: (input) => cmin = double.parse(input),
                          initialValue: cmin.toString(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Concentration maximale",
                            labelText: "CMax",
                            suffixText: 'mg/ml',
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez la Concentration maximale'
                              : null,
                          onSaved: (input) => cmax = double.parse(input),
                          initialValue: cmax.toString(),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: boxDecorationT6(
                                  radius: 12,
                                  showShadow: true,
                                  bgColor: t6white),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: textSizeMedium,
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(26, 18, 4, 18),
                                  hintText: "Prix",
                                  labelText: "Prix",
                                  suffixText: 'DZ',
                                  filled: true,
                                  fillColor: t6white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                ),
                                validator: (input) => input.trim().isEmpty
                                    ? 'Svp Entrez le prix'
                                    : null,
                                onSaved: (input) => prix = double.parse(input),
                                initialValue: prix.toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: boxDecorationT6(
                            radius: 12, showShadow: true, bgColor: t6white),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: textSizeMedium,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                            hintText: "Stabilite",
                            labelText: "Stabilite",
                            suffixText: 'H',
                            filled: true,
                            fillColor: t6white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: t6white, width: 0.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Svp Entrez la Stabilite'
                              : null,
                          onSaved: (input) => stabilite = double.parse(input),
                          initialValue: stabilite.toString(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: t5ColorPrimaryDark,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: FlatButton(
                          child: Text(
                            widget.medic == null ? 'Ajouter' : 'Modifier',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () => _submit(context),
                        ),
                      ),
                      widget.medic != null
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 0.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: t5DarkRed,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: FlatButton(
                                child: Text(
                                  'Supprimer',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                onPressed: () => _delete(context),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
