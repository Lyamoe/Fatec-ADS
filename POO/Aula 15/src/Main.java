public class Main {
    public static void main(String[] args) throws Exception {
        ContaCorrente conta = new ContaCorrente(18495, "Lyam");
        conta.sacar(30.20);
        conta.depositar(40.63);
        conta.sacar(30.54);
        conta.sacar(2.50);
    }
}