# DOCUMENTO

## Lista de Entidades

- Hotel
- Quarto
- Hóspede
- Reserva

---

## Hotel

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_hotel` | Identificador único do hotel | INT | PK |
| `nome` | Nome do hotel | VARCHAR(100) | — |
| `endereco` | Endereço do hotel | VARCHAR(150) | — |
| `cidade` | Cidade | VARCHAR(100) | — |
| `estado` | Estado | VARCHAR(50) | — |
| `telefone` | Telefone | VARCHAR(20) | — |
| `categoria` | Categoria do hotel | VARCHAR(50) | — |

---

## Quarto

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_quarto` | Identificador único do quarto | INT | PK |
| `id_hotel` | Hotel ao qual o quarto pertence | INT | FK |
| `numero` | Número do quarto | VARCHAR(10) | — |
| `tipo` | Tipo do quarto | VARCHAR(50) | — |
| `capacidade` | Capacidade de hóspedes | INT | — |
| `valor_diaria` | Valor da diária | DECIMAL(10,2) | — |
| `andar` | Andar do quarto | INT | — |
| `status` | Situação do quarto | VARCHAR(30) | — |

---

## Hóspede

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_hospede` | Identificador único do hóspede | INT | PK |
| `nome` | Nome completo | VARCHAR(100) | — |
| `cpf` | CPF | VARCHAR(14) | — |
| `data_nascimento` | Data de nascimento | DATE | — |
| `telefone` | Telefone | VARCHAR(20) | — |
| `email` | E-mail | VARCHAR(100) | — |
| `endereco` | Endereço | VARCHAR(150) | — |

---

## Reserva

| Atributo | Descrição | Tipo | Chave |
|---|---|---|---|
| `id_reserva` | Identificador único da reserva | INT | PK |
| `id_hospede` | Hóspede responsável | INT | FK |
| `id_quarto` | Quarto reservado | INT | FK |
| `data_reserva` | Data da reserva | DATE | — |
| `check_in_previsto` | Data prevista de entrada | DATE | — |
| `check_out_previsto` | Data prevista de saída | DATE | — |
| `quantidade_hospedes` | Quantidade de hóspedes | INT | — |
| `status` | Situação da reserva | VARCHAR(30) | — |
| `valor_total` | Valor total da reserva | DECIMAL(10,2) | — |

---

# Relacionamentos

## Hotel → Quarto

Um hotel pode possuir vários quartos, enquanto cada quarto pertence a um único hotel.

**Cardinalidade:**

```text
Hotel (1) —— (N) Quarto