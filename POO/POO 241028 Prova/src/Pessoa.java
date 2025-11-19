public class Pessoa {
    private int contadorId = 0;
    protected String nome;
    protected int id;

    //construtor
    public Pessoa(String nome){
        this.nome = nome;
        this.id = criarId();
    }

    //getters
    public String getNome(){
        return this.nome;
    }

    public int getId(){
        return this.id;
    }

    //setters
    public void setNome(String nome){
        this.nome = nome;
    }

    public void setId(int id){
        this.id = id;
    }
    
    //métodos
    private int criarId(){
        contadorId++;
        return contadorId;
    }
}
