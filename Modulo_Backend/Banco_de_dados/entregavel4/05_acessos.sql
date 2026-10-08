CREATE ROLE hotel_leitura NOLOGIN;
CREATE ROLE hotel_operacao NOLOGIN;

CREATE USER usuario_leitura LOGIN;
CREATE USER usuario_operacao LOGIN;

REVOKE CONNECT ON DATABASE nome_do_banco FROM PUBLIC;
GRANT CONNECT ON DATABASE nome_do_banco
    TO hotel_leitura, hotel_operacao;

GRANT USAGE ON SCHEMA public TO hotel_leitura, hotel_operacao;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;

GRANT SELECT ON hotel, quarto, hospede, reserva TO hotel_leitura;

GRANT SELECT ON hotel, quarto, hospede, reserva TO hotel_operacao;
GRANT INSERT ON hospede, reserva TO hotel_operacao;
GRANT UPDATE (status) ON reserva TO hotel_operacao;

GRANT USAGE, SELECT ON SEQUENCE
    hospede_id_hospede_seq, reserva_id_reserva_seq
    TO hotel_operacao;

GRANT hotel_leitura TO usuario_leitura;
GRANT hotel_operacao TO usuario_operacao;