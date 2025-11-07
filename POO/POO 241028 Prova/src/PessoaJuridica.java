public class PessoaJuridica extends Pessoa{
    protected String cnpj;

    //construtor
    public PessoaJuridica(String cnpj, String nome){
        super(nome);
        this.cnpj = cnpj;
    }

    //getter
    public String getCnpj(){
        return this.cnpj;
    }
}