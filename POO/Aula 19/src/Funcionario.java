public class Funcionario extends PessoaFisica {
    // * ========== ATRIBUTOS ==========
    private double salario;
    private String login;
    private String senha;
    private String lotacao;
    private double horas;

    // * ========== CONSTRUTOR ==========
    public Funcionario(String nome, String endereco, String telefone, String cpf, double salario, String login,
            String senha, String lotacao, double horas) {
        super(nome, endereco, telefone, cpf);
        this.salario = salario;
        this.login = login;
        this.senha = senha;
        this.lotacao = lotacao;
        this.horas = horas;
    }

    // * ========== GETTERS & SETTERS ==========
    public String getNome() {
        return this.nome;
    }

    public String getEndereco() {
        return this.endereco;
    }

    public String getTelefone() {
        return this.telefone;
    }

    public String getCpf() {
        return this.cpf;
    }

    public double getSalario() {
        return this.salario;
    }

    public String getLogin() {
        return this.login;
    }

    public String getSenha() {
        return this.senha;
    }

    public String getLotacao() {
        return this.lotacao;
    }

    public double getHoras() {
        return this.horas;
    }

    // * ========== MÉTODOS ==========
    public double bonificacao() {
        return Math.round((this.salario * 0.10) * 100D) / 100D;
    }
    public boolean autenticacao(String login, String senha) {
        boolean autenticado = false;
        if (this.login.equals(login) && this.senha.equals(senha)) {
            autenticado = true;
        }
        return autenticado;
    }
}
