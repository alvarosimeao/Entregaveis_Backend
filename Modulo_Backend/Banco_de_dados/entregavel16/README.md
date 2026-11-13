# Entregável da semana 16 — implementação física, índices e segurança

Continuação do [escopo](../entregavel14/README.md) e do [modelo normalizado](../entregavel15/README.md). Os scripts têm ordem de execução explícita:

```bash
psql -d postgres -v ON_ERROR_STOP=1 -f 01_ddl.sql
psql -d postgres -v ON_ERROR_STOP=1 -f 02_dml.sql
psql -d postgres -v ON_ERROR_STOP=1 -f 03_indices.sql
psql -d postgres -v ON_ERROR_STOP=1 -f 04_seguranca.sql
psql -d postgres -v ON_ERROR_STOP=1 -f 05_transacoes.sql
# Teste negativo opcional; o DELETE deve falhar:
psql -d postgres -f 06_teste_permissoes.sql
```

Use um banco de estudo. `04_seguranca.sql` requer privilégio de criar papéis e cria contas de demonstração sem senha definida; configure a autenticação apropriada antes de permitir login. `06_teste_permissoes.sql` termina com um erro esperado no `DELETE` executado como `loja_analista`.

## DDL e DML

Cinco tabelas com PK, FK, `NOT NULL`, `UNIQUE`, `CHECK` e `DEFAULT`: `clientes`, `produtos`, `estoque`, `pedidos` e `itens_pedido`. `02_dml.sql` coloca cinco registros em cada uma. Os IDs fixos tornam as FKs fáceis de acompanhar, e as sequências são ajustadas para novas inserções. `preco_unitario` no item guarda o valor histórico da venda; o preço corrente fica em `produtos`.

## Índices

`idx_pedidos_cliente_data` atende o histórico por cliente e data; `idx_pedidos_status_data` atende a fila e o relatório por status e data. O e-mail e o SKU já têm índices únicos por causa de `UNIQUE`, por isso não foram duplicados. `03_indices.sql` inclui duas consultas com `EXPLAIN`. Com apenas cinco linhas, `Seq Scan` ainda pode ser a escolha correta do otimizador; a avaliação de ganho exige volume representativo.

Índices demais ocupam espaço e tornam `INSERT`, `UPDATE` e `DELETE` mais lentos, pois cada alteração precisa atualizar os índices. Cada índice aqui corresponde a uma consulta esperada.

## Transações e permissões

`registrar_pedido` busca o preço, reduz estoque apenas quando há quantidade suficiente e insere pedido e item em uma transação. O script mostra `BEGIN`/`COMMIT`, um `ROLLBACK` explícito e uma falha de estoque capturada em subtransação. Se uma FK falhar ou faltar estoque, a operação não deixa pedido parcial.

`loja_admin` pode ler e alterar dados; `loja_analista` só pode executar `SELECT`. O teste negativo tenta `DELETE` como analista e deve receber erro de permissão. O princípio do menor privilégio limita danos por erro humano ou credenciais comprometidas. A apresentação oral individual de três minutos e as perguntas dependem da presença do aluno; estes arquivos cobrem os artefatos técnicos da entrega.

Fonte do enunciado: [AVA — Entregável Semana 16](https://ead.ceuma.br/mod/assign/view.php?id=25612).
