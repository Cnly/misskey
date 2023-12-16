export class AddPgroongaIndices1702725216067 {
    name = 'AddPgroongaIndices1702725216067'

    async up(queryRunner) {
			await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS pgroonga;`);
      await queryRunner.query(`CREATE INDEX IDX_PGROONGA_NOTE_TEXT ON "note" USING pgroonga ("text");`);
    }

    async down(queryRunner) {
      await queryRunner.query(`DROP INDEX IDX_PGROONGA_NOTE_TEXT;`);
    }

}
