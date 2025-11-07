import java.util.Scanner;

public class ClienteEmpresa extends PessoaJuridica {
    protected String produto;
    protected int quantidade;
    protected float tempoEntrega;
    protected String proximaEntrega;

    //construtor
    public ClienteEmpresa(String produto, String cnpj, String nome){
        super(cnpj, nome);
        this.produto = produto;
    }
    

    //getters
    public String getProduto(){
        return this.produto;
    }
    public int getQuantidade(){
        return this.quantidade;
    }

    public float getTempoEntrega(){
        return this.tempoEntrega;
    }

    public String getProximaEntrega(){
        return this.proximaEntrega;
    }

    //setters
    public void setQuantidade(int quantidade){
        this.quantidade = quantidade;
    }
    public void setTempoEntrega(float tempoEntrega){
        this.tempoEntrega = tempoEntrega;
    }

    public void setProximaEntrega(String proximaEntrega){
        this.proximaEntrega = proximaEntrega;
    }

    //métodos
    public boolean pedidoAdiantamento (String data){
        System.out.println("O cliente quer adiantar o pedido para " + data);
        System.out.println("Digite 's' para aceitar o adiantamento ou 'n' para negar");
        Scanner scanner = new Scanner(System.in);
        String resposta = scanner.nextLine();
        scanner.close();
        if (resposta=="s") {
            return true;
        }
        return false;
    }
}
