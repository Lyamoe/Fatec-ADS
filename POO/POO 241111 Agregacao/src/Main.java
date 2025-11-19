
public class Main {
  public static void main(String[] args) {
    // * ========== INSTÂNCIAS ==========
    // * alunos
    Aluno aluno1 = new Aluno("Heejin", 24001);
    Aluno aluno2 = new Aluno("Hyunjin", 24002);
    Aluno aluno3 = new Aluno("Haseul", 24003);
    Aluno aluno4 = new Aluno("Yeojin", 24004);
    Aluno aluno5 = new Aluno("Vivi", 24005);

    // * disciplinas
    Disciplina disciplina1 = new Disciplina("Contabilidade", "CCG006");
    Disciplina disciplina2 = new Disciplina("Estatística aplicada", "EST020");
    // * professores
    Professor professor1 = new Professor("Carlos Oliveira");
    Professor professor2 = new Professor("Diana Malheiro");
    // * turmas
    Turma Ads20241 = new Turma(2024, 2, "ADS");

    // * ========== ATRIBUINDO À TURMA ==========
    // * alunos
    Ads20241.matricularAluno(aluno1);
    Ads20241.matricularAluno(aluno2);
    Ads20241.matricularAluno(aluno3);
    Ads20241.matricularAluno(aluno4);
    Ads20241.matricularAluno(aluno5);
    // * disciplinas
    Ads20241.adicionarDisciplina(disciplina1);
    Ads20241.adicionarDisciplina(disciplina2);
    // * professores
    disciplina1.AtribuirDisciplina(professor1);
    disciplina2.AtribuirDisciplina(professor2);

    // * ========== CHAMANDO MÉTODOS ==========
    Ads20241.obterInfo();
  }
}