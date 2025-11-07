class Aluno {
    //* ========== ATRIBUTOS ==========
    private String nome;
    private Turma turma;
    private int matricula;

    //* ========== CONSTRUTOR ==========
    public Aluno(String nome, int matricula) {
        this.nome = nome;
        this.matricula = matricula;
        this.turma = null; 
    }

    //* ========== GETTERS ==========
    public String getNome() {
        return nome;
    }
    public Turma getTurma() {
        return turma;
    }
    public int getMatricula() {
        return this.matricula;
    }

    //* ========== MÉTODOS ==========
    public void adicionarAluno(Turma turma) {
        this.turma = turma;  
    }
}