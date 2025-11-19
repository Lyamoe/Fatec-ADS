public class Aluno {
  // * ========== ATRIBUTOS ==========
  private String nomeAluno;
  private String ra;
  private double nota1;
  private double nota2;
  private double nota3;
  private double nota4;
  private int faltas;
  private static int quant = 0;

  // * ========== CONSTRUTOR ==========
  public Aluno(String nomeAluno, String ra, double nota1, double nota2, double nota3, double nota4, int faltas) {
    notasInseridas();
    this.nomeAluno = nomeAluno;
    this.ra = ra;
    this.nota1 = nota1;
    this.nota2 = nota2;
    this.nota3 = nota3;
    this.nota4 = nota4;
    this.faltas = faltas;
  }

  // * ========== GETTERS ==========
  public String getNomeAluno() {
    return this.nomeAluno;
  }

  public String getRa() {
    return this.ra;
  }

  public int getFaltas() {
    return this.faltas;
  }

  // * ========== MÉTODOS ==========
  public static void notasInseridas() {
    quant++;
  }

  public static void alunosCadastrados() {
    System.out.println("Alunos cadastrados no sistema:" + quant);
  }

  public double calculaMedia() {
    return (this.nota1 + this.nota2 + this.nota3 + this.nota4) / 4;
  }

  public String situacao() {
    if (this.calculaMedia() <= 7 && this.faltas > 16) {
      return ("Aluno reprovado por média e faltas.");

    } else if (this.calculaMedia() <= 7) {
      return ("Aluno reprovado por média.");

    } else if (this.faltas > 16) {
      return ("Aluno reprovado por faltas excedidas.");

    } else {
      return ("Aluno aprovado.");
    }
  }

  public void notasDoAluno() {
    System.out.println("+------------------------------------------------------------------+");
    System.out.println("                        Sobre o aluno");
    System.out.println("+------------------------------------------------------------------+");
    System.out.println("Nome do aluno: " + this.nomeAluno);
    System.out.println("RA: " + this.ra);
    System.out.println("Quantidade de faltas: " + this.faltas);
    System.out.println("+------------------------------------------------------------------+");
    System.out.println("                     Notas no semestre");
    System.out.println("+------------------------------------------------------------------+");
    System.out.println("Prova 1: " + this.nota1);
    System.out.println("Prova 2: " + this.nota2);
    System.out.println("Seminário 1: " + this.nota3);
    System.out.println("Atividade 1: " + this.nota4);
    System.out.println("");
    System.out.println("Média Final: " + this.calculaMedia());
    System.out.println("+------------------------------------------------------------------+");
    System.out.println("                Situação do aluno na disciplina");
    System.out.println("+------------------------------------------------------------------+");
    System.out.println(this.situacao());
    System.out.println("+------------------------------------------------------------------+");
  }
}