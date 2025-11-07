public class Fornecedor extends PessoaJuridica{
    protected String produto;
    protected String proximaChegada;

    //construtor
    public Fornecedor(String produto, String proximaChegada, String cnpj, String nome){
        super(cnpj, nome);
        this.produto = produto;
        this.proximaChegada = proximaChegada;
    }
    
    //getters
    public String getProduto(){
        return this.produto;
    }

    public String getProximaChegada(){
        return this.proximaChegada;
    }


    //setters
    public void setProduto(String produto){
        this.produto = produto;
    }

    public void setProximaChegada(String proximaChegada){
        this.proximaChegada = proximaChegada;
    }

    //métodos
    public void adiantarEntrega (String data){
        System.out.println("O fornecedor será contatado a respeito do adiantamento para " + data);
    }
}


