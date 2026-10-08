package Modulo_Backend.Java.entregavelFinal;

public class Debito extends Pagamento {

    private double saldo;

    public Debito(double valor, double saldo) {
        super(valor);
        this.saldo = saldo;
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        if (saldo >= valor) {
            saldo -= valor;
            status = "Aprovado";
            System.out.println("Débito aprovado: R$ " + valor);
        } else {
            status = "Recusado";
            System.out.println("Débito recusado: saldo insuficiente.");
        }
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Detalhes: Débito - R$ " + valor + " - " + status);
    }
}