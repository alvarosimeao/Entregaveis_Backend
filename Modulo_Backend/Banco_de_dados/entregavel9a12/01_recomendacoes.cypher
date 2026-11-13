// Executar no Neo4j Browser ou: cypher-shell -f 01_recomendacoes.cypher
CREATE CONSTRAINT usuario_id IF NOT EXISTS FOR (u:Usuario) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT produto_sku IF NOT EXISTS FOR (p:Produto) REQUIRE p.sku IS UNIQUE;

MERGE (ana:Usuario {id:'u1'}) SET ana.nome='Ana';
MERGE (bruno:Usuario {id:'u2'}) SET bruno.nome='Bruno';
MERGE (carla:Usuario {id:'u3'}) SET carla.nome='Carla';
MERGE (diego:Usuario {id:'u4'}) SET diego.nome='Diego';
MERGE (camiseta:Produto {sku:'CAM-001'}) SET camiseta.nome='Camiseta Azul';
MERGE (fone:Produto {sku:'FON-001'}) SET fone.nome='Fone Bluetooth';
MERGE (mouse:Produto {sku:'MOU-001'}) SET mouse.nome='Mouse Ergonomico';

MATCH (a:Usuario {id:'u1'}), (b:Usuario {id:'u2'}) MERGE (a)-[:AMIGO_DE]->(b);
MATCH (a:Usuario {id:'u2'}), (b:Usuario {id:'u3'}) MERGE (a)-[:AMIGO_DE]->(b);
MATCH (a:Usuario {id:'u2'}), (b:Usuario {id:'u4'}) MERGE (a)-[:AMIGO_DE]->(b);
MATCH (u:Usuario {id:'u1'}), (p:Produto {sku:'CAM-001'}) MERGE (u)-[:COMPROU]->(p);
MATCH (u:Usuario {id:'u3'}), (p:Produto {sku:'CAM-001'}) MERGE (u)-[:COMPROU]->(p);
MATCH (u:Usuario {id:'u3'}), (p:Produto {sku:'FON-001'}) MERGE (u)-[:COMPROU]->(p);
MATCH (u:Usuario {id:'u4'}), (p:Produto {sku:'MOU-001'}) MERGE (u)-[:COMPROU]->(p);

// Amigos de amigos de Ana que compraram o produto X (FON-001).
// A relação social é tratada como bidirecional na travessia.
MATCH (eu:Usuario {id:'u1'})-[:AMIGO_DE*2]-(amigoDeAmigo:Usuario)-[:COMPROU]->(produto:Produto {sku:'FON-001'})
WHERE amigoDeAmigo <> eu AND NOT (eu)-[:AMIGO_DE]-(amigoDeAmigo)
RETURN DISTINCT amigoDeAmigo.nome AS pessoa, produto.nome AS produto;

// Quem comprou algo que Ana comprou também comprou outro produto.
MATCH (eu:Usuario {id:'u1'})-[:COMPROU]->(emComum:Produto)<-[:COMPROU]-(outra:Usuario)-[:COMPROU]->(sugestao:Produto)
WHERE outra <> eu AND NOT (eu)-[:COMPROU]->(sugestao)
RETURN sugestao.sku AS sku, sugestao.nome AS sugestao, count(DISTINCT outra) AS usuariosEmComum
ORDER BY usuariosEmComum DESC, sku;
