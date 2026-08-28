# Entregável Radar de Dados — Rede de Hotéis

## Sobre o Projeto

Este projeto foi desenvolvido como parte do **Desafio Sprint 1: Radar de Dados**, referente ao **3º período de ADS — TechX1**.

O objetivo é identificar as principais entidades, seus atributos, chaves e relacionamentos existentes em um cenário simplificado de rede de hotéis.

---

## Objetivo

Modelar a estrutura de dados de um sistema de hotéis, identificando:

- As entidades principais;
- Os atributos de cada entidade;
- Os identificadores únicos (**chaves primárias — PK**);
- As chaves estrangeiras (**FK**);
- Os relacionamentos e suas cardinalidades.

---

## Entidades

Foram identificadas as seguintes entidades principais:

- Hotel
- Quarto
- Hóspede
- Reserva

---

## Hotel

Representa os hotéis cadastrados no sistema.

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_hotel` | Identificador único | INT | PK |
| `nome` | Nome do hotel | VARCHAR | — |
| `endereco` | Endereço | VARCHAR | — |
| `cidade` | Cidade | VARCHAR | — |
| `estado` | Estado | VARCHAR | — |
| `telefone` | Telefone | VARCHAR | — |
| `categoria` | Categoria do hotel | VARCHAR | — |

---

## Quarto

Representa os quartos existentes em cada hotel.

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_quarto` | Identificador único | INT | PK |
| `id_hotel` | Hotel do quarto | INT | FK |
| `numero` | Número do quarto | VARCHAR | — |
| `tipo` | Tipo do quarto | VARCHAR | — |
| `capacidade` | Capacidade de hóspedes | INT | — |
| `valor_diaria` | Valor da diária | DECIMAL | — |
| `andar` | Andar | INT | — |
| `status` | Situação do quarto | VARCHAR | — |

---

## Hóspede

Representa os hóspedes cadastrados no sistema.

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_hospede` | Identificador único | INT | PK |
| `nome` | Nome completo | VARCHAR | — |
| `cpf` | CPF | VARCHAR | — |
| `data_nascimento` | Data de nascimento | DATE | — |
| `telefone` | Telefone | VARCHAR | — |
| `email` | E-mail | VARCHAR | — |
| `endereco` | Endereço | VARCHAR | — |

---

## Reserva

Representa as reservas realizadas pelos hóspedes.

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_reserva` | Identificador único | INT | PK |
| `id_hospede` | Hóspede responsável | INT | FK |
| `id_quarto` | Quarto reservado | INT | FK |
| `data_reserva` | Data da reserva | DATE | — |
| `check_in_previsto` | Data prevista de entrada | DATE | — |
| `check_out_previsto` | Data prevista de saída | DATE | — |
| `quantidade_hospedes` | Quantidade de hóspedes | INT | — |
| `status` | Situação da reserva | VARCHAR | — |
| `valor_total` | Valor total da reserva | DECIMAL | — |

---

# Relacionamentos

## Hotel → Quarto

Um hotel pode possuir vários quartos, enquanto cada quarto pertence a um único hotel.

**Cardinalidade:**

```text
Hotel (1) —— (N) Quarto