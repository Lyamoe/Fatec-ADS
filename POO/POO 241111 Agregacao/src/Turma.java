
//* ========== IMPORTS ==========
import java.util.ArrayList;
import java.util.List;

public class Turma {
  // * ========== ATRIBUTOS ==========
  private int anoInicio;
  private int semestre;
  private String curso;
  private List<Disciplina> disciplinas;
  private List<Aluno> alunos;

  // * ========== CONSTRUTOR ==========
  public Turma(int anoInicio, int semestre, String curso) {
    this.anoInicio = anoInicio;
    this.semestre = semestre;
    this.curso = curso;
    this.disciplinas = new ArrayList<>();
    this.alunos = new ArrayList<>();
  }

  // * ========== GETTERS ==========
  public int getAnoInicio() {
    return this.anoInicio;
  }

  public int getSemestre() {
    return this.semestre;
  }

  public String getCurso() {
    return this.curso;
  }

  public List<Disciplina> getDisciplinas() {
    return this.disciplinas;
  }

  public List<Aluno> getAlunos() {
    return this.alunos;
  }

  public void setSemestre(int semestre) {
    this.semestre = semestre;
  }

  // * ========== MÉTODOS ==========
  public void adicionarDisciplina(Disciplina disciplina) {
    disciplinas.add(disciplina);
  }

  public void matricularAluno(Aluno aluno) {
    alunos.add(aluno);
    aluno.adicionarAluno(this);
  }

  public void obterInfo() {
    System.out.println("--------------------------------------------------------");
    System.out.println("Alunos na turma " + this.getCurso() + " do " + this.getSemestre() + "° semestre");
    System.out.println("--------------------------------------------------------");
    for (Aluno aluno : this.getAlunos()) {
      System.out.println(aluno.getNome());
    }
    System.out.println("--------------------------------------------------------");
    System.out.println("Disciplinas do semestre");
    System.out.println("--------------------------------------------------------");
    for (Disciplina disciplina : this.getDisciplinas()) {
      System.out.println(disciplina.getNomeDisciplina() + " - " + disciplina.getIdDisciplina() + " - " + disciplina.getProfessor().getNome());
    }
    System.out.println("--------------------------------------------------------");
  }
}