const alunos = db.getCollection("alunos");
const matriculas = db.getCollection("matriculas");

alunos.insertMany([
  {
    _id: ObjectId("660000000000000000000001"),
    nome: "Ana Souza",
    email: "ana@example.com",
    curso: "ADS",
    dataNascimento: ISODate("2004-03-15T00:00:00Z")
  },
  {
    _id: ObjectId("660000000000000000000002"),
    nome: "Bruno Lima",
    email: "bruno@example.com",
    curso: "ADS",
    dataNascimento: ISODate("2003-07-22T00:00:00Z"),
    telefone: "11999990001"
  },
  {
    _id: ObjectId("660000000000000000000003"),
    nome: "Carla Mendes",
    email: "carla@example.com",
    curso: "ADS",
    dataNascimento: ISODate("2005-01-10T00:00:00Z")
  },
  {
    _id: ObjectId("660000000000000000000004"),
    nome: "Diego Alves",
    email: "diego@example.com",
    curso: "Sistemas de Informação",
    dataNascimento: ISODate("2002-11-08T00:00:00Z")
  },
  {
    _id: ObjectId("660000000000000000000005"),
    nome: "Elisa Rocha",
    email: "elisa@example.com",
    curso: "ADS",
    dataNascimento: ISODate("2004-09-03T00:00:00Z")
  }
]);

matriculas.insertMany([
  {
    alunoId: ObjectId("660000000000000000000001"),
    semestre: "2026.1",
    disciplinas: [
      {
        nome: "Banco de Dados",
        cargaHoraria: 80,
        avaliacoes: [
          { nome: "Prova 1", nota: 8.5 },
          { nome: "Trabalho", nota: 9.0 }
        ]
      },
      {
        nome: "Programação",
        cargaHoraria: 80,
        avaliacoes: [
          { nome: "Prova 1", nota: 7.5 }
        ]
      }
    ]
  },
  {
    alunoId: ObjectId("660000000000000000000002"),
    semestre: "2026.1",
    disciplinas: [
      {
        nome: "Banco de Dados",
        cargaHoraria: 80,
        avaliacoes: [
          { nome: "Prova 1", nota: 6.5 }
        ]
      }
    ]
  },
  {
    alunoId: ObjectId("660000000000000000000003"),
    semestre: "2026.1",
    disciplinas: [
      {
        nome: "Programação",
        cargaHoraria: 80,
        avaliacoes: [
          { nome: "Prova 1", nota: 9.0 }
        ]
      }
    ]
  },
  {
    alunoId: ObjectId("660000000000000000000004"),
    semestre: "2026.1",
    disciplinas: [
      {
        nome: "Redes",
        cargaHoraria: 60,
        avaliacoes: [
          { nome: "Prova 1", nota: 8.0 }
        ]
      }
    ]
  },
  {
    alunoId: ObjectId("660000000000000000000005"),
    semestre: "2026.1",
    disciplinas: [
      {
        nome: "Banco de Dados",
        cargaHoraria: 80,
        avaliacoes: [
          { nome: "Prova 1", nota: 7.0 },
          { nome: "Trabalho", nota: 8.0 }
        ]
      }
    ]
  }
]);

alunos.find(
  { curso: "ADS" },
  { _id: 0, nome: 1, email: 1 }
).sort({ nome: 1 });

matriculas.find(
  { alunoId: ObjectId("660000000000000000000001") },
  { _id: 0, semestre: 1, disciplinas: 1 }
).sort({ semestre: -1 });

alunos.createIndex(
  { email: 1 },
  { unique: true, name: "ux_alunos_email" }
);

matriculas.createIndex(
  { alunoId: 1, semestre: -1 },
  { name: "ix_matriculas_aluno_semestre" }
);

alunos.find({ email: "ana@example.com" })
  .explain("executionStats");

matriculas.find({
  alunoId: ObjectId("660000000000000000000001"),
  semestre: "2026.1"
}).explain("executionStats");