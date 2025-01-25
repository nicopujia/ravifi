// GENERATED CODE DO NOT EDIT
// This file should be version controlled
import 'package:brick_sqlite/db.dart';
part '20250125213653.migration.dart';
part '20250123185629.migration.dart';
part '20250123203726.migration.dart';
part '20250123203901.migration.dart';
part '20250125211458.migration.dart';

/// All intelligently-generated migrations from all `@Migratable` classes on disk
final migrations = <Migration>{
  const Migration20250125213653(),
  const Migration20250123185629(),
  const Migration20250123203726(),
  const Migration20250123203901(),
  const Migration20250125211458()
};

/// A consumable database structure including the latest generated migration.
final schema = Schema(20250125213653, generatorVersion: 1, tables: <SchemaTable>{
  SchemaTable('Log', columns: <SchemaColumn>{
    SchemaColumn('_brick_id', Column.integer,
        autoincrement: true, nullable: false, isPrimaryKey: true),
    SchemaColumn('date', Column.datetime),
    SchemaColumn('weight', Column.Double),
    SchemaColumn('height', Column.Double),
    SchemaColumn('squat', Column.Double),
    SchemaColumn('pull_up', Column.Double),
    SchemaColumn('bench_press', Column.Double),
    SchemaColumn('deadlift', Column.Double),
    SchemaColumn('distance', Column.Double),
    SchemaColumn('time_running', Column.integer),
    SchemaColumn('id', Column.varchar, unique: true)
  }, indices: <SchemaIndex>{
    SchemaIndex(columns: ['id'], unique: true)
  })
});
