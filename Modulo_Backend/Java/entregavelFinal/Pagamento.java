package Modulo_Backend.Java.entregavelFinal;

public abstract class Pagamento {

    protected double valor;
    protected String status;

    public Pagamento(double valor) {
        this.valor = valor;
        this.status = "Pendente";
    }

    public boolean validarValor() {
        if (valor <= 0) {
            System.out.println("Pagamento recusado: o valor deve ser maior que zero.");
            status = "Recusado";
            return false;
        }

        return true;
    }

    public abstract void pagar();

    public abstract void exibirDetalhes();
}