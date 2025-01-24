// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250123185629_up = [
  InsertTable('Log'),
  InsertColumn('name', Column.varchar, onTable: 'Log'),
  InsertColumn('weight', Column.Double, onTable: 'Log'),
  InsertColumn('height', Column.Double, onTable: 'Log'),
  InsertColumn('squats', Column.Double, onTable: 'Log'),
  InsertColumn('pull_ups', Column.Double, onTable: 'Log'),
  InsertColumn('bench_press', Column.Double, onTable: 'Log'),
  InsertColumn('deadlift', Column.Double, onTable: 'Log'),
  InsertColumn('distance', Column.Double, onTable: 'Log'),
  InsertColumn('time_running', Column.Double, onTable: 'Log'),
  InsertColumn('date', Column.datetime, onTable: 'Log'),
  InsertColumn('id', Column.varchar, onTable: 'Log', unique: true),
  CreateIndex(columns: ['id'], onTable: 'Log', unique: true)
];

const List<MigrationCommand> _migration_20250123185629_down = [
  DropTable('Log'),
  DropColumn('name', onTable: 'Log'),
  DropColumn('weight', onTable: 'Log'),
  DropColumn('height', onTable: 'Log'),
  DropColumn('squats', onTable: 'Log'),
  DropColumn('pull_ups', onTable: 'Log'),
  DropColumn('bench_press', onTable: 'Log'),
  DropColumn('deadlift', onTable: 'Log'),
  DropColumn('distance', onTable: 'Log'),
  DropColumn('time_running', onTable: 'Log'),
  DropColumn('date', onTable: 'Log'),
  DropColumn('id', onTable: 'Log'),
  DropIndex('index_Log_on_id')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250123185629',
  up: _migration_20250123185629_up,
  down: _migration_20250123185629_down,
)
class Migration20250123185629 extends Migration {
  const Migration20250123185629()
    : super(
        version: 20250123185629,
        up: _migration_20250123185629_up,
        down: _migration_20250123185629_down,
      );
}
