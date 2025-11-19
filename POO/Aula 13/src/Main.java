public class Main {
    public static void main(String[] args) throws Exception {
        Pessoa lyam = new Pessoa("Lyam", 3, 1, 2006);
        String idadeDeLyam = lyam.idade(17, 9, 2024);
        System.out.println(idadeDeLyam);
    }
}
