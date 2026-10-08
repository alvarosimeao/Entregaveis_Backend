INSERT INTO hotel (nome, endereco, cidade, estado, telefone, categoria)
VALUES
    ('Hotel Exemplo', 'Rua Central, 100', 'São Paulo', 'SP',
     '1130000000', '3 estrelas'),
    ('Hotel Praia', 'Avenida Beira-Mar, 200', 'Santos', 'SP',
     '1330000000', '4 estrelas');

INSERT INTO quarto (
    id_hotel, numero, tipo, capacidade, valor_diaria, andar, status
)
SELECT id_hotel, '101', 'Standard', 2, 200.00, 1, 'disponivel'
FROM hotel
WHERE nome = 'Hotel Exemplo';

INSERT INTO quarto (
    id_hotel, numero, tipo, capacidade, valor_diaria, andar, status
)
SELECT id_hotel, '102', 'Luxo', 3, 280.00, 1, 'disponivel'
FROM hotel
WHERE nome = 'Hotel Exemplo';

INSERT INTO quarto (
    id_hotel, numero, tipo, capacidade, valor_diaria, andar, status
)
SELECT id_hotel, '201', 'Standard', 2, 250.00, 2, 'disponivel'
FROM hotel
WHERE nome = 'Hotel Praia';

INSERT INTO hospede (
    nome, cpf, data_nascimento, telefone, email, endereco
)
VALUES
    ('Maria Souza', '12345678901', '2000-05-10',
     '11999990000', 'maria@example.com', 'Rua A, 10'),
    ('João Lima', '23456789012', '1998-08-20',
     '11999991111', 'joao@example.com', 'Rua B, 20');

INSERT INTO reserva (
    id_hospede, id_quarto, check_in_previsto, check_out_previsto,
    quantidade_hospedes, status, valor_total
)
SELECT h.id_hospede, q.id_quarto, CURRENT_DATE + 10, CURRENT_DATE + 12,
       2, 'confirmada', 400.00
FROM hospede h
JOIN quarto q ON q.numero = '101'
JOIN hotel ht ON ht.id_hotel = q.id_hotel
WHERE h.cpf = '12345678901'
  AND ht.nome = 'Hotel Exemplo';

INSERT INTO reserva (
    id_hospede, id_quarto, check_in_previsto, check_out_previsto,
    quantidade_hospedes, status, valor_total
)
SELECT h.id_hospede, q.id_quarto, CURRENT_DATE + 15, CURRENT_DATE + 17,
       2, 'pendente', 560.00
FROM hospede h
JOIN quarto q ON q.numero = '102'
JOIN hotel ht ON ht.id_hotel = q.id_hotel
WHERE h.cpf = '23456789012'
  AND ht.nome = 'Hotel Exemplo';