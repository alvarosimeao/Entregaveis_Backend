package Modulo_Backend.Java.entregavelFinal;

public class Credito extends Pagamento {

    public Credito(double valor) {
        super(valor);
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        status = "Aprovado";
        System.out.println("Crédito aprovado: R$ " + valor);
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Detalhes: Crédito - R$ " + valor + " - " + status);
    }
}
