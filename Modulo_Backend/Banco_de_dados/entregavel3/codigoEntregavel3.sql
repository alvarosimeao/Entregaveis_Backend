-- Semana 03 - Modelo Logico Estruturado (3FN)
-- Sistema de Reservas de Hotel

CREATE DATABASE IF NOT EXISTS hotelaria_semana_03;
USE hotelaria_semana_03;

CREATE TABLE hotel (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

CREATE TABLE quarto (
    id_quarto INT AUTO_INCREMENT PRIMARY KEY,
    id_hotel INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade INT NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    andar INT NOT NULL,
    status ENUM('DISPONIVEL', 'OCUPADO', 'MANUTENCAO') NOT NULL DEFAULT 'DISPONIVEL',
    UNIQUE (id_hotel, numero),
    CHECK (capacidade > 0),
    CHECK (valor_diaria > 0),
    CHECK (andar >= 0),
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
);

CREATE TABLE hospede (
    id_hospede INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    endereco VARCHAR(150) NOT NULL,
    CHECK (email LIKE '%@%.%')
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_reserva DATE NOT NULL DEFAULT (CURRENT_DATE),
    check_in_previsto DATE NOT NULL,
    check_out_previsto DATE NOT NULL,
    quantidade_hospedes INT NOT NULL,
    status ENUM('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA') NOT NULL DEFAULT 'PENDENTE',
    valor_total DECIMAL(10,2) NOT NULL,
    CHECK (check_out_previsto > check_in_previsto),
    CHECK (quantidade_hospedes > 0),
    CHECK (valor_total >= 0),
    FOREIGN KEY (id_hospede) REFERENCES hospede(id_hospede),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);

-- Dados de teste: 3 registros por tabela

INSERT INTO hotel (nome, endereco, cidade, estado, telefone, categoria)
VALUES ('Hotel Aurora', 'Avenida Atlantica, 500', 'Rio de Janeiro', 'Rio de Janeiro', '(21) 3000-1000', '4 estrelas');

INSERT INTO hotel (nome, endereco, cidade, estado, telefone, categoria)
VALUES ('Pousada Serra Azul', 'Rua das Araucarias, 85', 'Campos do Jordao', 'Sao Paulo', '(12) 3300-2000', '3 estrelas');

INSERT INTO hotel (nome, endereco, cidade, estado, telefone, categoria)
VALUES ('Resort Mar do Sol', 'Rodovia dos Coqueiros, 1200', 'Salvador', 'Bahia', '(71) 3500-3000', '5 estrelas');

INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, andar, status)
VALUES (1, '101', 'Casal Standard', 2, 320.00, 1, 'DISPONIVEL');

INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, andar, status)
VALUES (2, '12', 'Individual', 1, 290.00, 1, 'DISPONIVEL');

INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, andar, status)
VALUES (3, '205', 'Suite Familia', 4, 450.00, 2, 'DISPONIVEL');

INSERT INTO hospede (nome, cpf, data_nascimento, telefone, email, endereco)
VALUES ('Ana Martins', '12345678901', '1992-04-18', '(11) 99911-2233', 'ana.martins@email.com', 'Rua das Flores, 120, Sao Paulo');

INSERT INTO hospede (nome, cpf, data_nascimento, telefone, email, endereco)
VALUES ('Bruno Oliveira', '23456789012', '1987-11-03', '(31) 98822-3344', 'bruno.oliveira@email.com', 'Avenida Brasil, 450, Belo Horizonte');

INSERT INTO hospede (nome, cpf, data_nascimento, telefone, email, endereco)
VALUES ('Carla Souza', '34567890123', '1995-07-25', '(41) 97733-4455', 'carla.souza@email.com', 'Rua XV de Novembro, 78, Curitiba');

INSERT INTO reserva
    (id_hospede, id_quarto, data_reserva, check_in_previsto, check_out_previsto,
     quantidade_hospedes, status, valor_total)
VALUES (1, 1, '2026-09-15', '2026-10-10', '2026-10-12', 2, 'CONFIRMADA', 640.00);

INSERT INTO reserva
    (id_hospede, id_quarto, data_reserva, check_in_previsto, check_out_previsto,
     quantidade_hospedes, status, valor_total)
VALUES (2, 2, '2026-09-16', '2026-10-15', '2026-10-18', 1, 'CONFIRMADA', 870.00);

INSERT INTO reserva
    (id_hospede, id_quarto, data_reserva, check_in_previsto, check_out_previsto,
     quantidade_hospedes, status, valor_total)
VALUES (3, 3, '2026-09-18', '2026-11-02', '2026-11-04', 4, 'PENDENTE', 900.00);

-- Consulta 1: hospede, hotel e quarto de cada reserva
SELECT
    r.id_reserva,
    h.nome AS hospede,
    ht.nome AS hotel,
    q.numero AS quarto,
    r.check_in_previsto,
    r.check_out_previsto,
    r.status
FROM reserva r
JOIN hospede h ON h.id_hospede = r.id_hospede
JOIN quarto q ON q.id_quarto = r.id_quarto
JOIN hotel ht ON ht.id_hotel = q.id_hotel;

-- Consulta 2: reservas pendentes ou confirmadas
SELECT
    ht.nome AS hotel,
    q.numero AS quarto,
    r.check_in_previsto,
    r.valor_total,
    r.status
FROM reserva r
JOIN quarto q ON q.id_quarto = r.id_quarto
JOIN hotel ht ON ht.id_hotel = q.id_hotel
WHERE r.status IN ('PENDENTE', 'CONFIRMADA');
