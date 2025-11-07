import java.util.Random;

public class Elevador {
    private int andarAtual = 0;
    private int totalAndares;
    private int capacidadeAtual = 0;
    private int capacidade;

    // Construtor
    public Elevador(int totalAndares, int capacidade) {
        this.totalAndares = totalAndares;
        this.capacidade = capacidade;
    }

    // Getters
    public int getAndarAtual() {
        return andarAtual;
    }

    public int getCapacidadeAtual() {
        return capacidadeAtual;
    }

    // Setters
    public void setTotalAndares(int totalAndares) {
        this.totalAndares = totalAndares;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    // Metodos
    public boolean entra() {
        if (capacidadeAtual < capacidade) {
            capacidadeAtual++;
            return true;
        }
        return false;
    }

    public boolean sai() {
        if (capacidadeAtual != 0) {
            capacidadeAtual--;
            return true;
        }
        return false;
    }

    public boolean sobe() {
        if (andarAtual < totalAndares) {
            andarAtual++;
            return true;
        }
        return false;
    }

    public boolean desce() {
        if (andarAtual != 0) {
            andarAtual--;
            return true;
        }
        return false;
    }

    public void testes() {
        Random random = new Random();
        System.out.println("O elevador foi ligado");
        for (int i = 0; i < 50; i++) {
            int proximaFuncao = random.nextInt(4);
            switch (proximaFuncao) {
                case 1:
                    boolean entrou = this.entra();
                    if (entrou) {
                        System.out.println("Uma nova pessoa entrou no elevador. Agora há " +
                        this.getCapacidadeAtual() + " pessoa(s)");
                    } else {
                        System.out.println("Tentara entrar, mas o elevador está cheio");
                    }
                    break;
                case 2:
                    boolean saiu = this.sai();
                    if (saiu) {
                        System.out.println("Uma pessoa saiu do elevador. Agora há " +
                        this.getCapacidadeAtual() + " pessoa(s)");
                    } else {
                        System.out.println("Um fantasma tentou sair, mas ele não existia");
                    }
                    break;
                case 3:
                    boolean subiu = this.sobe();
                    if (subiu) {
                        System.out.println("O elevador sobe um andar. Estamos no " +
                        this.getAndarAtual() + "° andar");
                    } else {
                        System.out.println("O elevador tentou subir, mas já estava no andar mais alto");
                    }
                    break;
                case 4:
                    boolean desceu = this.desce();
                    if (desceu) {
                        System.out.println("O elevador desce um andar. Estamos no " +
                        this.getAndarAtual() + "° andar");
                    } else {
                        System.out.println("O elevador tentou descer, mas já estava no terreo");
                    }
                    break;
            }
        }
        System.out.println("O elevador foi desligado");
    }
}
