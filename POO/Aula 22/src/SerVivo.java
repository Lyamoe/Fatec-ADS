public class SerVivo {
    String nome;
    int idade;

    public SerVivo(String nome, int idade) {
        this.nome = nome;
        this.idade = idade;
    }

    public void dizOi (){
        System.out.println("Olá! Tudo bem?");
    }
    public void dizOi (String seuNome){
        System.out.println("Olá, " + seuNome + ". Eu sou " + this.nome + "! Tudo bem?");
    }
}
