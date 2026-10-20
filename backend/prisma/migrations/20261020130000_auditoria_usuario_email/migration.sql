-- Email del responsable en cada fila de auditoría (PoC 3 de Facturación).
-- Para que la atribución no dependa de que el usuario siga existiendo, se
-- guarda su email junto al id. Se rellena en las filas que ya había.
--
-- El blindaje de la propia tabla auditoria (FK ON DELETE RESTRICT y los
-- triggers append-only) vive en el módulo de Auth/Auditoría (PR de Dereck),
-- que es el dueño de esa tabla; aquí solo se agrega la columna de atribución.
ALTER TABLE "auditoria" ADD COLUMN "usuario_email" VARCHAR(150);

UPDATE "auditoria" a
SET "usuario_email" = u."email"
FROM "usuarios" u
WHERE a."usuario_id" = u."id";
