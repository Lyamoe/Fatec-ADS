public class Fornecedor {
    int idFornecedor;
    String nome;
    String cnpj;
    String contato;
    String produto;

    public Fornecedor(int idFornecedor, String nome, String cnpj, String contato, String produto) {
        this.idFornecedor = idFornecedor;
        this.nome = nome;
        this.cnpj = cnpj;
        this.contato = contato;
        this.produto = produto;
    }

    public void mensagemCompraMercadoria() {
        System.out.println("Olá! Precisamos de " + this.produto + " vindo do fornecedor " + this.nome + ". Contato: " + this.contato);
    }
}
