public class Homem extends SerVivo {
    public Homem(String nome, int idade) {
        super(nome, idade);
    }

    public void dizOi(double valor) {
        System.out.println("Oi! Meu número da sorte é " + valor);
    }

    public void adivinharIdade(double idade) {
        if (idade == this.idade) {
            System.out.println("Você acertou! Eu tenho " + idade + " anos.");
        } else {
            System.out.println("Você errou! Eu tenho " + this.idade + " anos.");
        }
    }
}
