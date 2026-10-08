CREATE TYPE status_quarto AS ENUM (
    'disponivel',
    'manutencao',
    'inativo'
);

CREATE TYPE status_reserva AS ENUM (
    'pendente',
    'confirmada',
    'cancelada',
    'finalizada'
);

CREATE TABLE hotel (
    id_hotel BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    categoria VARCHAR(50)
);

CREATE TABLE quarto (
    id_quarto BIGSERIAL PRIMARY KEY,
    id_hotel BIGINT NOT NULL REFERENCES hotel(id_hotel),
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0),
    valor_diaria NUMERIC(10, 2) NOT NULL CHECK (valor_diaria >= 0),
    andar INTEGER NOT NULL CHECK (andar >= 0),
    status status_quarto NOT NULL DEFAULT 'disponivel',
    UNIQUE (id_hotel, numero)
);

CREATE TABLE hospede (
    id_hospede BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE,
    endereco VARCHAR(150)
);

CREATE TABLE reserva (
    id_reserva BIGSERIAL PRIMARY KEY,
    id_hospede BIGINT NOT NULL REFERENCES hospede(id_hospede),
    id_quarto BIGINT NOT NULL REFERENCES quarto(id_quarto),
    data_reserva TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    check_in_previsto DATE NOT NULL,
    check_out_previsto DATE NOT NULL,
    quantidade_hospedes INTEGER NOT NULL CHECK (quantidade_hospedes > 0),
    status status_reserva NOT NULL DEFAULT 'pendente',
    valor_total NUMERIC(10, 2) NOT NULL CHECK (valor_total >= 0),
    CHECK (check_out_previsto > check_in_previsto)
);

CREATE INDEX quarto_hotel_status_idx
    ON quarto (id_hotel, status);

CREATE INDEX reserva_hospede_data_idx
    ON reserva (id_hospede, data_reserva DESC);

CREATE INDEX reserva_quarto_checkin_idx
    ON reserva (id_quarto, check_in_previsto);