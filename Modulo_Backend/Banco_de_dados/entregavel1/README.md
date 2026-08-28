# Entregável Radar de Dados — Rede de Hotéis

## Sobre o projeto

Este projeto foi desenvolvido como parte do **Desafio Sprint 1: Radar de Dados**, referente ao **3º período de ADS — TechX1**.

O objetivo é identificar as principais entidades, seus atributos, chaves e relacionamentos existentes em um cenário de **rede de hotéis**.

## Objetivo

Modelar a estrutura de dados de uma rede de hotéis, identificando:

* As entidades principais;
* Os atributos de cada entidade;
* Os identificadores únicos (**chaves primárias — PK**);
* As chaves estrangeiras (**FK**);
* Os relacionamentos e suas cardinalidades.

## Entidades

Foram identificadas as seguintes entidades principais:

* Rede_Hotel
* Hotel
* Tipo_Quarto
* Quarto
* Hóspede
* Reserva
* Item_Reserva
* Pagamento

### Rede_Hotel

Representa a rede responsável pelos hotéis.

| Atributo   | Descrição           | Tipo    | Chave  |
| ---------- | ------------------- | ------- | ------ |
| `id_rede`  | Identificador único | INT     | **PK** |
| `nome`     | Nome da rede        | VARCHAR | —      |
| `cnpj`     | CNPJ da rede        | VARCHAR | —      |
| `telefone` | Telefone            | VARCHAR | —      |
| `email`    | E-mail              | VARCHAR | —      |

### Hotel

Representa cada hotel pertencente à rede.

| Atributo    | Descrição           | Tipo    | Chave  |
| ----------- | ------------------- | ------- | ------ |
| `id_hotel`  | Identificador único | INT     | **PK** |
| `id_rede`   | Rede do hotel       | INT     | **FK** |
| `nome`      | Nome do hotel       | VARCHAR | —      |
| `endereco`  | Endereço            | VARCHAR | —      |
| `cidade`    | Cidade              | VARCHAR | —      |
| `estado`    | Estado              | VARCHAR | —      |
| `telefone`  | Telefone            | VARCHAR | —      |
| `categoria` | Categoria do hotel  | VARCHAR | —      |

### Tipo_Quarto

Representa os tipos de quartos disponíveis.

| Atributo           | Descrição              | Tipo    | Chave  |
| ------------------ | ---------------------- | ------- | ------ |
| `id_tipo_quarto`   | Identificador único    | INT     | **PK** |
| `descricao`        | Descrição do quarto    | VARCHAR | —      |
| `capacidade`       | Capacidade de hóspedes | INT     | —      |
| `quantidade_camas` | Quantidade de camas    | INT     | —      |
| `valor_diaria`     | Valor da diária        | DECIMAL | —      |

### Quarto

Representa os quartos disponíveis em cada hotel.

| Atributo         | Descrição           | Tipo    | Chave  |
| ---------------- | ------------------- | ------- | ------ |
| `id_quarto`      | Identificador único | INT     | **PK** |
| `id_hotel`       | Hotel do quarto     | INT     | **FK** |
| `id_tipo_quarto` | Tipo do quarto      | INT     | **FK** |
| `numero`         | Número do quarto    | VARCHAR | —      |
| `andar`          | Andar               | INT     | —      |
| `status`         | Situação do quarto  | VARCHAR | —      |

### Hóspede

Representa a pessoa que realiza uma reserva.

| Atributo          | Descrição           | Tipo    | Chave  |
| ----------------- | ------------------- | ------- | ------ |
| `id_hospede`      | Identificador único | INT     | **PK** |
| `nome`            | Nome completo       | VARCHAR | —      |
| `cpf`             | CPF                 | VARCHAR | —      |
| `data_nascimento` | Data de nascimento  | DATE    | —      |
| `telefone`        | Telefone            | VARCHAR | —      |
| `email`           | E-mail              | VARCHAR | —      |
| `endereco`        | Endereço            | VARCHAR | —      |

### Reserva

Representa uma reserva realizada por um hóspede.

| Atributo              | Descrição              | Tipo    | Chave  |
| --------------------- | ---------------------- | ------- | ------ |
| `id_reserva`          | Identificador único    | INT     | **PK** |
| `id_hospede`          | Hóspede responsável    | INT     | **FK** |
| `id_hotel`            | Hotel da reserva       | INT     | **FK** |
| `data_reserva`        | Data da reserva        | DATE    | —      |
| `check_in_previsto`   | Data de entrada        | DATE    | —      |
| `check_out_previsto`  | Data de saída          | DATE    | —      |
| `status`              | Situação da reserva    | VARCHAR | —      |
| `quantidade_hospedes` | Quantidade de hóspedes | INT     | —      |

### Item_Reserva

Entidade associativa entre **Reserva** e **Quarto**.

| Atributo          | Descrição           | Tipo    | Chave  |
| ----------------- | ------------------- | ------- | ------ |
| `id_item_reserva` | Identificador único | INT     | **PK** |
| `id_reserva`      | Reserva relacionada | INT     | **FK** |
| `id_quarto`       | Quarto relacionado  | INT     | **FK** |
| `valor_diaria`    | Valor da diária     | DECIMAL | —      |
| `data_check_in`   | Data de entrada     | DATE    | —      |
| `data_check_out`  | Data de saída       | DATE    | —      |

