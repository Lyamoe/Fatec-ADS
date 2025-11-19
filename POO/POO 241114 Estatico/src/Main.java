public class Main {
  public static void main(String[] args) {
    // * ========== INSTÂNCIAS ==========
    // * alunos
    Aluno aluno1 = new Aluno("Kim Lip", "24001", 8.5, 9.3, 6.3, 7, 17);
    Aluno aluno2 = new Aluno("Jinsoul", "24002", 9.5, 9, 10, 9, 1);
    Aluno aluno3 = new Aluno("Choerry", "24003", 4, 2.6, 4.9, 10, 4);

    // * ========== CHAMANDO MÉTODOS ==========
    aluno1.notasDoAluno();
    aluno2.notasDoAluno();
    aluno3.notasDoAluno();
    Aluno.alunosCadastrados();
  }
}