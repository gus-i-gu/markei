import pg from "pg";

export type Database = {
  pool: pg.Pool;
};

export async function inTransaction<T>(
  database: Database,
  action: (client: pg.PoolClient) => Promise<T>,
): Promise<T> {
  const client = await database.pool.connect();
  try {
    await client.query("begin isolation level serializable");
    const result = await action(client);
    await client.query("commit");
    return result;
  } catch (error) {
    await client.query("rollback");
    throw error;
  } finally {
    client.release();
  }
}
