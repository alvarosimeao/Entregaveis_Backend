-- Requer DDL e DML. Demonstra atomicidade e rollback.
CREATE OR REPLACE FUNCTION loja_backend.registrar_pedido(
    p_cliente BIGINT, p_produto BIGINT, p_quantidade INTEGER
) RETURNS BIGINT LANGUAGE plpgsql AS $$
DECLARE
    v_pedido BIGINT;
    v_preco NUMERIC(12,2);
BEGIN
    IF p_quantidade <= 0 THEN
        RAISE EXCEPTION 'Quantidade deve ser positiva' USING ERRCODE = '23514';
    END IF;

    SELECT preco INTO v_preco FROM loja_backend.produtos WHERE id = p_produto;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto inexistente' USING ERRCODE = '23503';
    END IF;

    UPDATE loja_backend.estoque
       SET quantidade = quantidade - p_quantidade
     WHERE produto_id = p_produto AND quantidade >= p_quantidade;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Estoque insuficiente' USING ERRCODE = '23514';
    END IF;

    INSERT INTO loja_backend.pedidos (cliente_id, status)
    VALUES (p_cliente, 'confirmado') RETURNING id INTO v_pedido;

    INSERT INTO loja_backend.itens_pedido
        (pedido_id, produto_id, quantidade, preco_unitario)
    VALUES (v_pedido, p_produto, p_quantidade, v_preco);

    RETURN v_pedido;
END;
$$;

-- Sucesso: pedido e baixa de estoque são confirmados juntos.
BEGIN;
SELECT loja_backend.registrar_pedido(1, 1, 1) AS pedido_criado;
COMMIT;

-- ROLLBACK explícito: a alteração experimental não permanece.
BEGIN;
UPDATE loja_backend.estoque SET quantidade = quantidade - 1 WHERE produto_id = 2;
ROLLBACK;

-- Falha por saldo insuficiente. O bloco de exceção reverte automaticamente
-- a subtransação; nenhum pedido e nenhuma baixa são gravados.
DO $$
BEGIN
    PERFORM loja_backend.registrar_pedido(1, 1, 999999);
    RAISE EXCEPTION 'O teste deveria falhar';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'Falha esperada: estoque insuficiente; alterações revertidas';
END;
$$;

SELECT produto_id, quantidade FROM loja_backend.estoque WHERE produto_id IN (1, 2);
