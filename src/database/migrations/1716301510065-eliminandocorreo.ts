import { MigrationInterface, QueryRunner } from "typeorm";

export class Eliminandocorreo1716301510065 implements MigrationInterface {
    name = 'Eliminandocorreo1716301510065'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "user" DROP COLUMN "mail"`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "user" ADD "mail" character varying NOT NULL`);
    }

}
