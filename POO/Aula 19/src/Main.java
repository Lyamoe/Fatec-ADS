import java.util.Scanner;

public class Main {
    public static void main(    String[] args) throws Exception {
        //* ========== CRIAÇÃO DE OBJETO ==========
        double salario = 4500.75;
        String login = "lyamoe";
        String senha = "1234";
        String lotacao = "Departamento de TI";
        double horas = 36;
        String nome = "Lyam Santos Peres";
        String endereco = "Rua Cinco n° 116";
        String telefone = "(12)99116-4873";
        String cpf = "403-311-528-51";
        Funcionario lyam = new Funcionario(nome, endereco, telefone, cpf, salario, login, senha, lotacao, horas);

        //* ========== TELA DE LOGIN ==========
        Scanner input = new Scanner(System.in);
        System.out.println("+----------------------------------------------------------------+");
        System.out.println("          Seja bem vinde ao sistema da empresa Loonaverse");
        System.out.println("|----------------------------------------------------------------|");
        System.out.println("Insira o seu usuário:");
        String loginAcesso = input.nextLine();
        System.out.println("|----------------------------------------------------------------|");
        System.out.println("Insira a sua senha:");
        String senhaAcesso = input.nextLine();
        System.out.println("+----------------------------------------------------------------+");
        System.out.println("");
        input.close();
        boolean entrou = lyam.autenticacao(loginAcesso, senhaAcesso);

        //* ========== ACESSO AO SISTEMA ==========
        if (entrou) {
            System.out.println("+----------------------------------------------------------------+");
            System.out.println("                Seja bem vinde, " + lyam.getNome());
            System.out.println("|----------------------------------------------------------------|");
            System.out.println("Local de trabalho: " + lyam.getLotacao());
            System.out.println("Carga horária semanal:" + lyam.getHoras());
            System.out.println("Salário: R$" + lyam.getSalario());
            System.out.println("Bonificação: R$" + lyam.bonificacao());
            System.out.println("Recebimento total: R$" + Math.round((lyam.getSalario() + lyam.bonificacao()) * 100D) / 100D);
            System.out.println("+----------------------------------------------------------------+");
        } else {
            System.out.println("+----------------------------------------------------------------+");
            System.out.println("Usuário ou senha incorretos. Tente novamente.");
            System.out.println("|----------------------------------------------------------------|");
        }
    }
}
