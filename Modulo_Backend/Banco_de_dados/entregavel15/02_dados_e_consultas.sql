-- Requer 01_ddl.sql. IDs fixos apenas para facilitar a demonstração.
INSERT INTO loja_backend.clientes (id, nome, email) VALUES
  (1, 'Ana Lima', 'ana@example.test'),
  (2, 'Bruno Reis', 'bruno@example.test')
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.produtos (id, sku, nome, preco) VALUES
  (1, 'CAM-001', 'Camiseta Azul', 79.90),
  (2, 'FON-001', 'Fone Bluetooth', 249.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.estoque (produto_id, quantidade) VALUES
  (1, 12), (2, 14)
ON CONFLICT (produto_id) DO NOTHING;

INSERT INTO loja_backend.pedidos (id, cliente_id, status) VALUES
  (1, 1, 'confirmado'), (2, 2, 'confirmado')
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (1, 1, 2, 79.90), (2, 2, 1, 249.00)
ON CONFLICT (pedido_id, produto_id) DO NOTHING;

-- Ajusta as sequências após IDs explícitos para futuros INSERTs sem ID.
SELECT setval(pg_get_serial_sequence('loja_backend.clientes', 'id'),
              (SELECT MAX(id) FROM loja_backend.clientes), true);
SELECT setval(pg_get_serial_sequence('loja_backend.produtos', 'id'),
              (SELECT MAX(id) FROM loja_backend.produtos), true);
SELECT setval(pg_get_serial_sequence('loja_backend.pedidos', 'id'),
              (SELECT MAX(id) FROM loja_backend.pedidos), true);

-- JOIN 1: pedidos e cliente.
SELECT p.id AS pedido, c.nome AS cliente, p.status
FROM loja_backend.pedidos p
JOIN loja_backend.clientes c ON c.id = p.cliente_id
ORDER BY p.id;

-- JOIN 2: total calculado pelos itens, sem duplicá-lo em pedidos.
SELECT p.id AS pedido, pr.nome AS produto,
       i.quantidade, i.preco_unitario,
       i.quantidade * i.preco_unitario AS subtotal
FROM loja_backend.pedidos p
JOIN loja_backend.itens_pedido i ON i.pedido_id = p.id
JOIN loja_backend.produtos pr ON pr.id = i.produto_id
ORDER BY p.id;

-- Teste negativo opcional: executar isoladamente; deve falhar por FK inexistente.
-- INSERT INTO loja_backend.pedidos (cliente_id) VALUES (999999);
