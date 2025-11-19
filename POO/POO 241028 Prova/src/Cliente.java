public class Cliente extends PessoaFisica {
    private int avaliacao;
    protected int vezesLoja;
    protected double totalGasto;

    //construtor
    public Cliente(String cpf, String dataNasc, String nome){
        super(cpf, dataNasc, nome);
    }

    //getters
    public int getVezesLoja(){
        return this.vezesLoja;
    }
    
    public double getTotalGasto(){
        return this.totalGasto;
    }

    public int getAvaliacao(){
        return this.avaliacao;
    }

    //métodos
    public void compra (double total, String formaPgmt, double valorPago, Vendedor vendedor){
        System.out.println("A compra do cliente deu um total de R$" + total);
        System.out.println("Foi entregue ao caixa R$" + valorPago);
        if (total > valorPago) {
            System.out.println("Quantia insuficiente. Compra não realizada");
            return;
        }
        if (total < valorPago) {
            System.out.println("Compra efetuada. O  troco é R$" + (valorPago - total));
        }
        if (total == valorPago) {
            System.out.println("Compra efetuada e não há troco");
        }
        this.vezesLoja++;
        this.totalGasto += total;
        vendedor.compraFinalizada(total);
    }

    public void avaliarLoja (int nota){
        if (nota > 5 || nota < 1) {
            System.out.println("Houve uma tentativa de avaliar a loja, mas sem sucesso.");
            return;
        }
        this.avaliacao = nota;
    }
}
