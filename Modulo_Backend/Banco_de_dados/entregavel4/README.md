# Sistema de Reservas de Hotel — Sprint 4

Projeto acadêmico de modelagem física em PostgreSQL, baseado no modelo lógico da Sprint 3.

## Arquivos

- `01_schema.sql`: tabelas, restrições e índices.
- `02_seed.sql`: dados de demonstração.
- `03_transacoes.sql`: exemplos de transações.
- `04_explain.sql`: consultas com `EXPLAIN ANALYZE`.
- `05_acessos.sql`: papéis, usuários e permissões.

## Como executar

Crie um banco PostgreSQL vazio e execute os arquivos nesta ordem:

1. `01_schema.sql`
2. `02_seed.sql`
3. `03_transacoes.sql`
4. `04_explain.sql`
5. `05_acessos.sql`

O arquivo de acessos deve ser executado por um usuário administrador. Antes de executá-lo, troque `nome_do_banco` pelo nome real do banco e defina as senhas dos usuários conforme a configuração do PostgreSQL.

## Tipos e restrições

- `BIGSERIAL` gera IDs automaticamente.
- `BIGINT` é usado nas chaves estrangeiras.
- `VARCHAR` guarda textos com limite de tamanho.
- `NUMERIC(10,2)` guarda valores monetários.
- `DATE` guarda datas previstas.
- `TIMESTAMPTZ` guarda data e hora da reserva.
- `ENUM` limita os valores possíveis para os status.
- `CHECK`, `NOT NULL`, `UNIQUE`, PKs e FKs ajudam a manter os dados consistentes.

Os valores dos status são exemplos e devem ser ajustados se a Sprint 3 definir outros.

## Índices

- `quarto_hotel_status_idx`: ajuda a localizar quartos de um hotel por status.
- `reserva_hospede_data_idx`: ajuda a consultar e ordenar reservas de um hóspede.
- `reserva_quarto_checkin_idx`: ajuda a buscar reservas por quarto e data de check-in.

PKs e restrições `UNIQUE` também criam índices automaticamente. Índices ocupam espaço e podem deixar alterações nos dados mais lentas.

## Transações

A primeira transação cria um hotel e um quarto e confirma ambos com `COMMIT`. O ID gerado para o hotel é usado no `INSERT` do quarto.

A segunda transação cria um hóspede e uma reserva. O `SAVEPOINT` e o `ROLLBACK TO SAVEPOINT` demonstram como desfazer uma alteração parcial; o `ROLLBACK` final desfaz toda a transação de exemplo.

## Análise das consultas

Execute `04_explain.sql` e observe se o plano mostra `Index Scan`, `Bitmap Index Scan` ou `Seq Scan`. Registre nesta seção o resultado observado após a execução.

Com poucos registros, o PostgreSQL pode escolher `Seq Scan`, pois ler a tabela inteira pode custar menos. Não informe que um índice foi usado sem conferir o resultado do seu próprio `EXPLAIN ANALYZE`.

## Controle de acesso

- `usuario_leitura` pode consultar as tabelas.
- `usuario_operacao` pode consultar as tabelas, inserir hóspedes e reservas e alterar o status de uma reserva.
- Os papéis `hotel_leitura` e `hotel_operacao` agrupam essas permissões.
- `REVOKE` remove permissões gerais antes das permissões específicas serem concedidas.