import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Passwords extends Table {
  IntColumn get passid => integer().autoIncrement()();
  TextColumn get pass => text().withLength(min: 1, max: 50)();
}

class Patients extends Table {
  IntColumn get patientID => integer().autoIncrement()();
  TextColumn get nom => text().withLength(min: 1, max: 50)();
  TextColumn get prenom => text().withLength(min: 1, max: 50)();
  RealColumn get taille => real()();
  RealColumn get poids => real()();
  RealColumn get surface => real()();
}

class Medics extends Table {
  IntColumn get medicID => integer().autoIncrement()();
  TextColumn get medicNom => text().withLength(min: 1, max: 50)();
  TextColumn get medicLab => text().withLength(min: 1, max: 50)();
  RealColumn get presentation => real()();
  RealColumn get cI => real()();
  RealColumn get cMin => real()();
  RealColumn get cMax => real()();
  IntColumn get nbrFlacon => integer().withDefault(const Constant(0))();
  RealColumn get prix => real()();
  RealColumn get stabilite => real()();
}

class Doses extends Table {
  IntColumn get doseID => integer().autoIncrement()();
  IntColumn get patientid =>
      integer().customConstraint("NOT NULL REFERENCES patients(patient_i_d)")();
  IntColumn get medicid =>
      integer().customConstraint("NOT NULL REFERENCES medics(medic_i_d)")();
  IntColumn get posolgie => integer()();
  DateTimeColumn get date => dateTime()();
}

class Reliquats extends Table {
  IntColumn get reliquatID => integer().autoIncrement()();
  IntColumn get medicid =>
      integer().customConstraint('NOT NULL REFERENCES medics(medic_i_d)')();
  RealColumn get quantite => real()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isvalid => boolean().withDefault(Constant(true))();
}

@UseMoor(
    tables: [Passwords, Patients, Medics, Doses, Reliquats],
    daos: [PasswordDao, PatientDao, MedicDao, DoseDao, ReliquatDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'lllsll.sqlite', logStatements: true)); //lklknsm

  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Runs if the database has already been opened on the device with a lower version
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.createTable(passwords);
            await migrator.createTable(patients);
            await migrator.createTable(medics);
          } else if (from == 2) {
            await migrator.createTable(doses);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
          if (details.wasCreated) {
            await into(passwords)
                .insert(Password(pass: 'Khaled2020', passid: null));
            await into(patients).insert(Patient(
                nom: "Khaled",
                patientID: null,
                poids: 84,
                prenom: "Sakhri",
                surface: 32,
                taille: 187));
          }
        },
      );
}

@UseDao(tables: [Passwords])
class PasswordDao extends DatabaseAccessor<AppDatabase>
    with _$PasswordDaoMixin {
  final AppDatabase db;

  PasswordDao(this.db) : super(db);
  Future<List<Password>> getAllPasswords() => select(passwords).get();
  Stream<List<Password>> watchAllPasswords() => select(passwords).watch();
  Future insertPassword(Insertable<Password> password) =>
      into(passwords).insert(password);
  Future updatePassword(Insertable<Password> password) =>
      update(passwords).replace(password);
}

@UseDao(tables: [Patients])
class PatientDao extends DatabaseAccessor<AppDatabase> with _$PatientDaoMixin {
  final AppDatabase db;
  PatientDao(this.db) : super(db);
  Stream<List<Patient>> watchAllPatients() => select(patients).watch();
  Future insertPatient(Insertable<Patient> patient) =>
      into(patients).insert(patient);
  Future updatePatient(Insertable<Patient> patient) =>
      update(patients).replace(patient);
  Future deletePatient(Insertable<Patient> patient) =>
      delete(patients).delete(patient);
  Future<int> countPatients() async => (await select(patients).get()).length;
}

@UseDao(tables: [Medics])
class MedicDao extends DatabaseAccessor<AppDatabase> with _$MedicDaoMixin {
  final AppDatabase db;
  MedicDao(this.db) : super(db);
  Stream<List<Medic>> watchAllMedics() => select(medics).watch();
  Future insertMedic(Insertable<Medic> medic) => into(medics).insert(medic);
  Future updateMedic(Insertable<Medic> medic) => update(medics).replace(medic);
  Future deleteMedics(Insertable<Medic> medic) => delete(medics).delete(medic);
  Future<int> countMedics() async => (await select(medics).get()).length;
}

class DoseWithMedicsAndPatients {
  final Patient patient;
  final Medic medic;
  final Dose dose;

  DoseWithMedicsAndPatients(
      {@required this.dose, @required this.medic, @required this.patient});
}

