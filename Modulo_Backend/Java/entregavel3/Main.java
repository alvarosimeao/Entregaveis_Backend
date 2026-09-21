public class Main {

    public static void main(String[] args) {
        Elevador elevador = new Elevador(1, 400, 600);

        elevador.Subir();

        elevador.solicitarAndar(10);

        elevador.setPesoAtual(700);
        elevador.Subir();
    }
}