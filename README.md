# Backend e modelagem de dados

Repositório de atividades do curso de Análise e Desenvolvimento de Sistemas. O trabalho mais completo é um **modelo de pedidos e estoque para uma loja**, da definição das entidades à implementação em PostgreSQL.

## Projeto em destaque: pedidos e estoque

- [Escopo e escolha da tecnologia](Modulo_Backend/Banco_de_dados/entregavel14/README.md)
- [Modelo lógico e normalização](Modulo_Backend/Banco_de_dados/entregavel15/README.md)
- [DDL, índices, permissões e transações](Modulo_Backend/Banco_de_dados/entregavel16/README.md)

O modelo separa clientes, produtos, estoque, pedidos e itens. O preço contratado fica no item do pedido para preservar o histórico, mesmo quando o preço atual do produto muda. Os índices foram escolhidos para consultas por cliente, status e data; com poucos dados de exemplo, não há base para afirmar ganho de desempenho. A transação de registro de pedido evita deixar um pedido parcial quando falta estoque.

## Como executar e verificar

A [entrega da semana 16](Modulo_Backend/Banco_de_dados/entregavel16/README.md) informa a ordem exata dos scripts `psql`, os privilégios necessários e o resultado esperado do teste negativo de permissões. Execute em um banco PostgreSQL de estudo: os scripts criam objetos e dados de demonstração.

## Outros estudos

| Semanas | Tema |
| --- | --- |
| 07–08 | [Documentos, índices e consultas no MongoDB](Modulo_Backend/Banco_de_dados/entregavel7e8/README.md) |
| 09–12 | [Recomendações em grafo e carrinho Redis](Modulo_Backend/Banco_de_dados/entregavel9a12/README.md) |
| 13 | [Arquitetura de dados de um ERP](Modulo_Backend/Banco_de_dados/entregavel13/README.md) |

Os exercícios de Java estão em [`Modulo_Backend/Java`](Modulo_Backend/Java/). Este repositório registra estudos acadêmicos; os dados e cenários são fictícios.