@UseDao(tables: [
  Doses,
  Patients,
  Medics
], queries: {
  'countUsedMedics':
      'SELECT COUNT(DISTINCT medicid) FROM doses'
})
class DoseDao extends DatabaseAccessor<AppDatabase> with _$DoseDaoMixin {
  final AppDatabase db;
  DoseDao(this.db) : super(db);
  Stream<List<DoseWithMedicsAndPatients>> watchAllDoses() => select(doses)
      .join([
        leftOuterJoin(medics, medics.medicID.equalsExp(doses.medicid)),
        leftOuterJoin(patients, patients.patientID.equalsExp(doses.patientid))
      ])
      .watch()
      .map((rows) => rows.map((row) {
            return DoseWithMedicsAndPatients(
                dose: row.readTable(doses),
                medic: row.readTable(medics),
                patient: row.readTable(patients));
          }).toList());

  /*uture<double> getSum(Medic m) async =>
      (await sumOfReliquatsForSelectedMedic(m.medicID,DateTime.now()).getSingle()); */

  Future<int> getUsedMedicsToday() async =>
      (await countUsedMedics().getSingle());

  Future insertDose(Insertable<Dose> dose) => into(doses).insert(dose);
}

class ReliquatWithMedics {
  final Reliquat reliquat;
  final Medic medic;

  ReliquatWithMedics({@required this.medic, @required this.reliquat});
}

class ReliquatWithSum {
  final double sum;
  ReliquatWithSum({@required this.sum});
}

@UseDao(tables: [
  Reliquats,
  Medics
], queries: {
  'sumOfReliquatsForSelectedMedic':
      'SELECT SUM(quantite) FROM reliquats WHERE medicid=:id AND date>:now',
  'sumOfReliquatsPerimeForSelectedMedic':
      'SELECT SUM(quantite) FROM reliquats WHERE medicid=:id AND date<:now'
})
class ReliquatDao extends DatabaseAccessor<AppDatabase>
    with _$ReliquatDaoMixin {
  final AppDatabase db;
  ReliquatDao(this.db) : super(db);

  Stream<List<ReliquatWithMedics>> watchAllReliquats() => select(reliquats)
      .join([
        leftOuterJoin(medics, medics.medicID.equalsExp(reliquats.medicid)),
      ])
      .watch()
      .map((rows) => rows.map((row) {
            return ReliquatWithMedics(
                medic: row.readTable(medics),
                reliquat: row.readTable(reliquats));
          }).toList());

  Stream<List<ReliquatWithMedics>> watchStats() {
    final query = (selectOnly(reliquats,distinct: true)..addColumns([reliquats.medicid])).join([
      leftOuterJoin(medics, medics.medicID.equalsExp(reliquats.medicid)),
    ]);

    query.where(medics.nbrFlacon.isBiggerThanValue(0));

    return query.watch().map((rows) => rows.map((row) {
          return ReliquatWithMedics(
              medic: row.readTable(medics), reliquat: row.readTable(reliquats));
        }).toList());
  }

  Stream<List<ReliquatWithMedics>> watchAllReliquatsExpired() =>
      (select(reliquats)
            ..where((tbl) => tbl.date.isSmallerThanValue(DateTime.now())))
          .join([
            leftOuterJoin(medics, medics.medicID.equalsExp(reliquats.medicid)),
          ])
          .watch()
          .map((rows) => rows.map((row) {
                return ReliquatWithMedics(
                    medic: row.readTable(medics),
                    reliquat: row.readTable(reliquats));
              }).toList());

  Stream<List<ReliquatWithMedics>> watchAllReliquatsNotExpired() =>
      (select(reliquats)
            ..where((tbl) => tbl.date.isBiggerThanValue(DateTime.now())))
          .join([
            leftOuterJoin(medics, medics.medicID.equalsExp(reliquats.medicid)),
          ])
          .watch()
          .map((rows) => rows.map((row) {
                return ReliquatWithMedics(
                    medic: row.readTable(medics),
                    reliquat: row.readTable(reliquats));
              }).toList());
  Stream<List<Reliquat>> getReliquatsOfMedic(Medic m) =>
      (select(reliquats)..where((tbl) => tbl.medicid.equals(m.medicID)))
          .watch();

  Future<double> getSum(Medic m) async =>
      (await sumOfReliquatsForSelectedMedic(m.medicID, DateTime.now())
          .getSingle());
  Future<double> getSumPerime(Medic m) async =>
      (await sumOfReliquatsPerimeForSelectedMedic(m.medicID, DateTime.now())
          .getSingle());
  

  Future insertReliquat(Insertable<Reliquat> reliquat) =>
      into(reliquats).insert(reliquat);
  Future deleteReliquat(Insertable<Reliquat> reliquat) =>
      delete(reliquats).delete(reliquat);
  Future updateReliquar(Insertable<Reliquat> reliquat) {
    return transaction(() async {
      await update(reliquats).replace(reliquat);
    });
  }
}
