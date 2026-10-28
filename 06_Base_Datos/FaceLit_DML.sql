-- FACELIT-DB | DML existente en repositorio.
-- ATENCION: revisar dependencias, credenciales de ejemplo y orden antes de ejecutar.
-- No ejecutar dos veces sin verificar idempotencia.

-- ORIGEN: 02_dml/00_inserts/seed.sql
-- V4: roles
INSERT INTO roleandpermission.role (id_role, name_rol, created_at)
VALUES
    (uuid_generate_v4(), 'APPRENTICE', NOW()),
    (uuid_generate_v4(), 'INSTRUCTOR', NOW()),
    (uuid_generate_v4(), 'COORDINATOR', NOW())
ON CONFLICT (name_rol) DO NOTHING;

-- V4: permisos, uno por cada accion real que quedo definida por modulo/rol en el diseño
INSERT INTO roleandpermission.permission (id_permission, name_permission, descripcion, created_at)
VALUES
    -- Perfil y Personalizacion (RF-9) - los 3 roles
    (uuid_generate_v4(), 'VIEW_OWN_PROFILE', 'Ver perfil propio (solo lectura)', NOW()),
    (uuid_generate_v4(), 'MANAGE_OWN_CONFIGURATION', 'Configurar idioma, tema y notificaciones propias', NOW()),

    -- Notificaciones (RF-8) - los 3 roles, cada uno ve solo las suyas
    (uuid_generate_v4(), 'VIEW_OWN_NOTIFICATIONS', 'Ver y marcar como leidas las notificaciones propias', NOW()),

    -- Reconocimiento Facial (RF-5.4) - Aprendiz
    (uuid_generate_v4(), 'VIEW_OWN_ATTENDANCE', 'Ver la asistencia propia', NOW()),
    (uuid_generate_v4(), 'REGISTER_FACE', 'Registrar el rostro propio (una sola vez)', NOW()),
    (uuid_generate_v4(), 'REQUEST_FACE_RESET', 'Solicitar restablecimiento del registro facial propio', NOW()),

    -- Gestion de Ambiente / Sesion de Reconocimiento Facial - Instructor
    (uuid_generate_v4(), 'CONFIGURE_RECOGNITION_SESSION', 'Configurar y editar sesiones de reconocimiento facial (ambiente, ficha, instructor a cargo, ajustes)', NOW()),
    (uuid_generate_v4(), 'VIEW_FICHA_ATTENDANCE', 'Ver la asistencia de las fichas asignadas', NOW()),

    -- Gestion Academica (RF-3) y Gestion de Usuarios - Coordinador
    (uuid_generate_v4(), 'VIEW_ALL_ATTENDANCE', 'Ver la asistencia de cualquier programa, ficha o aprendiz', NOW()),
    (uuid_generate_v4(), 'MANAGE_ACADEMIC', 'Crear, editar, desactivar y trasladar programas, fichas, aprendices e instructores (CSV y manual)', NOW()),
    (uuid_generate_v4(), 'MANAGE_USERS', 'Crear y editar usuarios con cualquier rol (Aprendiz, Instructor o Coordinador)', NOW()),
    (uuid_generate_v4(), 'RESOLVE_FACE_RESET_REQUEST', 'Aceptar o rechazar solicitudes de restablecimiento de reconocimiento facial', NOW())
ON CONFLICT (name_permission) DO NOTHING;

-- APPRENTICE
INSERT INTO roleandpermission.role_permission (id_role_permission, id_role, id_permission, assigned_at, created_at)
SELECT uuid_generate_v4(), r.id_role, p.id_permission, NOW(), NOW()
FROM roleandpermission.role r
CROSS JOIN roleandpermission.permission p
WHERE r.name_rol = 'APPRENTICE'
  AND p.name_permission IN (
      'VIEW_OWN_PROFILE',
      'MANAGE_OWN_CONFIGURATION',
      'VIEW_OWN_NOTIFICATIONS',
      'VIEW_OWN_ATTENDANCE',
      'REGISTER_FACE',
      'REQUEST_FACE_RESET'
  )
ON CONFLICT (id_role, id_permission) DO NOTHING;

-- INSTRUCTOR
INSERT INTO roleandpermission.role_permission (id_role_permission, id_role, id_permission, assigned_at, created_at)
SELECT uuid_generate_v4(), r.id_role, p.id_permission, NOW(), NOW()
FROM roleandpermission.role r
CROSS JOIN roleandpermission.permission p
WHERE r.name_rol = 'INSTRUCTOR'
  AND p.name_permission IN (
      'VIEW_OWN_PROFILE',
      'MANAGE_OWN_CONFIGURATION',
      'VIEW_OWN_NOTIFICATIONS',
      'CONFIGURE_RECOGNITION_SESSION',
      'VIEW_FICHA_ATTENDANCE'
  )
