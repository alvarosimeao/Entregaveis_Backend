# Entregável das semanas 09 a 12 — grafo e cache

O catálogo da entrega 07–08 continua aqui com recomendações em Neo4j e carrinho em Redis.

## Grafo

`01_recomendacoes.cypher` cria nós `Usuario` e `Produto` e relações `AMIGO_DE` e `COMPROU`. Usa `MERGE` e restrições únicas para permitir nova execução sem duplicar dados. Ana (`u1`) é amiga de Bruno (`u2`), que é amigo de Carla (`u3`); Carla comprou `FON-001`. A primeira consulta percorre exatamente dois saltos sociais e encontra Carla. A segunda recomenda a Ana produtos comprados por pessoas que também compraram algo que ela comprou; no exemplo, recomenda `FON-001`.

```bash
cypher-shell -f 01_recomendacoes.cypher
```

O grafo representa conexões como arestas e navega por elas diretamente. Para encontrar amigos de amigos em SQL, seria preciso combinar repetidamente tabelas de usuários, amizades e compras. A vantagem do grafo cresce em consultas com vários saltos e relações variáveis; para dados tabulares simples, um banco relacional continua apropriado.

## Cache do carrinho

`02_carrinho.redis` usa a chave `cart:user:{id}` e um **Hash** em que `product:{sku}` mapeia para a quantidade. `HSET` acrescenta ou altera itens, `HGETALL` lê o carrinho e `EXPIRE 86400` define TTL de 24 horas. O comando `DEL` demonstra a invalidação após checkout confirmado. Em produção, a baixa de estoque e o pedido devem ser confirmados no banco principal antes de apagar a chave. O Redis oferece leitura e escrita em memória para um carrinho acessado frequentemente e com vida curta; o pedido definitivo precisa de persistência transacional.

```bash
redis-cli < 02_carrinho.redis
```

Fonte do enunciado: [AVA — Entregável Semanas 09 a 12](https://ead.ceuma.br/mod/assign/view.php?id=25607).
