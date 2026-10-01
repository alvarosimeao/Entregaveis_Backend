package Modulo_Backend.Java.entregavelFinal;

public class Main {

    public static void main(String[] args) {

        Pagamento pix = new Pix(100);
        Pagamento debito = new Debito(50, 200);
        Pagamento credito = new Credito(300);

        pix.pagar();
        pix.exibirDetalhes();

        System.out.println();

        debito.pagar();
        debito.exibirDetalhes();

        System.out.println();

        credito.pagar();
        credito.exibirDetalhes();

        System.out.println();

        Pagamento pagamentoInvalido = new Pix(-50);
        pagamentoInvalido.pagar();
        pagamentoInvalido.exibirDetalhes();
    }
}
