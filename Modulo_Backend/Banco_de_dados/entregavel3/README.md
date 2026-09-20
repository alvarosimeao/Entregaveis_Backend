# Desafio Sprint 3 — Sistema de Reservas de Hotel

Projeto de modelagem lógica de banco de dados normalizado até a Terceira Forma Normal (3FN), elaborado a partir do modelo conceitual com as entidades `Hotel`, `Quarto`, `Hospede` e `Reserva`.

## Entregáveis

- [Diagrama do Modelo Lógico](diagrama-modelo-logico.md)
- [DDL — criação do esquema e das tabelas](sql/01_schema.sql)
- [DML — três INSERTs por tabela](sql/02_dados.sql)
- [DML — duas consultas com JOIN](sql/03_consultas.sql)
- [Script SQL completo](sql/desafio_sprint_3_completo.sql)

## Tecnologia adotada

Os scripts foram escritos para **MySQL 8.0.16 ou superior** e criam o banco `hotelaria_semana_03`.

## Modelo lógico resumido

```text
HOTEL   (id_hotel PK, nome, endereco, cidade, estado, telefone, categoria)
QUARTO  (id_quarto PK, id_hotel FK, numero, tipo, capacidade,
         valor_diaria, andar, status)
HOSPEDE (id_hospede PK, nome, cpf, data_nascimento, telefone, email, endereco)
RESERVA (id_reserva PK, id_hospede FK, id_quarto FK, data_reserva,
         check_in_previsto, check_out_previsto, quantidade_hospedes,
         status, valor_total)
```

### Relacionamentos e cardinalidades

| Relacionamento | Cardinalidade | Implementação |
|---|---:|---|
| Hotel possui Quarto | 1:N | `quarto.id_hotel` referencia `hotel.id_hotel` |
| Hóspede realiza Reserva | 1:N | `reserva.id_hospede` referencia `hospede.id_hospede` |
| Quarto recebe Reserva | 1:N ao longo do tempo | `reserva.id_quarto` referencia `quarto.id_quarto` |

Cada quarto pertence obrigatoriamente a um hotel. Cada reserva possui exatamente um hóspede responsável e um quarto. Um hotel, um hóspede ou um quarto podem ainda não ter registros dependentes.

## Restrições de integridade

- Todas as chaves primárias são inteiras e geradas automaticamente.
- As chaves estrangeiras impedem a exclusão de um registro que ainda possua dependentes.
- O CPF e o e-mail do hóspede são obrigatórios e únicos.
- O número do quarto é único **dentro de cada hotel**, por meio de `UNIQUE (id_hotel, numero)`.
- `CHECK` garante capacidade positiva, diária positiva, andar não negativo, quantidade de hóspedes positiva, valor total não negativo e check-out posterior ao check-in.
- Os estados permitidos de quarto e reserva são controlados com `ENUM`.
- `DEFAULT` define a situação inicial do quarto, a data de criação da reserva e a situação inicial da reserva.

Regras que precisam consultar outros registros não são corretamente expressas por um `CHECK` comum. Assim, a aplicação deve validar:

1. `reserva.quantidade_hospedes <= quarto.capacidade`;
2. inexistência de reservas ativas com períodos sobrepostos para o mesmo quarto;
3. coerência de transições de status, por exemplo, uma reserva cancelada não retornar diretamente para concluída.

## Normalização até a 3FN

### Primeira Forma Normal — 1FN

Cada coluna contém um único valor atômico e não existem listas ou grupos repetitivos. Por exemplo, uma reserva referencia somente um quarto; novas reservas são representadas por novas linhas. Os atributos compostos usados pelo sistema, como endereço, são armazenados como um único valor textual de negócio, e não como uma lista de endereços.

### Segunda Forma Normal — 2FN

Todas as tabelas possuem chave primária simples. Portanto, não existem atributos dependentes de apenas parte de uma chave composta. A restrição composta de quarto (`id_hotel`, `numero`) é uma chave candidata e não causa dependência parcial: todos os dados descritivos do quarto continuam funcionalmente determinados por `id_quarto`.

### Terceira Forma Normal — 3FN

Não há atributos não-chave que determinem outros atributos não-chave:

- dados do hotel aparecem somente em `hotel`;
- características e preço-base do quarto aparecem somente em `quarto`;
- dados pessoais aparecem somente em `hospede`;
- datas, quantidade, estado e valor contratado pertencem à ocorrência de `reserva`.

As dependências transitivas foram eliminadas ao substituir dados repetidos por chaves estrangeiras. Por exemplo, `reserva` não repete nome/CPF do hóspede, nem número/tipo/diária do quarto, nem nome/cidade do hotel.

`reserva.valor_total` representa o valor comercial fechado na contratação, podendo conter descontos, taxas ou condições vigentes naquele momento. Ele não é uma cópia obrigatória de `quarto.valor_diaria` e deve permanecer imutável como histórico da transação; por isso é um fato próprio da reserva.

## Dependências funcionais principais

```text
id_hotel   -> nome, endereco, cidade, estado, telefone, categoria
id_quarto  -> id_hotel, numero, tipo, capacidade, valor_diaria, andar, status
id_hospede -> nome, cpf, data_nascimento, telefone, email, endereco
id_reserva -> id_hospede, id_quarto, data_reserva, check_in_previsto,
              check_out_previsto, quantidade_hospedes, status, valor_total

(id_hotel, numero) -> id_quarto e demais atributos do quarto
cpf                -> id_hospede e demais atributos do hóspede
email              -> id_hospede e demais atributos do hóspede
```

## Como executar

Execute os arquivos na ordem:

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_dados.sql
mysql -u root -p < sql/03_consultas.sql
```

Como alternativa, execute o arquivo único:

```bash
mysql -u root -p < sql/desafio_sprint_3_completo.sql
```

O script completo deve ser executado em um banco que ainda não possua essas tabelas. Os identificadores automáticos começam em 1.

## Organização do repositório

```text
desafio-sprint-3-hotel/
├── README.md
├── diagrama-modelo-logico.md
└── sql/
    ├── 01_schema.sql
    ├── 02_dados.sql
    ├── 03_consultas.sql
    └── desafio_sprint_3_completo.sql
```
