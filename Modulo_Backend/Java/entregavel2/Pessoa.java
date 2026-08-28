package Modulo_Backend.Java.entregavel2;

public class Pessoa {
    private int idade;
    private int altura;
    private double peso;

    public Pessoa(int idade, int altura, double peso){
        this.idade = idade;
        this.altura = altura;
        this.peso = peso;
    }

    public int getIdade() {
        return idade;
    }
};