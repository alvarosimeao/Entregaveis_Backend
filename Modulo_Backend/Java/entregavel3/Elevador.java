public class Elevador {

    private int andarAtual;
    private int pesoAtual;
    private int pesoMaximo;

    public Elevador(int andarAtual, int pesoAtual, int pesoMaximo) {
        this.andarAtual = andarAtual;
        this.pesoAtual = pesoAtual;
        this.pesoMaximo = pesoMaximo;
    }

    public void setPesoAtual(int pesoAtual) {
        this.pesoAtual = pesoAtual;
    }

    public void Subir() {
        if (pesoAtual > pesoMaximo) {
            System.out.println("Excesso de peso. O elevador não pode subir.");
        } else if (andarAtual == 15) {
            System.out.println("O elevador já está no último andar.");
        } else {
            andarAtual++;
            System.out.println("O elevador subiu para o andar " + andarAtual);
        }
    }

    public void Descer() {
        if (pesoAtual > pesoMaximo) {
            System.out.println("Excesso de peso. O elevador não pode descer.");
        } else if (andarAtual == 1) {
            System.out.println("O elevador já está no primeiro andar.");
        } else {
            andarAtual--;
            System.out.println("O elevador desceu para o andar " + andarAtual);
        }
    }

    public void solicitarAndar(int andarSolicitado) {
        if (andarSolicitado < 1 || andarSolicitado > 15) {
            System.out.println("Esse andar não existe.");
        } else if (pesoAtual > pesoMaximo) {
            System.out.println(
                "Excesso de peso. O elevador não pode sair do andar "
                + andarAtual
            );
        } else if (andarSolicitado == andarAtual) {
            System.out.println("O elevador já está nesse andar.");
        } else {
            andarAtual = andarSolicitado;
            System.out.println("O elevador foi para o andar " + andarAtual);
        }
    }
}