public class PessoaFisica extends Pessoa{ 
    protected String cpf;
    protected String dataNasc;

    //construtor
    public PessoaFisica(String cpf, String dataNasc, String nome){
        super(nome);
        this.cpf = cpf;
        this.dataNasc = dataNasc;
    }

    //getters
    public String getCpf(){
        return this.cpf;
    }

    public String getDataNasc(){
        return this.dataNasc;
    }

    //setters
    public void setCpf(String cpf){
        this.cpf = cpf;
    }

    public void setDataNasc(String dataNasc){
        this.dataNasc = dataNasc;
    }
}