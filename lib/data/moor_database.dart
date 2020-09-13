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

@UseMoor(tables: [Passwords, Patients], daos: [PasswordDao,PatientDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'newdb.sqlite', logStatements: true));

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
            
          }
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            await into(passwords)
                .insert(Password(pass: 'Khaled2020', passid: null));
            await into(patients)
                .insert(Patient(nom: "Khaled",patientID: null,poids: 84,prenom: "Sakhri",surface: 32,taille: 187));
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