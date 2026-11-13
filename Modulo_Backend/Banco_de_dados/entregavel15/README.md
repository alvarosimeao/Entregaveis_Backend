# Entregável da semana 15 — MER, modelo lógico e 3FN

Continuação do escopo da [semana 14](../entregavel14/README.md). O diagrama exportado em [modelo_er.svg](modelo_er.svg) mostra as entidades e cardinalidades. A tabela `itens_pedido` resolve o relacionamento N:N entre `pedidos` e `produtos`. `estoque.produto_id` é ao mesmo tempo PK e FK, impondo no máximo um saldo por produto.

## Modelo lógico

| Tabela | PK | FKs | Regras adicionais |
| --- | --- | --- | --- |
| `clientes` | `id` | — | `email` único e obrigatório. |
| `produtos` | `id` | — | `sku` único; `preco >= 0`. |
| `estoque` | `produto_id` | `produto_id → produtos.id` | `quantidade >= 0`. |
| `pedidos` | `id` | `cliente_id → clientes.id` | `status` limitado a três valores. |
| `itens_pedido` | `(pedido_id, produto_id)` | `pedido_id → pedidos.id`, `produto_id → produtos.id` | Quantidade positiva. |

## Normalização

Uma planilha inicial poderia conter `pedido_id, cliente_nome, cliente_email, produto_sku, produto_nome, quantidade, preco_unitario` em cada linha. Ela repetiria nome e e-mail do cliente e nome do produto para cada item; mudar o e-mail exigiria alterar várias linhas, e apagar o último pedido poderia apagar o único registro do cliente.

- **1FN:** cada coluna é atômica; itens repetidos viram linhas separadas em `itens_pedido`.
- **2FN:** na antiga chave composta `(pedido_id, produto_id)`, cliente dependia apenas de `pedido_id` e nome do produto apenas de `produto_id`. Esses atributos foram separados em `pedidos`, `clientes` e `produtos`; `quantidade` e `preco_unitario` dependem do item completo.
- **3FN:** e-mail e nome dependem de `cliente_id` em `clientes`, e dados do produto dependem de `produto_id` em `produtos`. O total do pedido é calculado por consulta, evitando dependência transitiva e divergência. `preco_unitario` no item é o preço histórico daquela venda, não uma cópia do preço atual do catálogo.

A PK identifica cada linha; as FKs impedem pedidos órfãos e itens que apontem para produtos inexistentes. Assim, a normalização reduz anomalias de inserção, atualização e exclusão sem perder integridade referencial.

## Execução

```bash
psql -d postgres -v ON_ERROR_STOP=1 -f 01_ddl.sql
psql -d postgres -v ON_ERROR_STOP=1 -f 02_dados_e_consultas.sql
```

O segundo script insere dados em tabelas relacionadas e executa duas consultas com `JOIN`. Um `INSERT` inválido está comentado no fim para demonstrar o erro de FK quando executado isoladamente.

Fonte do enunciado: [AVA — Entregável Semana 15](https://ead.ceuma.br/mod/assign/view.php?id=25611).