### Pagamento

Representa os pagamentos realizados para uma reserva.

| Atributo          | Descrição             | Tipo    | Chave  |
| ----------------- | --------------------- | ------- | ------ |
| `id_pagamento`    | Identificador único   | INT     | **PK** |
| `id_reserva`      | Reserva relacionada   | INT     | **FK** |
| `valor`           | Valor do pagamento    | DECIMAL | —      |
| `data_pagamento`  | Data do pagamento     | DATE    | —      |
| `forma_pagamento` | Forma de pagamento    | VARCHAR | —      |
| `status`          | Situação do pagamento | VARCHAR | —      |

## Relacionamentos

### Rede_Hotel → Hotel

Uma rede pode possuir vários hotéis, enquanto cada hotel pertence a uma única rede.

**Cardinalidade:**

`Rede_Hotel (1) —— (N) Hotel`

### Hotel → Quarto

Um hotel possui vários quartos, enquanto cada quarto pertence a um único hotel.

**Cardinalidade:**

`Hotel (1) —— (N) Quarto`

### Tipo_Quarto → Quarto

Um tipo de quarto pode classificar vários quartos, enquanto cada quarto possui um único tipo.

**Cardinalidade:**

`Tipo_Quarto (1) —— (N) Quarto`

### Hóspede → Reserva

Um hóspede pode realizar várias reservas, enquanto cada reserva pertence a um único hóspede.

**Cardinalidade:**

`Hóspede (1) —— (N) Reserva`

### Reserva → Quarto

Uma reserva pode incluir vários quartos e um quarto pode aparecer em várias reservas em períodos diferentes. Esse relacionamento é **N:N** e é realizado por meio da entidade `Item_Reserva`.

**Cardinalidade:**

`Reserva (N) —— (N) Quarto`

### Reserva → Pagamento

Uma reserva pode possuir vários pagamentos, enquanto cada pagamento pertence a uma única reserva.

**Cardinalidade:**

`Reserva (1) —— (N) Pagamento`

## Modelo conceitual

```text
┌───────────────┐
│  REDE_HOTEL   │
├───────────────┤
│ PK id_rede    │
│ nome          │
│ cnpj          │
│ telefone      │
│ email         │
└───────┬───────┘
        │ 1:N
        ▼
┌───────────────┐
│     HOTEL     │
├───────────────┤
│ PK id_hotel   │
│ FK id_rede    │
│ nome          │
│ endereco      │
│ cidade        │
│ estado        │
│ categoria     │
└───────┬───────┘
        │ 1:N
        ▼
┌───────────────┐
│    QUARTO     │
├───────────────┤
│ PK id_quarto  │
│ FK id_hotel   │
│ FK id_tipo... │
│ numero        │
│ andar         │
│ status        │
└───────────────┘

┌───────────────┐
│    HÓSPEDE    │
├───────────────┤
│ PK id_hospede │
│ nome          │
│ cpf           │
│ telefone      │
│ email         │
└───────┬───────┘
        │ 1:N
        ▼
┌───────────────┐
│    RESERVA    │
├───────────────┤
│ PK id_reserva │
│ FK id_hospede │
│ FK id_hotel   │
│ data_reserva  │
│ check_in      │
│ check_out     │
│ status        │
└───────┬───────┘
        │ 1:N
        ▼
┌───────────────┐
│ ITEM_RESERVA  │
├───────────────┤
│ PK id_item... │
│ FK id_reserva │
│ FK id_quarto  │
│ valor_diaria  │
└───────────────┘

RESERVA (1) ────── (N) PAGAMENTO
```

## Chaves

### Chaves Primárias (PK)

* `Rede_Hotel.id_rede`
* `Hotel.id_hotel`
* `Tipo_Quarto.id_tipo_quarto`
* `Quarto.id_quarto`
* `Hóspede.id_hospede`
* `Reserva.id_reserva`
* `Item_Reserva.id_item_reserva`
* `Pagamento.id_pagamento`

### Chaves Estrangeiras (FK)

* `Hotel.id_rede` → `Rede_Hotel.id_rede`
* `Quarto.id_hotel` → `Hotel.id_hotel`
* `Quarto.id_tipo_quarto` → `Tipo_Quarto.id_tipo_quarto`
* `Reserva.id_hospede` → `Hóspede.id_hospede`
* `Reserva.id_hotel` → `Hotel.id_hotel`
* `Item_Reserva.id_reserva` → `Reserva.id_reserva`
* `Item_Reserva.id_quarto` → `Quarto.id_quarto`
* `Pagamento.id_reserva` → `Reserva.id_reserva`

## Resumo das cardinalidades

| Relacionamento       | Cardinalidade |
| -------------------- | ------------- |
| Rede_Hotel → Hotel   | 1:N           |
| Hotel → Quarto       | 1:N           |
| Tipo_Quarto → Quarto | 1:N           |
| Hóspede → Reserva    | 1:N           |
| Reserva → Quarto     | N:N           |
| Reserva → Pagamento  | 1:N           |

## Conclusão

A modelagem representa os principais dados de uma rede de hotéis, organizando informações sobre hotéis, quartos, hóspedes, reservas e pagamentos.

O relacionamento **N:N entre Reserva e Quarto** foi resolvido pela entidade associativa `Item_Reserva`, permitindo uma estrutura adequada para um futuro banco de dados relacional.

