CREATE DATABASE sistema_hoteis;

USE sistema_hoteis;


CREATE TABLE Hotel (
    id_hotel INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    categoria VARCHAR(50)
);


CREATE TABLE Quarto (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    id_hotel INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade INT NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    andar INT,
    status VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_hotel)
        REFERENCES Hotel(id_hotel)
);


CREATE TABLE Hospede (
    id_hospede INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150)
);


CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_reserva DATE NOT NULL,
    check_in_previsto DATE NOT NULL,
    check_out_previsto DATE NOT NULL,
    quantidade_hospedes INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_hospede)
        REFERENCES Hospede(id_hospede),

    FOREIGN KEY (id_quarto)
        REFERENCES Quarto(id_quarto)
);