ON CONFLICT (id_role, id_permission) DO NOTHING;

-- COORDINATOR
INSERT INTO roleandpermission.role_permission (id_role_permission, id_role, id_permission, assigned_at, created_at)
SELECT uuid_generate_v4(), r.id_role, p.id_permission, NOW(), NOW()
FROM roleandpermission.role r
CROSS JOIN roleandpermission.permission p
WHERE r.name_rol = 'COORDINATOR'
  AND p.name_permission IN (
      'VIEW_OWN_PROFILE',
      'MANAGE_OWN_CONFIGURATION',
      'VIEW_OWN_NOTIFICATIONS',
      'VIEW_ALL_ATTENDANCE',
      'MANAGE_ACADEMIC',
      'MANAGE_USERS',
      'RESOLVE_FACE_RESET_REQUEST'
  )
ON CONFLICT (id_role, id_permission) DO NOTHING;

-- ORIGEN: 02_dml/00_inserts/002_seed_coordinator.sql
-- 02_dml/00_inserts/002_seed_coordinator.sql
-- Semilla del primer Coordinador -- VERSION CON DATOS QUEMADOS.
-- Idempotente: si ya existe un user_app con ese numero de documento, no inserta de nuevo.
-- Requiere que el rol COORDINATOR ya exista en roleandpermission.role (lo crea seed.sql).

DO $$
DECLARE
    v_id_role     UUID;
    v_id_user_app UUID;

    -- === DATOS QUEMADOS: sin ${} en ningun lado, solo el valor entre comillas ===
    v_first_name     VARCHAR := 'Maria';
    v_last_name      VARCHAR := 'Rodriguez';
    v_document       VARCHAR := '1000000000';
    v_email          VARCHAR := 'maria.rodriguez@example.com';
    -- IMPORTANTE: este NO es un hash real, es un valor de relleno.
    -- '$Maria123!' que tenias antes NO es un hash BCrypt, es la contraseña en texto plano
    -- puesta a mano -- eso es justo lo que el flujo pide evitar. Genera uno real
    -- (ver LEEME del zip anterior: node -e "console.log(require('bcryptjs').hashSygit nc('...',10))")
    v_password_hash  VARCHAR := '$2a$10$CRVBklZIU9afGYM8Rc07cOZoNpRJhqJW82fli1ZQNbLEcJ2rRQIW.';
    -- ================================================================

BEGIN
    SELECT id_role INTO v_id_role
    FROM roleandpermission.role
    WHERE name_rol = 'COORDINATOR';

    IF v_id_role IS NULL THEN
        RAISE EXCEPTION 'No existe el rol COORDINATOR en roleandpermission.role. Ejecuta primero el changeset facelit-model-seed.';
    END IF;

    SELECT id_user_app INTO v_id_user_app
    FROM security.user_app
    WHERE number_document = v_document;

    IF v_id_user_app IS NULL THEN

        INSERT INTO security.user_app (
            id_user_app, first_name, last_name, account_status, number_document,
            created_at, created_by
        ) VALUES (
            uuid_generate_v4(), v_first_name, v_last_name, 'ACTIVE', v_document,
            NOW(), 'liquibase-seed'
        )
        RETURNING id_user_app INTO v_id_user_app;

        INSERT INTO security.credential (
            id_credential, id_user_app, email, password_hash, credential_status,
            created_at, created_by
        ) VALUES (
            uuid_generate_v4(), v_id_user_app, v_email, v_password_hash, 'ACTIVE',
            NOW(), 'liquibase-seed'
        );

        INSERT INTO roleandpermission.user_role (
            id_user_role, id_user_app, id_role, asigned_at, created_at, created_by
        ) VALUES (
            uuid_generate_v4(), v_id_user_app, v_id_role, NOW(), NOW(), 'liquibase-seed'
        );

    ELSE
        RAISE NOTICE 'Ya existe un user_app con number_document=%, no se inserta de nuevo.', v_document;
    END IF;
END $$;

-- ORIGEN: 02_dml/04_patches/001_rename_role_values_to_english.sql
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM roleandpermission.role
        WHERE name_rol IN ('APRENDIZ', 'COORDINADOR')
    ) AND EXISTS (
        SELECT 1
        FROM roleandpermission.role
        WHERE name_rol IN ('APPRENTICE', 'COORDINATOR')
    ) THEN
        RAISE EXCEPTION 'Cannot rename roles because Spanish and English values already coexist.';
    END IF;

    UPDATE roleandpermission.role
    SET name_rol = CASE name_rol
        WHEN 'APRENDIZ' THEN 'APPRENTICE'
        WHEN 'COORDINADOR' THEN 'COORDINATOR'
        ELSE name_rol
    END,
        updated_at = NOW(),
        updated_by = 'liquibase-role-migration'
    WHERE name_rol IN ('APRENDIZ', 'COORDINADOR');
END $$;
