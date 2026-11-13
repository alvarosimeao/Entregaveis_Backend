-- Requer 01_faturas.sql. A última operação falha intencionalmente.
CREATE OR REPLACE FUNCTION erp_financeiro.debitar(p_conta BIGINT, p_valor NUMERIC)
RETURNS VOID LANGUAGE plpgsql AS $$
BEGIN
    IF p_valor <= 0 THEN
        RAISE EXCEPTION 'O valor deve ser positivo';
    END IF;

    UPDATE erp_financeiro.contas
       SET saldo = saldo - p_valor
     WHERE id = p_conta AND saldo >= p_valor;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Saldo insuficiente ou conta inexistente';
    END IF;
END;
$$;

-- Demonstração de sucesso: R$ 20 são debitados atomicamente.
BEGIN;
SELECT erp_financeiro.debitar(1, 20.00);
COMMIT;

-- Demonstração de falha: nenhum saldo negativo é gravado.
BEGIN;
SELECT erp_financeiro.debitar(1, 999999.00);
ROLLBACK;

SELECT id, cliente_nome, saldo FROM erp_financeiro.contas WHERE id = 1;
