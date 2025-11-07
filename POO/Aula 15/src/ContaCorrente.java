public class ContaCorrente {
    //* Atributos
    private int numero;
    private String titular;
    private double saldo;

    //* Construtor
    public ContaCorrente(int numero, String titular) {
        this.numero = numero;
        this.titular = titular;
    }

    //* Getters e Setters
    public int getNumero() {
        return this.numero;
    }
    public String getTitular() {
        return this.titular;
    }
    public double getSaldo() {
        return this.saldo;
    }
    public void setNumero(int novoNumero) {
        this.numero = novoNumero;
    } 
    public void setTitular(String novoTitular) {
        this.titular = novoTitular;
    }

    //* Métodos
    public void sacar(double quantia) {
        if (this.saldo == 0) {
            System.out.println("Não há dinheiro na conta.");
        } else {
            if (quantia > this.saldo * 0.2) {
                System.out.println("Quantia muito alta. Tente um valor abaixo de R$" + getSaldo() * 0.2);
            }
            if (quantia <= this.saldo * 0.2) {
                this.saldo -= quantia;
                System.out.println("Quantia sacada com sucesso. Seu saldo atual é de R$" + getSaldo());
            }
        }
        
    }
    public void depositar(double quantia) {
        this.saldo += quantia;
        System.out.println("Quantia depositada com sucesso. Seu saldo atual é de R$" + getSaldo());
    }
}