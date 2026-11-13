-- Busca do histórico de um cliente por data.
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente_data
    ON loja_backend.pedidos (cliente_id, criado_em DESC);

-- Fila/relatório de pedidos por status e período.
CREATE INDEX IF NOT EXISTS idx_pedidos_status_data
    ON loja_backend.pedidos (status, criado_em DESC);

-- Avaliar planos com volume de dados representativo. Com cinco linhas,
-- o PostgreSQL pode escolher Seq Scan sem que o índice esteja errado.
EXPLAIN SELECT id, status, criado_em
FROM loja_backend.pedidos
WHERE cliente_id = 1
ORDER BY criado_em DESC;

EXPLAIN SELECT id, criado_em
FROM loja_backend.pedidos
WHERE status = 'aberto'
ORDER BY criado_em DESC;
