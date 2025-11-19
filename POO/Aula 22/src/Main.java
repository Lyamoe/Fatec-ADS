public class Main {
    public static void main(String[] args) throws Exception {
        SerVivo serVivo = new SerVivo("Lyam", 18);
        Cachorro cachorro = new Cachorro("Boris", 9);
        Homem homem = new Homem("Eduardo", 16);
        serVivo.dizOi();
        cachorro.dizOi();
        cachorro.dizOi("Hyeju");
        homem.dizOi(3.141592653589);
        homem.dizOi(7);
        homem.adivinharIdade(17);
        homem.adivinharIdade(16.5);
    }
}
