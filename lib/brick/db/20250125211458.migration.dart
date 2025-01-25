// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250125211458_up = [
  DropColumn('squats', onTable: 'Log'),
  DropColumn('pull_ups', onTable: 'Log'),
  InsertColumn('squat', Column.Double, onTable: 'Log'),
  InsertColumn('pull_up', Column.Double, onTable: 'Log')
];

const List<MigrationCommand> _migration_20250125211458_down = [
  DropColumn('squat', onTable: 'Log'),
  DropColumn('pull_up', onTable: 'Log')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250125211458',
  up: _migration_20250125211458_up,
  down: _migration_20250125211458_down,
)
class Migration20250125211458 extends Migration {
  const Migration20250125211458()
    : super(
        version: 20250125211458,
        up: _migration_20250125211458_up,
        down: _migration_20250125211458_down,
      );
}
