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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  $PatientsTable _patients;
  $PatientsTable get patients => _patients ??= $PatientsTable(this);
  PasswordDao _passwordDao;
  PasswordDao get passwordDao =>
      _passwordDao ??= PasswordDao(this as AppDatabase);
  PatientDao _patientDao;
  PatientDao get patientDao => _patientDao ??= PatientDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [passwords, patients];
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