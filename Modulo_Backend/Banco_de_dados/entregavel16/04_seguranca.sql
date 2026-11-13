-- Executar como proprietário do esquema com privilégio CREATEROLE.
-- LOGIN sem senha definida: configure autenticação local com segurança antes
-- de usar as contas fora deste exercício; nenhuma senha é guardada no Git.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loja_admin') THEN
        CREATE ROLE loja_admin LOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'loja_analista') THEN
        CREATE ROLE loja_analista LOGIN;
    END IF;
END;
$$;

REVOKE ALL ON SCHEMA loja_backend FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA loja_backend FROM PUBLIC;
GRANT USAGE ON SCHEMA loja_backend TO loja_admin, loja_analista;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA loja_backend TO loja_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA loja_backend TO loja_admin;
GRANT SELECT ON ALL TABLES IN SCHEMA loja_backend TO loja_analista;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA loja_backend FROM loja_analista;
