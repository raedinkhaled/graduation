// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Password extends DataClass implements Insertable<Password> {
  final int passid;
  final String pass;
  Password({@required this.passid, @required this.pass});
  factory Password.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Password(
      passid: intType.mapFromDatabaseResponse(data['${effectivePrefix}passid']),
      pass: stringType.mapFromDatabaseResponse(data['${effectivePrefix}pass']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || passid != null) {
      map['passid'] = Variable<int>(passid);
    }
    if (!nullToAbsent || pass != null) {
      map['pass'] = Variable<String>(pass);
    }
    return map;
  }

  PasswordsCompanion toCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      passid:
          passid == null && nullToAbsent ? const Value.absent() : Value(passid),
      pass: pass == null && nullToAbsent ? const Value.absent() : Value(pass),
    );
  }

  factory Password.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Password(
      passid: serializer.fromJson<int>(json['passid']),
      pass: serializer.fromJson<String>(json['pass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'passid': serializer.toJson<int>(passid),
      'pass': serializer.toJson<String>(pass),
    };
  }

  Password copyWith({int passid, String pass}) => Password(
        passid: passid ?? this.passid,
        pass: pass ?? this.pass,
      );
  @override
  String toString() {
    return (StringBuffer('Password(')
          ..write('passid: $passid, ')
          ..write('pass: $pass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(passid.hashCode, pass.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Password &&
          other.passid == this.passid &&
          other.pass == this.pass);
}

class PasswordsCompanion extends UpdateCompanion<Password> {
  final Value<int> passid;
  final Value<String> pass;
  const PasswordsCompanion({
    this.passid = const Value.absent(),
    this.pass = const Value.absent(),
  });
  PasswordsCompanion.insert({
    this.passid = const Value.absent(),
    @required String pass,
  }) : pass = Value(pass);
  static Insertable<Password> custom({
    Expression<int> passid,
    Expression<String> pass,
  }) {
    return RawValuesInsertable({
      if (passid != null) 'passid': passid,
      if (pass != null) 'pass': pass,
    });
  }

  PasswordsCompanion copyWith({Value<int> passid, Value<String> pass}) {
    return PasswordsCompanion(
      passid: passid ?? this.passid,
      pass: pass ?? this.pass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (passid.present) {
      map['passid'] = Variable<int>(passid.value);
    }
    if (pass.present) {
      map['pass'] = Variable<String>(pass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasswordsCompanion(')
          ..write('passid: $passid, ')
          ..write('pass: $pass')
          ..write(')'))
        .toString();
  }
}

class $PasswordsTable extends Passwords
    with TableInfo<$PasswordsTable, Password> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordsTable(this._db, [this._alias]);
  final VerificationMeta _passidMeta = const VerificationMeta('passid');
  GeneratedIntColumn _passid;
  @override
  GeneratedIntColumn get passid => _passid ??= _constructPassid();
  GeneratedIntColumn _constructPassid() {
    return GeneratedIntColumn('passid', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _passMeta = const VerificationMeta('pass');
  GeneratedTextColumn _pass;
  @override
  GeneratedTextColumn get pass => _pass ??= _constructPass();
  GeneratedTextColumn _constructPass() {
    return GeneratedTextColumn('pass', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [passid, pass];
  @override
  $PasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'passwords';
  @override
  final String actualTableName = 'passwords';
  @override
  VerificationContext validateIntegrity(Insertable<Password> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('passid')) {
      context.handle(_passidMeta,
          passid.isAcceptableOrUnknown(data['passid'], _passidMeta));
    }
    if (data.containsKey('pass')) {
      context.handle(
          _passMeta, pass.isAcceptableOrUnknown(data['pass'], _passMeta));
    } else if (isInserting) {
      context.missing(_passMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {passid};
  @override
  Password map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Password.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PasswordsTable createAlias(String alias) {
    return $PasswordsTable(_db, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final int patientID;
  final String nom;
  final String prenom;
  final double taille;
  final double poids;
  final double surface;
  Patient(
      {@required this.patientID,
      @required this.nom,
      @required this.prenom,
      @required this.taille,
      @required this.poids,
      @required this.surface});
  factory Patient.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Patient(
      patientID: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}patient_i_d']),
      nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
      prenom:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}prenom']),
      taille:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}taille']),
      poids:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}poids']),
      surface:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}surface']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || patientID != null) {
      map['patient_i_d'] = Variable<int>(patientID);
    }
    if (!nullToAbsent || nom != null) {
      map['nom'] = Variable<String>(nom);
    }
    if (!nullToAbsent || prenom != null) {
      map['prenom'] = Variable<String>(prenom);
    }
    if (!nullToAbsent || taille != null) {
      map['taille'] = Variable<double>(taille);
    }
    if (!nullToAbsent || poids != null) {
      map['poids'] = Variable<double>(poids);
    }
    if (!nullToAbsent || surface != null) {
      map['surface'] = Variable<double>(surface);
    }
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      patientID: patientID == null && nullToAbsent
          ? const Value.absent()
          : Value(patientID),
      nom: nom == null && nullToAbsent ? const Value.absent() : Value(nom),
      prenom:
          prenom == null && nullToAbsent ? const Value.absent() : Value(prenom),
      taille:
          taille == null && nullToAbsent ? const Value.absent() : Value(taille),
      poids:
          poids == null && nullToAbsent ? const Value.absent() : Value(poids),
      surface: surface == null && nullToAbsent
          ? const Value.absent()
          : Value(surface),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Patient(
      patientID: serializer.fromJson<int>(json['patientID']),
      nom: serializer.fromJson<String>(json['nom']),
      prenom: serializer.fromJson<String>(json['prenom']),
      taille: serializer.fromJson<double>(json['taille']),
      poids: serializer.fromJson<double>(json['poids']),
      surface: serializer.fromJson<double>(json['surface']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientID': serializer.toJson<int>(patientID),
      'nom': serializer.toJson<String>(nom),
      'prenom': serializer.toJson<String>(prenom),
      'taille': serializer.toJson<double>(taille),
      'poids': serializer.toJson<double>(poids),
      'surface': serializer.toJson<double>(surface),
    };
  }

  Patient copyWith(
          {int patientID,
          String nom,
          String prenom,
          double taille,
          double poids,
          double surface}) =>
      Patient(
        patientID: patientID ?? this.patientID,
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        taille: taille ?? this.taille,
        poids: poids ?? this.poids,
        surface: surface ?? this.surface,
      );
  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('patientID: $patientID, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('taille: $taille, ')
          ..write('poids: $poids, ')
          ..write('surface: $surface')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      patientID.hashCode,
      $mrjc(
          nom.hashCode,
          $mrjc(
              prenom.hashCode,
              $mrjc(
                  taille.hashCode, $mrjc(poids.hashCode, surface.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Patient &&
          other.patientID == this.patientID &&
          other.nom == this.nom &&
          other.prenom == this.prenom &&
          other.taille == this.taille &&
          other.poids == this.poids &&
          other.surface == this.surface);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> patientID;
  final Value<String> nom;
  final Value<String> prenom;
  final Value<double> taille;
  final Value<double> poids;
  final Value<double> surface;
  const PatientsCompanion({
    this.patientID = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenom = const Value.absent(),
    this.taille = const Value.absent(),
    this.poids = const Value.absent(),
    this.surface = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.patientID = const Value.absent(),
    @required String nom,
    @required String prenom,
    @required double taille,
    @required double poids,
    @required double surface,
  })  : nom = Value(nom),
        prenom = Value(prenom),
        taille = Value(taille),
        poids = Value(poids),
        surface = Value(surface);
  static Insertable<Patient> custom({
    Expression<int> patientID,
    Expression<String> nom,
    Expression<String> prenom,
    Expression<double> taille,
    Expression<double> poids,
    Expression<double> surface,
  }) {
    return RawValuesInsertable({
      if (patientID != null) 'patient_i_d': patientID,
      if (nom != null) 'nom': nom,
      if (prenom != null) 'prenom': prenom,
      if (taille != null) 'taille': taille,
      if (poids != null) 'poids': poids,
      if (surface != null) 'surface': surface,
    });
  }

  PatientsCompanion copyWith(
      {Value<int> patientID,
      Value<String> nom,
      Value<String> prenom,
      Value<double> taille,
      Value<double> poids,
      Value<double> surface}) {
    return PatientsCompanion(
      patientID: patientID ?? this.patientID,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      taille: taille ?? this.taille,
      poids: poids ?? this.poids,
      surface: surface ?? this.surface,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientID.present) {
      map['patient_i_d'] = Variable<int>(patientID.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenom.present) {
      map['prenom'] = Variable<String>(prenom.value);
    }
    if (taille.present) {
      map['taille'] = Variable<double>(taille.value);
    }
    if (poids.present) {
      map['poids'] = Variable<double>(poids.value);
    }
    if (surface.present) {
      map['surface'] = Variable<double>(surface.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('patientID: $patientID, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('taille: $taille, ')
          ..write('poids: $poids, ')
          ..write('surface: $surface')
          ..write(')'))
        .toString();
  }
}

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  final GeneratedDatabase _db;
  final String _alias;
  $PatientsTable(this._db, [this._alias]);
  final VerificationMeta _patientIDMeta = const VerificationMeta('patientID');
  GeneratedIntColumn _patientID;
  @override
  GeneratedIntColumn get patientID => _patientID ??= _constructPatientID();
  GeneratedIntColumn _constructPatientID() {
    return GeneratedIntColumn('patient_i_d', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomMeta = const VerificationMeta('nom');
  GeneratedTextColumn _nom;
  @override
  GeneratedTextColumn get nom => _nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _prenomMeta = const VerificationMeta('prenom');
  GeneratedTextColumn _prenom;
  @override
  GeneratedTextColumn get prenom => _prenom ??= _constructPrenom();
  GeneratedTextColumn _constructPrenom() {
    return GeneratedTextColumn('prenom', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _tailleMeta = const VerificationMeta('taille');
  GeneratedRealColumn _taille;
  @override
  GeneratedRealColumn get taille => _taille ??= _constructTaille();
  GeneratedRealColumn _constructTaille() {
    return GeneratedRealColumn(
      'taille',
      $tableName,
      false,
    );
  }

  final VerificationMeta _poidsMeta = const VerificationMeta('poids');
  GeneratedRealColumn _poids;
  @override
  GeneratedRealColumn get poids => _poids ??= _constructPoids();
  GeneratedRealColumn _constructPoids() {
    return GeneratedRealColumn(
      'poids',
      $tableName,
      false,
    );
  }

  final VerificationMeta _surfaceMeta = const VerificationMeta('surface');
  GeneratedRealColumn _surface;
  @override
  GeneratedRealColumn get surface => _surface ??= _constructSurface();
  GeneratedRealColumn _constructSurface() {
    return GeneratedRealColumn(
      'surface',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [patientID, nom, prenom, taille, poids, surface];
  @override
  $PatientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'patients';
  @override
  final String actualTableName = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_i_d')) {
      context.handle(_patientIDMeta,
          patientID.isAcceptableOrUnknown(data['patient_i_d'], _patientIDMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
          _nomMeta, nom.isAcceptableOrUnknown(data['nom'], _nomMeta));
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenom')) {
      context.handle(_prenomMeta,
          prenom.isAcceptableOrUnknown(data['prenom'], _prenomMeta));
    } else if (isInserting) {
      context.missing(_prenomMeta);
    }
    if (data.containsKey('taille')) {
      context.handle(_tailleMeta,
          taille.isAcceptableOrUnknown(data['taille'], _tailleMeta));
    } else if (isInserting) {
      context.missing(_tailleMeta);
    }
    if (data.containsKey('poids')) {
      context.handle(
          _poidsMeta, poids.isAcceptableOrUnknown(data['poids'], _poidsMeta));
    } else if (isInserting) {
      context.missing(_poidsMeta);
    }
    if (data.containsKey('surface')) {
      context.handle(_surfaceMeta,
          surface.isAcceptableOrUnknown(data['surface'], _surfaceMeta));
    } else if (isInserting) {
      context.missing(_surfaceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientID};
  @override
  Patient map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Patient.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(_db, alias);
  }
}

class Medic extends DataClass implements Insertable<Medic> {
  final int medicID;
  final String medicNom;
  final String medicLab;
  final double presentation;
  final double cI;
  final double cMin;
  final double cMax;
  final double volume;
  final double prix;
  final double stabilite;
  Medic(
      {@required this.medicID,
      @required this.medicNom,
      @required this.medicLab,
      @required this.presentation,
      @required this.cI,
      @required this.cMin,
      @required this.cMax,
      @required this.volume,
      @required this.prix,
      @required this.stabilite});
  factory Medic.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Medic(
      medicID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}medic_i_d']),
      medicNom: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}medic_nom']),
      medicLab: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}medic_lab']),
      presentation: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}presentation']),
      cI: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}c_i']),
      cMin: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}c_min']),
      cMax: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}c_max']),
      volume:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}volume']),
      prix: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}prix']),
      stabilite: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}stabilite']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || medicID != null) {
      map['medic_i_d'] = Variable<int>(medicID);
    }
    if (!nullToAbsent || medicNom != null) {
      map['medic_nom'] = Variable<String>(medicNom);
    }
    if (!nullToAbsent || medicLab != null) {
      map['medic_lab'] = Variable<String>(medicLab);
    }
    if (!nullToAbsent || presentation != null) {
      map['presentation'] = Variable<double>(presentation);
    }
    if (!nullToAbsent || cI != null) {
      map['c_i'] = Variable<double>(cI);
    }
    if (!nullToAbsent || cMin != null) {
      map['c_min'] = Variable<double>(cMin);
    }
    if (!nullToAbsent || cMax != null) {
      map['c_max'] = Variable<double>(cMax);
    }
    if (!nullToAbsent || volume != null) {
      map['volume'] = Variable<double>(volume);
    }
    if (!nullToAbsent || prix != null) {
      map['prix'] = Variable<double>(prix);
    }
    if (!nullToAbsent || stabilite != null) {
      map['stabilite'] = Variable<double>(stabilite);
    }
    return map;
  }

  MedicsCompanion toCompanion(bool nullToAbsent) {
    return MedicsCompanion(
      medicID: medicID == null && nullToAbsent
          ? const Value.absent()
          : Value(medicID),
      medicNom: medicNom == null && nullToAbsent
          ? const Value.absent()
          : Value(medicNom),
      medicLab: medicLab == null && nullToAbsent
          ? const Value.absent()
          : Value(medicLab),
      presentation: presentation == null && nullToAbsent
          ? const Value.absent()
          : Value(presentation),
      cI: cI == null && nullToAbsent ? const Value.absent() : Value(cI),
      cMin: cMin == null && nullToAbsent ? const Value.absent() : Value(cMin),
      cMax: cMax == null && nullToAbsent ? const Value.absent() : Value(cMax),
      volume:
          volume == null && nullToAbsent ? const Value.absent() : Value(volume),
      prix: prix == null && nullToAbsent ? const Value.absent() : Value(prix),
      stabilite: stabilite == null && nullToAbsent
          ? const Value.absent()
          : Value(stabilite),
    );
  }

  factory Medic.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Medic(
      medicID: serializer.fromJson<int>(json['medicID']),
      medicNom: serializer.fromJson<String>(json['medicNom']),
      medicLab: serializer.fromJson<String>(json['medicLab']),
      presentation: serializer.fromJson<double>(json['presentation']),
      cI: serializer.fromJson<double>(json['cI']),
      cMin: serializer.fromJson<double>(json['cMin']),
      cMax: serializer.fromJson<double>(json['cMax']),
      volume: serializer.fromJson<double>(json['volume']),
      prix: serializer.fromJson<double>(json['prix']),
      stabilite: serializer.fromJson<double>(json['stabilite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'medicID': serializer.toJson<int>(medicID),
      'medicNom': serializer.toJson<String>(medicNom),
      'medicLab': serializer.toJson<String>(medicLab),
      'presentation': serializer.toJson<double>(presentation),
      'cI': serializer.toJson<double>(cI),
      'cMin': serializer.toJson<double>(cMin),
      'cMax': serializer.toJson<double>(cMax),
      'volume': serializer.toJson<double>(volume),
      'prix': serializer.toJson<double>(prix),
      'stabilite': serializer.toJson<double>(stabilite),
    };
  }

  Medic copyWith(
          {int medicID,
          String medicNom,
          String medicLab,
          double presentation,
          double cI,
          double cMin,
          double cMax,
          double volume,
          double prix,
          double stabilite}) =>
      Medic(
        medicID: medicID ?? this.medicID,
        medicNom: medicNom ?? this.medicNom,
        medicLab: medicLab ?? this.medicLab,
        presentation: presentation ?? this.presentation,
        cI: cI ?? this.cI,
        cMin: cMin ?? this.cMin,
        cMax: cMax ?? this.cMax,
        volume: volume ?? this.volume,
        prix: prix ?? this.prix,
        stabilite: stabilite ?? this.stabilite,
      );
  @override
  String toString() {
    return (StringBuffer('Medic(')
          ..write('medicID: $medicID, ')
          ..write('medicNom: $medicNom, ')
          ..write('medicLab: $medicLab, ')
          ..write('presentation: $presentation, ')
          ..write('cI: $cI, ')
          ..write('cMin: $cMin, ')
          ..write('cMax: $cMax, ')
          ..write('volume: $volume, ')
          ..write('prix: $prix, ')
          ..write('stabilite: $stabilite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      medicID.hashCode,
      $mrjc(
          medicNom.hashCode,
          $mrjc(
              medicLab.hashCode,
              $mrjc(
                  presentation.hashCode,
                  $mrjc(
                      cI.hashCode,
                      $mrjc(
                          cMin.hashCode,
                          $mrjc(
                              cMax.hashCode,
                              $mrjc(
                                  volume.hashCode,
                                  $mrjc(prix.hashCode,
                                      stabilite.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Medic &&
          other.medicID == this.medicID &&
          other.medicNom == this.medicNom &&
          other.medicLab == this.medicLab &&
          other.presentation == this.presentation &&
          other.cI == this.cI &&
          other.cMin == this.cMin &&
          other.cMax == this.cMax &&
          other.volume == this.volume &&
          other.prix == this.prix &&
          other.stabilite == this.stabilite);
}

class MedicsCompanion extends UpdateCompanion<Medic> {
  final Value<int> medicID;
  final Value<String> medicNom;
  final Value<String> medicLab;
  final Value<double> presentation;
  final Value<double> cI;
  final Value<double> cMin;
  final Value<double> cMax;
  final Value<double> volume;
  final Value<double> prix;
  final Value<double> stabilite;
  const MedicsCompanion({
    this.medicID = const Value.absent(),
    this.medicNom = const Value.absent(),
    this.medicLab = const Value.absent(),
    this.presentation = const Value.absent(),
    this.cI = const Value.absent(),
    this.cMin = const Value.absent(),
    this.cMax = const Value.absent(),
    this.volume = const Value.absent(),
    this.prix = const Value.absent(),
    this.stabilite = const Value.absent(),
  });
  MedicsCompanion.insert({
    this.medicID = const Value.absent(),
    @required String medicNom,
    @required String medicLab,
    @required double presentation,
    @required double cI,
    @required double cMin,
    @required double cMax,
    @required double volume,
    @required double prix,
    @required double stabilite,
  })  : medicNom = Value(medicNom),
        medicLab = Value(medicLab),
        presentation = Value(presentation),
        cI = Value(cI),
        cMin = Value(cMin),
        cMax = Value(cMax),
        volume = Value(volume),
        prix = Value(prix),
        stabilite = Value(stabilite);
  static Insertable<Medic> custom({
    Expression<int> medicID,
    Expression<String> medicNom,
    Expression<String> medicLab,
    Expression<double> presentation,
    Expression<double> cI,
    Expression<double> cMin,
    Expression<double> cMax,
    Expression<double> volume,
    Expression<double> prix,
    Expression<double> stabilite,
  }) {
    return RawValuesInsertable({
      if (medicID != null) 'medic_i_d': medicID,
      if (medicNom != null) 'medic_nom': medicNom,
      if (medicLab != null) 'medic_lab': medicLab,
      if (presentation != null) 'presentation': presentation,
      if (cI != null) 'c_i': cI,
      if (cMin != null) 'c_min': cMin,
      if (cMax != null) 'c_max': cMax,
      if (volume != null) 'volume': volume,
      if (prix != null) 'prix': prix,
      if (stabilite != null) 'stabilite': stabilite,
    });
  }

  MedicsCompanion copyWith(
      {Value<int> medicID,
      Value<String> medicNom,
      Value<String> medicLab,
      Value<double> presentation,
      Value<double> cI,
      Value<double> cMin,
      Value<double> cMax,
      Value<double> volume,
      Value<double> prix,
      Value<double> stabilite}) {
    return MedicsCompanion(
      medicID: medicID ?? this.medicID,
      medicNom: medicNom ?? this.medicNom,
      medicLab: medicLab ?? this.medicLab,
      presentation: presentation ?? this.presentation,
      cI: cI ?? this.cI,
      cMin: cMin ?? this.cMin,
      cMax: cMax ?? this.cMax,
      volume: volume ?? this.volume,
      prix: prix ?? this.prix,
      stabilite: stabilite ?? this.stabilite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medicID.present) {
      map['medic_i_d'] = Variable<int>(medicID.value);
    }
    if (medicNom.present) {
      map['medic_nom'] = Variable<String>(medicNom.value);
    }
    if (medicLab.present) {
      map['medic_lab'] = Variable<String>(medicLab.value);
    }
    if (presentation.present) {
      map['presentation'] = Variable<double>(presentation.value);
    }
    if (cI.present) {
      map['c_i'] = Variable<double>(cI.value);
    }
    if (cMin.present) {
      map['c_min'] = Variable<double>(cMin.value);
    }
    if (cMax.present) {
      map['c_max'] = Variable<double>(cMax.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (prix.present) {
      map['prix'] = Variable<double>(prix.value);
    }
    if (stabilite.present) {
      map['stabilite'] = Variable<double>(stabilite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicsCompanion(')
          ..write('medicID: $medicID, ')
          ..write('medicNom: $medicNom, ')
          ..write('medicLab: $medicLab, ')
          ..write('presentation: $presentation, ')
          ..write('cI: $cI, ')
          ..write('cMin: $cMin, ')
          ..write('cMax: $cMax, ')
          ..write('volume: $volume, ')
          ..write('prix: $prix, ')
          ..write('stabilite: $stabilite')
          ..write(')'))
        .toString();
  }
}

class $MedicsTable extends Medics with TableInfo<$MedicsTable, Medic> {
  final GeneratedDatabase _db;
  final String _alias;
  $MedicsTable(this._db, [this._alias]);
  final VerificationMeta _medicIDMeta = const VerificationMeta('medicID');
  GeneratedIntColumn _medicID;
  @override
  GeneratedIntColumn get medicID => _medicID ??= _constructMedicID();
  GeneratedIntColumn _constructMedicID() {
    return GeneratedIntColumn('medic_i_d', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _medicNomMeta = const VerificationMeta('medicNom');
  GeneratedTextColumn _medicNom;
  @override
  GeneratedTextColumn get medicNom => _medicNom ??= _constructMedicNom();
  GeneratedTextColumn _constructMedicNom() {
    return GeneratedTextColumn('medic_nom', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _medicLabMeta = const VerificationMeta('medicLab');
  GeneratedTextColumn _medicLab;
  @override
  GeneratedTextColumn get medicLab => _medicLab ??= _constructMedicLab();
  GeneratedTextColumn _constructMedicLab() {
    return GeneratedTextColumn('medic_lab', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _presentationMeta =
      const VerificationMeta('presentation');
  GeneratedRealColumn _presentation;
  @override
  GeneratedRealColumn get presentation =>
      _presentation ??= _constructPresentation();
  GeneratedRealColumn _constructPresentation() {
    return GeneratedRealColumn(
      'presentation',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cIMeta = const VerificationMeta('cI');
  GeneratedRealColumn _cI;
  @override
  GeneratedRealColumn get cI => _cI ??= _constructCI();
  GeneratedRealColumn _constructCI() {
    return GeneratedRealColumn(
      'c_i',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cMinMeta = const VerificationMeta('cMin');
  GeneratedRealColumn _cMin;
  @override
  GeneratedRealColumn get cMin => _cMin ??= _constructCMin();
  GeneratedRealColumn _constructCMin() {
    return GeneratedRealColumn(
      'c_min',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cMaxMeta = const VerificationMeta('cMax');
  GeneratedRealColumn _cMax;
  @override
  GeneratedRealColumn get cMax => _cMax ??= _constructCMax();
  GeneratedRealColumn _constructCMax() {
    return GeneratedRealColumn(
      'c_max',
      $tableName,
      false,
    );
  }

  final VerificationMeta _volumeMeta = const VerificationMeta('volume');
  GeneratedRealColumn _volume;
  @override
  GeneratedRealColumn get volume => _volume ??= _constructVolume();
  GeneratedRealColumn _constructVolume() {
    return GeneratedRealColumn(
      'volume',
      $tableName,
      false,
    );
  }

  final VerificationMeta _prixMeta = const VerificationMeta('prix');
  GeneratedRealColumn _prix;
  @override
  GeneratedRealColumn get prix => _prix ??= _constructPrix();
  GeneratedRealColumn _constructPrix() {
    return GeneratedRealColumn(
      'prix',
      $tableName,
      false,
    );
  }

  final VerificationMeta _stabiliteMeta = const VerificationMeta('stabilite');
  GeneratedRealColumn _stabilite;
  @override
  GeneratedRealColumn get stabilite => _stabilite ??= _constructStabilite();
  GeneratedRealColumn _constructStabilite() {
    return GeneratedRealColumn(
      'stabilite',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        medicID,
        medicNom,
        medicLab,
        presentation,
        cI,
        cMin,
        cMax,
        volume,
        prix,
        stabilite
      ];
  @override
  $MedicsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'medics';
  @override
  final String actualTableName = 'medics';
  @override
  VerificationContext validateIntegrity(Insertable<Medic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('medic_i_d')) {
      context.handle(_medicIDMeta,
          medicID.isAcceptableOrUnknown(data['medic_i_d'], _medicIDMeta));
    }
    if (data.containsKey('medic_nom')) {
      context.handle(_medicNomMeta,
          medicNom.isAcceptableOrUnknown(data['medic_nom'], _medicNomMeta));
    } else if (isInserting) {
      context.missing(_medicNomMeta);
    }
    if (data.containsKey('medic_lab')) {
      context.handle(_medicLabMeta,
          medicLab.isAcceptableOrUnknown(data['medic_lab'], _medicLabMeta));
    } else if (isInserting) {
      context.missing(_medicLabMeta);
    }
    if (data.containsKey('presentation')) {
      context.handle(
          _presentationMeta,
          presentation.isAcceptableOrUnknown(
              data['presentation'], _presentationMeta));
    } else if (isInserting) {
      context.missing(_presentationMeta);
    }
    if (data.containsKey('c_i')) {
      context.handle(_cIMeta, cI.isAcceptableOrUnknown(data['c_i'], _cIMeta));
    } else if (isInserting) {
      context.missing(_cIMeta);
    }
    if (data.containsKey('c_min')) {
      context.handle(
          _cMinMeta, cMin.isAcceptableOrUnknown(data['c_min'], _cMinMeta));
    } else if (isInserting) {
      context.missing(_cMinMeta);
    }
    if (data.containsKey('c_max')) {
      context.handle(
          _cMaxMeta, cMax.isAcceptableOrUnknown(data['c_max'], _cMaxMeta));
    } else if (isInserting) {
      context.missing(_cMaxMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume'], _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('prix')) {
      context.handle(
          _prixMeta, prix.isAcceptableOrUnknown(data['prix'], _prixMeta));
    } else if (isInserting) {
      context.missing(_prixMeta);
    }
    if (data.containsKey('stabilite')) {
      context.handle(_stabiliteMeta,
          stabilite.isAcceptableOrUnknown(data['stabilite'], _stabiliteMeta));
    } else if (isInserting) {
      context.missing(_stabiliteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medicID};
  @override
  Medic map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Medic.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MedicsTable createAlias(String alias) {
    return $MedicsTable(_db, alias);
  }
}

class Dose extends DataClass implements Insertable<Dose> {
  final int doseID;
  final int patientid;
  final int medicid;
  final int posolgie;
  final DateTime date;
  Dose(
      {@required this.doseID,
      @required this.patientid,
      @required this.medicid,
      @required this.posolgie,
      @required this.date});
  factory Dose.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Dose(
      doseID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}dose_i_d']),
      patientid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}patientid']),
      medicid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}medicid']),
      posolgie:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}posolgie']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || doseID != null) {
      map['dose_i_d'] = Variable<int>(doseID);
    }
    if (!nullToAbsent || patientid != null) {
      map['patientid'] = Variable<int>(patientid);
    }
    if (!nullToAbsent || medicid != null) {
      map['medicid'] = Variable<int>(medicid);
    }
    if (!nullToAbsent || posolgie != null) {
      map['posolgie'] = Variable<int>(posolgie);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  DosesCompanion toCompanion(bool nullToAbsent) {
    return DosesCompanion(
      doseID:
          doseID == null && nullToAbsent ? const Value.absent() : Value(doseID),
      patientid: patientid == null && nullToAbsent
          ? const Value.absent()
          : Value(patientid),
      medicid: medicid == null && nullToAbsent
          ? const Value.absent()
          : Value(medicid),
      posolgie: posolgie == null && nullToAbsent
          ? const Value.absent()
          : Value(posolgie),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Dose.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Dose(
      doseID: serializer.fromJson<int>(json['doseID']),
      patientid: serializer.fromJson<int>(json['patientid']),
      medicid: serializer.fromJson<int>(json['medicid']),
      posolgie: serializer.fromJson<int>(json['posolgie']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'doseID': serializer.toJson<int>(doseID),
      'patientid': serializer.toJson<int>(patientid),
      'medicid': serializer.toJson<int>(medicid),
      'posolgie': serializer.toJson<int>(posolgie),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Dose copyWith(
          {int doseID,
          int patientid,
          int medicid,
          int posolgie,
          DateTime date}) =>
      Dose(
        doseID: doseID ?? this.doseID,
        patientid: patientid ?? this.patientid,
        medicid: medicid ?? this.medicid,
        posolgie: posolgie ?? this.posolgie,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Dose(')
          ..write('doseID: $doseID, ')
          ..write('patientid: $patientid, ')
          ..write('medicid: $medicid, ')
          ..write('posolgie: $posolgie, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      doseID.hashCode,
      $mrjc(patientid.hashCode,
          $mrjc(medicid.hashCode, $mrjc(posolgie.hashCode, date.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Dose &&
          other.doseID == this.doseID &&
          other.patientid == this.patientid &&
          other.medicid == this.medicid &&
          other.posolgie == this.posolgie &&
          other.date == this.date);
}

class DosesCompanion extends UpdateCompanion<Dose> {
  final Value<int> doseID;
  final Value<int> patientid;
  final Value<int> medicid;
  final Value<int> posolgie;
  final Value<DateTime> date;
  const DosesCompanion({
    this.doseID = const Value.absent(),
    this.patientid = const Value.absent(),
    this.medicid = const Value.absent(),
    this.posolgie = const Value.absent(),
    this.date = const Value.absent(),
  });
  DosesCompanion.insert({
    this.doseID = const Value.absent(),
    @required int patientid,
    @required int medicid,
    @required int posolgie,
    @required DateTime date,
  })  : patientid = Value(patientid),
        medicid = Value(medicid),
        posolgie = Value(posolgie),
        date = Value(date);
  static Insertable<Dose> custom({
    Expression<int> doseID,
    Expression<int> patientid,
    Expression<int> medicid,
    Expression<int> posolgie,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (doseID != null) 'dose_i_d': doseID,
      if (patientid != null) 'patientid': patientid,
      if (medicid != null) 'medicid': medicid,
      if (posolgie != null) 'posolgie': posolgie,
      if (date != null) 'date': date,
    });
  }

  DosesCompanion copyWith(
      {Value<int> doseID,
      Value<int> patientid,
      Value<int> medicid,
      Value<int> posolgie,
      Value<DateTime> date}) {
    return DosesCompanion(
      doseID: doseID ?? this.doseID,
      patientid: patientid ?? this.patientid,
      medicid: medicid ?? this.medicid,
      posolgie: posolgie ?? this.posolgie,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (doseID.present) {
      map['dose_i_d'] = Variable<int>(doseID.value);
    }
    if (patientid.present) {
      map['patientid'] = Variable<int>(patientid.value);
    }
    if (medicid.present) {
      map['medicid'] = Variable<int>(medicid.value);
    }
    if (posolgie.present) {
      map['posolgie'] = Variable<int>(posolgie.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DosesCompanion(')
          ..write('doseID: $doseID, ')
          ..write('patientid: $patientid, ')
          ..write('medicid: $medicid, ')
          ..write('posolgie: $posolgie, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DosesTable extends Doses with TableInfo<$DosesTable, Dose> {
  final GeneratedDatabase _db;
  final String _alias;
  $DosesTable(this._db, [this._alias]);
  final VerificationMeta _doseIDMeta = const VerificationMeta('doseID');
  GeneratedIntColumn _doseID;
  @override
  GeneratedIntColumn get doseID => _doseID ??= _constructDoseID();
  GeneratedIntColumn _constructDoseID() {
    return GeneratedIntColumn('dose_i_d', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _patientidMeta = const VerificationMeta('patientid');
  GeneratedIntColumn _patientid;
  @override
  GeneratedIntColumn get patientid => _patientid ??= _constructPatientid();
  GeneratedIntColumn _constructPatientid() {
    return GeneratedIntColumn('patientid', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES patients(patient_i_d)');
  }

  final VerificationMeta _medicidMeta = const VerificationMeta('medicid');
  GeneratedIntColumn _medicid;
  @override
  GeneratedIntColumn get medicid => _medicid ??= _constructMedicid();
  GeneratedIntColumn _constructMedicid() {
    return GeneratedIntColumn('medicid', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES medics(medic_i_d)');
  }

  final VerificationMeta _posolgieMeta = const VerificationMeta('posolgie');
  GeneratedIntColumn _posolgie;
  @override
  GeneratedIntColumn get posolgie => _posolgie ??= _constructPosolgie();
  GeneratedIntColumn _constructPosolgie() {
    return GeneratedIntColumn(
      'posolgie',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [doseID, patientid, medicid, posolgie, date];
  @override
  $DosesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'doses';
  @override
  final String actualTableName = 'doses';
  @override
  VerificationContext validateIntegrity(Insertable<Dose> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dose_i_d')) {
      context.handle(_doseIDMeta,
          doseID.isAcceptableOrUnknown(data['dose_i_d'], _doseIDMeta));
    }
    if (data.containsKey('patientid')) {
      context.handle(_patientidMeta,
          patientid.isAcceptableOrUnknown(data['patientid'], _patientidMeta));
    } else if (isInserting) {
      context.missing(_patientidMeta);
    }
    if (data.containsKey('medicid')) {
      context.handle(_medicidMeta,
          medicid.isAcceptableOrUnknown(data['medicid'], _medicidMeta));
    } else if (isInserting) {
      context.missing(_medicidMeta);
    }
    if (data.containsKey('posolgie')) {
      context.handle(_posolgieMeta,
          posolgie.isAcceptableOrUnknown(data['posolgie'], _posolgieMeta));
    } else if (isInserting) {
      context.missing(_posolgieMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {doseID};
  @override
  Dose map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Dose.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DosesTable createAlias(String alias) {
    return $DosesTable(_db, alias);
  }
}

class Reliquat extends DataClass implements Insertable<Reliquat> {
  final int reliquatID;
  final int medicid;
  final double quantite;
  final DateTime date;
  final bool isvalid;
  Reliquat(
      {@required this.reliquatID,
      @required this.medicid,
      @required this.quantite,
      @required this.date,
      @required this.isvalid});
  factory Reliquat.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Reliquat(
      reliquatID: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}reliquat_i_d']),
      medicid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}medicid']),
      quantite: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantite']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      isvalid:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}isvalid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || reliquatID != null) {
      map['reliquat_i_d'] = Variable<int>(reliquatID);
    }
    if (!nullToAbsent || medicid != null) {
      map['medicid'] = Variable<int>(medicid);
    }
    if (!nullToAbsent || quantite != null) {
      map['quantite'] = Variable<double>(quantite);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || isvalid != null) {
      map['isvalid'] = Variable<bool>(isvalid);
    }
    return map;
  }

  ReliquatsCompanion toCompanion(bool nullToAbsent) {
    return ReliquatsCompanion(
      reliquatID: reliquatID == null && nullToAbsent
          ? const Value.absent()
          : Value(reliquatID),
      medicid: medicid == null && nullToAbsent
          ? const Value.absent()
          : Value(medicid),
      quantite: quantite == null && nullToAbsent
          ? const Value.absent()
          : Value(quantite),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      isvalid: isvalid == null && nullToAbsent
          ? const Value.absent()
          : Value(isvalid),
    );
  }

  factory Reliquat.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Reliquat(
      reliquatID: serializer.fromJson<int>(json['reliquatID']),
      medicid: serializer.fromJson<int>(json['medicid']),
      quantite: serializer.fromJson<double>(json['quantite']),
      date: serializer.fromJson<DateTime>(json['date']),
      isvalid: serializer.fromJson<bool>(json['isvalid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'reliquatID': serializer.toJson<int>(reliquatID),
      'medicid': serializer.toJson<int>(medicid),
      'quantite': serializer.toJson<double>(quantite),
      'date': serializer.toJson<DateTime>(date),
      'isvalid': serializer.toJson<bool>(isvalid),
    };
  }

  Reliquat copyWith(
          {int reliquatID,
          int medicid,
          double quantite,
          DateTime date,
          bool isvalid}) =>
      Reliquat(
        reliquatID: reliquatID ?? this.reliquatID,
        medicid: medicid ?? this.medicid,
        quantite: quantite ?? this.quantite,
        date: date ?? this.date,
        isvalid: isvalid ?? this.isvalid,
      );
  @override
  String toString() {
    return (StringBuffer('Reliquat(')
          ..write('reliquatID: $reliquatID, ')
          ..write('medicid: $medicid, ')
          ..write('quantite: $quantite, ')
          ..write('date: $date, ')
          ..write('isvalid: $isvalid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      reliquatID.hashCode,
      $mrjc(medicid.hashCode,
          $mrjc(quantite.hashCode, $mrjc(date.hashCode, isvalid.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Reliquat &&
          other.reliquatID == this.reliquatID &&
          other.medicid == this.medicid &&
          other.quantite == this.quantite &&
          other.date == this.date &&
          other.isvalid == this.isvalid);
}

class ReliquatsCompanion extends UpdateCompanion<Reliquat> {
  final Value<int> reliquatID;
  final Value<int> medicid;
  final Value<double> quantite;
  final Value<DateTime> date;
  final Value<bool> isvalid;
  const ReliquatsCompanion({
    this.reliquatID = const Value.absent(),
    this.medicid = const Value.absent(),
    this.quantite = const Value.absent(),
    this.date = const Value.absent(),
    this.isvalid = const Value.absent(),
  });
  ReliquatsCompanion.insert({
    this.reliquatID = const Value.absent(),
    @required int medicid,
    @required double quantite,
    @required DateTime date,
    this.isvalid = const Value.absent(),
  })  : medicid = Value(medicid),
        quantite = Value(quantite),
        date = Value(date);
  static Insertable<Reliquat> custom({
    Expression<int> reliquatID,
    Expression<int> medicid,
    Expression<double> quantite,
    Expression<DateTime> date,
    Expression<bool> isvalid,
  }) {
    return RawValuesInsertable({
      if (reliquatID != null) 'reliquat_i_d': reliquatID,
      if (medicid != null) 'medicid': medicid,
      if (quantite != null) 'quantite': quantite,
      if (date != null) 'date': date,
      if (isvalid != null) 'isvalid': isvalid,
    });
  }

  ReliquatsCompanion copyWith(
      {Value<int> reliquatID,
      Value<int> medicid,
      Value<double> quantite,
      Value<DateTime> date,
      Value<bool> isvalid}) {
    return ReliquatsCompanion(
      reliquatID: reliquatID ?? this.reliquatID,
      medicid: medicid ?? this.medicid,
      quantite: quantite ?? this.quantite,
      date: date ?? this.date,
      isvalid: isvalid ?? this.isvalid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (reliquatID.present) {
      map['reliquat_i_d'] = Variable<int>(reliquatID.value);
    }
    if (medicid.present) {
      map['medicid'] = Variable<int>(medicid.value);
    }
    if (quantite.present) {
      map['quantite'] = Variable<double>(quantite.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isvalid.present) {
      map['isvalid'] = Variable<bool>(isvalid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReliquatsCompanion(')
          ..write('reliquatID: $reliquatID, ')
          ..write('medicid: $medicid, ')
          ..write('quantite: $quantite, ')
          ..write('date: $date, ')
          ..write('isvalid: $isvalid')
          ..write(')'))
        .toString();
  }
}

class $ReliquatsTable extends Reliquats
    with TableInfo<$ReliquatsTable, Reliquat> {
  final GeneratedDatabase _db;
  final String _alias;
  $ReliquatsTable(this._db, [this._alias]);
  final VerificationMeta _reliquatIDMeta = const VerificationMeta('reliquatID');
  GeneratedIntColumn _reliquatID;
  @override
  GeneratedIntColumn get reliquatID => _reliquatID ??= _constructReliquatID();
  GeneratedIntColumn _constructReliquatID() {
    return GeneratedIntColumn('reliquat_i_d', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _medicidMeta = const VerificationMeta('medicid');
  GeneratedIntColumn _medicid;
  @override
  GeneratedIntColumn get medicid => _medicid ??= _constructMedicid();
  GeneratedIntColumn _constructMedicid() {
    return GeneratedIntColumn('medicid', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES medics(medic_i_d)');
  }

  final VerificationMeta _quantiteMeta = const VerificationMeta('quantite');
  GeneratedRealColumn _quantite;
  @override
  GeneratedRealColumn get quantite => _quantite ??= _constructQuantite();
  GeneratedRealColumn _constructQuantite() {
    return GeneratedRealColumn(
      'quantite',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isvalidMeta = const VerificationMeta('isvalid');
  GeneratedBoolColumn _isvalid;
  @override
  GeneratedBoolColumn get isvalid => _isvalid ??= _constructIsvalid();
  GeneratedBoolColumn _constructIsvalid() {
    return GeneratedBoolColumn('isvalid', $tableName, false,
        defaultValue: Constant(true));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [reliquatID, medicid, quantite, date, isvalid];
  @override
  $ReliquatsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'reliquats';
  @override
  final String actualTableName = 'reliquats';
  @override
  VerificationContext validateIntegrity(Insertable<Reliquat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reliquat_i_d')) {
      context.handle(
          _reliquatIDMeta,
          reliquatID.isAcceptableOrUnknown(
              data['reliquat_i_d'], _reliquatIDMeta));
    }
    if (data.containsKey('medicid')) {
      context.handle(_medicidMeta,
          medicid.isAcceptableOrUnknown(data['medicid'], _medicidMeta));
    } else if (isInserting) {
      context.missing(_medicidMeta);
    }
    if (data.containsKey('quantite')) {
      context.handle(_quantiteMeta,
          quantite.isAcceptableOrUnknown(data['quantite'], _quantiteMeta));
    } else if (isInserting) {
      context.missing(_quantiteMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('isvalid')) {
      context.handle(_isvalidMeta,
          isvalid.isAcceptableOrUnknown(data['isvalid'], _isvalidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {reliquatID};
  @override
  Reliquat map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Reliquat.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ReliquatsTable createAlias(String alias) {
    return $ReliquatsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  $PatientsTable _patients;
  $PatientsTable get patients => _patients ??= $PatientsTable(this);
  $MedicsTable _medics;
  $MedicsTable get medics => _medics ??= $MedicsTable(this);
  $DosesTable _doses;
  $DosesTable get doses => _doses ??= $DosesTable(this);
  $ReliquatsTable _reliquats;
  $ReliquatsTable get reliquats => _reliquats ??= $ReliquatsTable(this);
  PasswordDao _passwordDao;
  PasswordDao get passwordDao =>
      _passwordDao ??= PasswordDao(this as AppDatabase);
  PatientDao _patientDao;
  PatientDao get patientDao => _patientDao ??= PatientDao(this as AppDatabase);
  MedicDao _medicDao;
  MedicDao get medicDao => _medicDao ??= MedicDao(this as AppDatabase);
  DoseDao _doseDao;
  DoseDao get doseDao => _doseDao ??= DoseDao(this as AppDatabase);
  ReliquatDao _reliquatDao;
  ReliquatDao get reliquatDao =>
      _reliquatDao ??= ReliquatDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [passwords, patients, medics, doses, reliquats];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PasswordDaoMixin on DatabaseAccessor<AppDatabase> {
  $PasswordsTable get passwords => attachedDatabase.passwords;
}
mixin _$PatientDaoMixin on DatabaseAccessor<AppDatabase> {
  $PatientsTable get patients => attachedDatabase.patients;
}
mixin _$MedicDaoMixin on DatabaseAccessor<AppDatabase> {
  $MedicsTable get medics => attachedDatabase.medics;
}
mixin _$DoseDaoMixin on DatabaseAccessor<AppDatabase> {
  $DosesTable get doses => attachedDatabase.doses;
  $PatientsTable get patients => attachedDatabase.patients;
  $MedicsTable get medics => attachedDatabase.medics;
}
mixin _$ReliquatDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReliquatsTable get reliquats => attachedDatabase.reliquats;
  $MedicsTable get medics => attachedDatabase.medics;
}
