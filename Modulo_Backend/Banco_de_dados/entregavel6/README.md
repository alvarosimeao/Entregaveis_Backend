# Sistema Acadêmico — Sprint 6

Projeto acadêmico que continua a modelagem relacional da Sprint 5 em PostgreSQL e apresenta uma modelagem complementar em MongoDB.

## Domínio e modelo lógico

O sistema controla alunos, professores, cursos, disciplinas, turmas, matrículas, avaliações, notas e frequências.

- Um professor pode ministrar várias disciplinas.
- Um curso pode ter várias disciplinas, relacionadas pela tabela `curso_disciplina`.
- Uma disciplina pode ter várias turmas.
- Alunos se matriculam em disciplinas por meio de `matricula`.
- Uma turma pode ter várias avaliações.
- As notas relacionam alunos e avaliações.
- A frequência registra a presença de um aluno em uma turma em determinada data.

No PostgreSQL, essas entidades ficam em tabelas relacionadas por chaves primárias e estrangeiras. Restrições `UNIQUE`, `CHECK` e `NOT NULL` ajudam a preservar a integridade dos dados.

## Arquivos da Sprint 6

- `08_backup.sh`: cria backups lógicos do PostgreSQL.
- `mongodb/01_sistema_academico.js`: cria as collections, insere documentos, executa consultas, cria índices e mostra planos com `explain()`.

Os arquivos SQL da Sprint 5 devem permanecer nesta entrega.

## MongoDB: embedding e referencing

O exemplo usa as collections `alunos` e `matriculas`.

Cada matrícula referencia o aluno pelo campo `alunoId`, que guarda o `_id` do documento em `alunos`. Essa referência permite consultar os dados do aluno separadamente e reutilizá-los em diferentes matrículas.

As disciplinas e avaliações ficam embutidas no documento da matrícula. Elas são dados consultados junto com a matrícula e, neste exemplo, formam listas pequenas. Assim, a consulta da matrícula também retorna suas disciplinas e avaliações.

O script insere pelo menos dez documentos no total, executa consultas com filtro, projeção e ordenação, cria dois índices e usa `explain("executionStats")` para mostrar os planos. Observe se o plano apresenta `IXSCAN` ou `COLLSCAN`. Com poucos documentos, o MongoDB pode escolher `COLLSCAN`.

## Backup PostgreSQL

O script `08_backup.sh` usa `pg_dump` no formato customizado (`-Fc`). O nome do arquivo inclui a data e a hora. O script informa falhas e remove backups locais com mais de 30 dias.

Configure as variáveis `PGDATABASE`, `PGUSER`, `PGHOST` e `PGPORT` no ambiente. Para autenticação, use o arquivo `.pgpass` com permissões restritas; não grave senhas no script.

Para executar:

```bash
chmod +x 08_backup.sh
PGDATABASE=sistema_academico PGUSER=postgres ./08_backup.sh