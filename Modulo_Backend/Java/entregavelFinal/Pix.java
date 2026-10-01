package Modulo_Backend.Java.entregavelFinal;

public class Pix extends Pagamento {

    public Pix(double valor) {
        super(valor);
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        status = "Aprovado";
        System.out.println("Pix aprovado: R$ " + valor);
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Detalhes: Pix - R$ " + valor + " - " + status);
    }
}