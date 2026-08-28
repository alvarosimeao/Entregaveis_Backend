package Modulo_Backend.Java.entregavel2;

public class Carro {
    private String modelo;
    private String marca;
    private int ano;

    public Carro(String modelo, String marca, int ano) {
        this.modelo = modelo;
        this.marca = marca;
        this.ano = ano;
    }

    public void setAno(int ano){
        this.ano = ano;
    }

    public String toString() {
        return "Modelo: " + modelo + ", Marca: " + marca + ", Ano: " + ano;
    }
}
