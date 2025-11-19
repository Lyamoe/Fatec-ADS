public class Vendedor extends PessoaFisica{
    protected int comprasEfetuadas = 0;
    protected double valorTotalVendido = 0;
    protected double salario;

    //construtor
    public Vendedor(double salario, String cpf, String dataNasc, String nome){
        super(cpf, dataNasc, nome);
        this.salario = salario;
    }

    //getters
    public int getComprasEfetuadas(){
        return this.comprasEfetuadas;
    }

    public double getValorTotalVendido(){
        return this.valorTotalVendido;
    }

    public double getSalario(){
        return this.salario;
    }

    //setters
    public void setSalario(double salario){
        this.salario = salario;
    }

    //métodos
    protected void compraFinalizada(double valor){
        this.comprasEfetuadas++;
        this.valorTotalVendido += valor;
    }
    public double aumentoPorVenda(){
        return this.salario + valorTotalVendido * 0.3;
    }
}
