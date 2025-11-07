public class PessoaFisica extends Pessoa {
    protected String cpf;
    public PessoaFisica(String nome, String endereco, String telefone, String cpf) {
        super(nome, endereco, telefone);
        this.cpf = cpf;
    }
}
