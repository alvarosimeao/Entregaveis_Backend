package Modulo_Backend.Java.entregavel2;

public class Program {
    public static void main(String[] args) {
        Carro carro1 = new Carro("Toro", "Fiat", 2020);
        Carro carro2 = new Carro("Onix", "Chevrolet", 2021);

        Pessoa alvaro = new Pessoa(20, 175, 70.5);
        Pessoa joao = new Pessoa(25, 180, 80.0);
        Pessoa guilherme = new Pessoa(15, 165, 67.0);

        System.out.println(carro1);
        System.out.println(carro2);

        carro1.setAno(2022);

        System.out.println(carro1);

        int maior = Math.max(alvaro.getIdade(), Math.max(joao.getIdade(), guilherme.getIdade()));
        if (maior == alvaro.getIdade()) {
            System.out.println("A pessoa mais velha é o Alvaro");
        } else if (maior == joao.getIdade()) {
            System.out.println("A pessoa mais velha é o Joao");
        } else {
            System.out.println("A pessoa mais velha é o Guilherme");
        }
    }
}

// O FATO DE TER ALTERADO UM ATRIBUTO EM CARRO1, NÃO ALTERA O VALOR DE CARRO2, POIS SÃO OBJETOS INSTANCIADOS DE FORMA INDEPENDENTE, CADA UM COM SEUS PRÓPRIOS ATRIBUTOS, MAS QUE SO POSSUEM OS MESMO NOMES DE ATRIBUTOS, MAS QUE SÃO INDEPENDENTES.