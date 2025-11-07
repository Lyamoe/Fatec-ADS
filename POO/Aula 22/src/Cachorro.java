public class Cachorro extends SerVivo {
    public Cachorro(String nome, int idade) {
        super(nome, idade);
    }

    public void dizOi (){
        System.out.println("Au au!");
    }
    public void dizOi (String seuNome){
        System.out.println("Au, au au! — ele tentou dizer " + seuNome);
    }
}
