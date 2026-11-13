# Entregável da semana 13 — arquitetura de dados de um ERP

Os três contextos delimitados têm responsabilidades próprias. Os identificadores de produto (`sku`) e de cliente são contratos de integração, não chaves estrangeiras entre bancos.

| Contexto | SGBD | Dados e responsabilidade | Motivo |
| --- | --- | --- | --- |
| Vendas | Redis | Carrinho temporário por sessão, item e quantidade | Leitura e atualização frequentes com TTL; o pedido confirmado deve sair do cache. |
| Estoque | MongoDB | Produtos, quantidade e especificações variáveis | Documentos acomodam atributos distintos para eletrônicos e roupas. |
| Financeiro | PostgreSQL | Contas e faturas | Integridade, `CHECK`, transações e soma confiável dos valores. |

## Scripts

```bash
psql -d postgres -f financeiro/01_faturas.sql
psql -d postgres -f financeiro/02_transacao.sql
mongosh estoque/01_produtos.js
redis-cli < vendas/01_sessao_carrinho.redis
```

O primeiro script financeiro cria `faturas`, insere duas faturas e calcula `SUM(valor)` (R$ 200,00 com dados iniciais). O segundo cria uma função que só debita quando há saldo. A última chamada tenta debitar R$ 999.999,00 e **deve** produzir erro; a transação é revertida. Em uma execução com `ON_ERROR_STOP=1`, o `psql` encerra nesse erro e a conexão reverte a transação aberta. O banco MongoDB da entrega é reiniciado pelo script de estoque; não executar sobre dados reais.

## Integração assíncrona

Após o checkout, Vendas grava um pedido definitivo e publica `PedidoConfirmado` com `pedido_id`, `sku`, quantidade e chave de idempotência. Estoque consome o evento, reserva a quantidade com uma atualização condicional e publica `EstoqueReservado` ou `ReservaRecusada`. Financeiro emite a fatura apenas após confirmação da reserva, em transação local, e publica `FaturaEmitida`. Um orquestrador confirma a venda e remove `cart:session:{id}` somente após as etapas necessárias. Falhas geram eventos de compensação, como liberação da reserva. Uma caixa de saída transacional (*outbox*) e consumidores idempotentes evitam perda ou duplicação de eventos. Cada contexto mantém sua própria consistência; não há transação distribuída entre os três bancos neste exemplo.

## Reflexão

**Persistência poliglota** é o uso de tecnologias de armazenamento diferentes para padrões de acesso e garantias diferentes. Um ERP não precisa forçar o carrinho efêmero, o catálogo flexível e a fatura financeira no mesmo modelo. Redis atende baixa latência e expiração; MongoDB simplifica especificações heterogêneas; PostgreSQL garante regras e transações do financeiro. A escolha acrescenta custo operacional e integração assíncrona, que precisam ser planejados explicitamente.

Fonte do enunciado: [AVA — Entregável Semana 13](https://ead.ceuma.br/mod/assign/view.php?id=25608).
