-- Requer 01_ddl.sql. Cinco registros em cada tabela principal.
INSERT INTO loja_backend.clientes (id, nome, email) VALUES
  (1, 'Ana Lima', 'ana@example.test'),
  (2, 'Bruno Reis', 'bruno@example.test'),
  (3, 'Carla Melo', 'carla@example.test'),
  (4, 'Diego Luz', 'diego@example.test'),
  (5, 'Elisa Rocha', 'elisa@example.test')
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.produtos (id, sku, nome, preco) VALUES
  (1, 'CAM-001', 'Camiseta Azul', 79.90),
  (2, 'FON-001', 'Fone Bluetooth', 249.00),
  (3, 'MOU-001', 'Mouse Ergonomico', 129.00),
  (4, 'LIV-001', 'Livro SQL', 59.90),
  (5, 'GAR-001', 'Garrafa Termica', 99.90)
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.estoque (produto_id, quantidade) VALUES
  (1, 12), (2, 14), (3, 21), (4, 30), (5, 18)
ON CONFLICT (produto_id) DO NOTHING;

INSERT INTO loja_backend.pedidos (id, cliente_id, status) VALUES
  (1, 1, 'confirmado'), (2, 2, 'confirmado'), (3, 3, 'aberto'),
  (4, 4, 'confirmado'), (5, 5, 'cancelado')
ON CONFLICT (id) DO NOTHING;

INSERT INTO loja_backend.itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (1, 1, 2, 79.90), (2, 2, 1, 249.00), (3, 3, 1, 129.00),
  (4, 4, 2, 59.90), (5, 5, 1, 99.90)
ON CONFLICT (pedido_id, produto_id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('loja_backend.clientes', 'id'),
              (SELECT MAX(id) FROM loja_backend.clientes), true);
SELECT setval(pg_get_serial_sequence('loja_backend.produtos', 'id'),
              (SELECT MAX(id) FROM loja_backend.produtos), true);
SELECT setval(pg_get_serial_sequence('loja_backend.pedidos', 'id'),
              (SELECT MAX(id) FROM loja_backend.pedidos), true);
