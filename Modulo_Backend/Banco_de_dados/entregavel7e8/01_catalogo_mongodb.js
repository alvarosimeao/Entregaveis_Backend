// Executar: mongosh 01_catalogo_mongodb.js
// Banco exclusivo desta entrega; a execução reinicia apenas a coleção produtos.
const catalogo = db.getSiblingDB('backend_entregavel_07_08');
catalogo.produtos.drop();
catalogo.createCollection('produtos');

catalogo.produtos.insertMany([
  {
    sku: 'CAM-001', titulo: 'Camiseta Azul', descricao: 'Camiseta de algodão azul',
    preco: 79.90, tags: ['roupas', 'promocao'],
    fabricante: { nome: 'Malharia Norte', pais: 'Brasil' },
    variacoes: [{ tamanho: 'M', cor: 'Azul', estoque: 12 }, { tamanho: 'G', cor: 'Azul', estoque: 8 }]
  },
  {
    sku: 'CAM-002', titulo: 'Camiseta Preta', descricao: 'Camiseta de algodão preta',
    preco: 89.90, tags: ['roupas', 'basicos'],
    fabricante: { nome: 'Malharia Norte', pais: 'Brasil' },
    variacoes: [{ tamanho: 'M', cor: 'Preta', estoque: 7 }, { tamanho: 'P', cor: 'Preta', estoque: 5 }]
  },
  {
    sku: 'FON-001', titulo: 'Fone Bluetooth', descricao: 'Fone sem fio com cancelamento de ruido',
    preco: 249.00, tags: ['eletronicos', 'promocao'],
    fabricante: { nome: 'Som Livre', pais: 'Brasil' },
    variacoes: [{ tamanho: 'unico', cor: 'Azul', estoque: 10 }, { tamanho: 'unico', cor: 'Preto', estoque: 14 }]
  },
  {
    sku: 'MOU-001', titulo: 'Mouse Ergonomico', descricao: 'Mouse sem fio ergonomico',
    preco: 129.00, tags: ['eletronicos', 'escritorio'],
    fabricante: { nome: 'Tech Sul', pais: 'Brasil' },
    variacoes: [{ tamanho: 'unico', cor: 'Preto', estoque: 21 }]
  }
]);

// Índice de preço para filtros por faixa; único índice textual da coleção.
catalogo.produtos.createIndex({ preco: 1 }, { name: 'idx_preco' });
catalogo.produtos.createIndex({ titulo: 'text', descricao: 'text' }, { name: 'idx_busca_texto' });

print('1. Comparação: produtos entre R$ 80 e R$ 250');
printjson(catalogo.produtos.find({ preco: { $gt: 80, $lt: 250 } }, { _id: 0, sku: 1, preco: 1 }).toArray());

print('2. Valor presente no array tags');
printjson(catalogo.produtos.find({ tags: 'promocao' }, { _id: 0, sku: 1, tags: 1 }).toArray());

print('3. Busca pelo índice de texto');
printjson(catalogo.produtos.find({ $text: { $search: 'algodão' } }, { _id: 0, sku: 1, titulo: 1 }).toArray());

print('4. $elemMatch: tamanho M e cor Azul na mesma variação');
printjson(catalogo.produtos.find(
  { variacoes: { $elemMatch: { tamanho: 'M', cor: 'Azul' } } },
  { _id: 0, sku: 1, variacoes: 1 }
).toArray());

print('5. Plano do filtro por preço (observar totalKeysExamined e IXSCAN)');
printjson(catalogo.produtos.find({ preco: { $gt: 80, $lt: 250 } }).hint('idx_preco').explain('executionStats'));
