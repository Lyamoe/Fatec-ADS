public class Disciplina {
  //* ========== ATRIBUTOS ==========
  private String nomeDisciplina;
  private String idDisciplina;
  private Professor professor;
  
  //* ========== CONSTRUTOR ==========
  public Disciplina(String nomeDisciplina, String idDisciplina){
    this.nomeDisciplina = nomeDisciplina;
    this.idDisciplina = idDisciplina;
    this.professor = null;
  }

  //* ========== GETTERS ==========
  public String getNomeDisciplina() {
    return this.nomeDisciplina;
  }
  public String getIdDisciplina() {
    return this.idDisciplina;
  }
  public Professor getProfessor() {
    return this.professor;
  }

  //* ========== MÉTODOS ==========
  public void AtribuirDisciplina(Professor nomeProf){
    this.professor = nomeProf;
  }
}