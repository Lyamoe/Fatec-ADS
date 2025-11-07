public class VendedorGerente extends Vendedor{
    //construtor
    public VendedorGerente(float salario, String cpf, String dataNasc, String nome){
        super(salario, cpf, dataNasc, nome);
    } 

    public void acionarGerente(String problema){
        System.out.println("O vendedor gerente foi acionado para solucionar " + problema);
    }
}
