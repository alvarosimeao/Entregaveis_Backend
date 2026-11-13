// Executar: mongosh 01_produtos.js
const estoque = db.getSiblingDB('backend_erp_estoque');
estoque.produtos.drop();
estoque.createCollection('produtos');

estoque.produtos.insertMany([
  {
    sku: 'FON-001', nome: 'Fone Bluetooth', quantidade: 14,
    especificacoes: { conectividade: 'Bluetooth 5.3', autonomia_horas: 18, cor: 'Preto' }
  },
  {
    sku: 'CAM-001', nome: 'Camiseta Azul', quantidade: 12,
    especificacoes: { tecido: 'Algodão', tamanho: 'M', cor: 'Azul' }
  }
]);

estoque.produtos.createIndex({ sku: 1 }, { unique: true });
printjson(estoque.produtos.find({}, { _id: 0 }).toArray());
