BEGIN;

WITH novo_hotel AS (
    INSERT INTO hotel (
        nome, endereco, cidade, estado, telefone, categoria
    )
    VALUES (
        'Hotel de Teste', 'Rua de Teste, 1', 'Campinas', 'SP',
        '1930000000', '2 estrelas'
    )
    RETURNING id_hotel
)
INSERT INTO quarto (
    id_hotel, numero, tipo, capacidade, valor_diaria, andar
)
SELECT id_hotel, '901', 'Standard', 2, 150.00, 9
FROM novo_hotel
RETURNING id_quarto;

COMMIT;


BEGIN;

WITH novo_hospede AS (
    INSERT INTO hospede (
        nome, cpf, data_nascimento, telefone, email, endereco
    )
    VALUES (
        'Pessoa de Teste', '34567890123', '2001-01-15',
        '11999992222', 'teste@example.com', 'Rua C, 30'
    )
    RETURNING id_hospede
),
nova_reserva AS (
    INSERT INTO reserva (
        id_hospede, id_quarto, check_in_previsto, check_out_previsto,
        quantidade_hospedes, status, valor_total
    )
    SELECT novo_hospede.id_hospede,
           quarto.id_quarto,
           CURRENT_DATE + 20,
           CURRENT_DATE + 22,
           1,
           'pendente',
           400.00
    FROM novo_hospede
    JOIN quarto ON quarto.numero = '101'
    JOIN hotel ON hotel.id_hotel = quarto.id_hotel
    WHERE hotel.nome = 'Hotel Exemplo'
    RETURNING id_reserva, id_hospede
)
SELECT id_reserva FROM nova_reserva;

SAVEPOINT antes_da_alteracao;

UPDATE reserva
SET status = 'confirmada'
WHERE id_hospede = (
    SELECT id_hospede
    FROM hospede
    WHERE cpf = '34567890123'
);

ROLLBACK TO SAVEPOINT antes_da_alteracao;
ROLLBACK;