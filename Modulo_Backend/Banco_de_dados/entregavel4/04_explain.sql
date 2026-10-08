EXPLAIN ANALYZE
SELECT id_reserva, data_reserva, check_in_previsto,
       check_out_previsto, status, valor_total
FROM reserva
WHERE id_hospede = (
    SELECT id_hospede
    FROM hospede
    WHERE cpf = '12345678901'
)
ORDER BY data_reserva DESC;


EXPLAIN ANALYZE
SELECT quarto.numero, quarto.tipo, quarto.capacidade, quarto.valor_diaria
FROM quarto
JOIN hotel ON hotel.id_hotel = quarto.id_hotel
WHERE hotel.nome = 'Hotel Exemplo'
  AND quarto.status = 'disponivel';