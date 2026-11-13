# Entregável das semanas 07 e 08 — MongoDB

Catálogo de e-commerce orientado a documentos. O arquivo `01_catalogo_mongodb.js` cria o banco `backend_entregavel_07_08`, reinicia somente sua coleção `produtos`, insere quatro produtos com `insertMany()` e executa as consultas exigidas.

```bash
mongosh 01_catalogo_mongodb.js
```

Cada produto contém `tags` (array), `fabricante` (subdocumento) e `variacoes` (array de subdocumentos). `sku` identifica o produto; o preço é numérico. O script cria um índice simples em `preco` e um índice textual em `titulo` e `descricao`. As consultas demonstram comparação (`$gt`/`$lt`), valor em array, busca `$text` e `$elemMatch`, que exige tamanho e cor na *mesma* variação. A última consulta usa `explain('executionStats')` e `hint('idx_preco')` para mostrar `IXSCAN` e `totalKeysExamined`; o `hint` é útil com uma coleção pequena, na qual o otimizador poderia escolher varredura completa.

## Embedding e referencing

**Embedding** guarda dados no próprio documento, como fabricante e variações neste exercício. Faz sentido quando são lidos junto com o produto, têm tamanho limitado e mudam pouco. **Referencing** guarda o `_id` de outro documento. Em um e-commerce real, clientes, pedidos e avaliações numerosas devem ficar em coleções próprias e referenciar o produto: isso evita arrays ilimitados e duplicação de dados que mudam com frequência. Um fornecedor compartilhado por muitos produtos também pode ser referenciado caso suas informações sejam atualizadas centralmente.

Fonte do enunciado: [AVA — Entregável Semana 07 e Semana 08](https://ead.ceuma.br/mod/assign/view.php?id=25606).
