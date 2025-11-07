public class Pessoa {
    private String nome;
    private int diaNasc;
    private int mesNasc;
    private int anoNasc;

    // Construtor
    public Pessoa(String nome, int diaNasc, int mesNasc, int anoNasc) {
        this.nome = nome;
        this.diaNasc = diaNasc;
        this.mesNasc = mesNasc;
        this.anoNasc = anoNasc;
    }

    // Getters
    public String getNome() {
        return this.nome;
    }

    public int getDiaNasc() {
        return this.diaNasc;
    }

    public int getMesNasc() {
        return this.mesNasc;
    }

    public int getAnoNasc() {
        return this.anoNasc;
    }

    // Setters
    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setDiaNasc(int diaNasc) {
        this.diaNasc = diaNasc;
    }

    public void setMesNasc(int mesNasc) {
        this.mesNasc = mesNasc;
    }

    public void setAnoNasc(int anoNasc) {
        this.anoNasc = anoNasc;
    }

    // Metodos
    public String idade(int dia, int mes, int ano) {
        if (this.mesNasc > mes || (this.mesNasc == mes && this.diaNasc > dia)) {
            return this.nome + " tem " + (ano - this.anoNasc - 1) + " anos";
        }
        return this.nome + " tem " + (ano - this.anoNasc) + " anos";
    }
}
