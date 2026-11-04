CREATE DATABASE IF NOT EXISTS lista_atividades;

USE lista_atividades;

-- ==================== CREATE TABLES ==================== 
CREATE TABLE
    IF NOT EXISTS materias (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome_materia VARCHAR(255) NOT NULL,
        nome_professor VARCHAR(255),
        indice_afinidade INT CHECK (indice_afinidade BETWEEN 1 AND 5)
    );

CREATE TABLE
    IF NOT EXISTS tipos_atribuicoes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome_atribuicao VARCHAR(255) NOT NULL,
        peso_tipo INT CHECK (peso_tipo BETWEEN 1 AND 5)
    );

CREATE TABLE
    IF NOT EXISTS atividades (
        id INT AUTO_INCREMENT PRIMARY KEY,
        titulo_atividade VARCHAR(255) NOT NULL,
        descricao_atividade TEXT,
        data_atribuicao DATE DEFAULT (CURRENT_DATE),
        data_entrega DATE NOT NULL,
        nivel_dificuldade INT CHECK (nivel_dificuldade BETWEEN 1 AND 5),
        materia_id INT NOT NULL,
        tipo_id INT NOT NULL,
        concluida BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_materia FOREIGN KEY (materia_id) REFERENCES materias (id),
        CONSTRAINT fk_tipo FOREIGN KEY (tipo_id) REFERENCES tipos_atribuicoes (id)
    );

CREATE TABLE
    IF NOT EXISTS subtarefas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        atividade_id INT NOT NULL,
        descricao VARCHAR(255) NOT NULL,
        concluida BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_atividade FOREIGN KEY (atividade_id) REFERENCES atividades (id) ON DELETE CASCADE
    );

-- ==================== CREATE VIEWS ==================== 
CREATE OR REPLACE VIEW v_prioridade_escolar AS
WITH progresso_subtarefas AS (
    SELECT atividade_id, 
           CAST(SUM(CASE WHEN concluida THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS S
    FROM subtarefas GROUP BY atividade_id
),
metricas_base AS (
    SELECT 
        a.id, a.titulo_atividade, a.data_entrega, t.peso_tipo AS P,
        -- I_I: (6 - A + P + D) * (1 + S * 0.3) / 19.5
        ((6 - m.indice_afinidade + t.peso_tipo + a.nivel_dificuldade) * 
         (1 + COALESCE(ps.S, 0) * 0.3)) / 19.5 AS I_I,
        -- I_U: min(1, (T_dec / T_total) * 1.25)
        LEAST(1.0, (CAST(DATEDIFF(CURRENT_DATE, a.data_atribuicao) AS FLOAT) / 
              NULLIF(DATEDIFF(a.data_entrega, a.data_atribuicao), 0)) * 1.25) AS I_U
    FROM atividades a
    JOIN materias m ON a.materia_id = m.id
    JOIN tipos_atribuicoes t ON a.tipo_id = t.id
    LEFT JOIN progresso_subtarefas ps ON a.id = ps.atividade_id
    WHERE a.concluida = FALSE
),
ipa_base AS (
    SELECT *, ROUND(((I_I + I_U) / 2.0) * 5.0, 2) AS ipa_bruto
    FROM metricas_base
)
SELECT 
    id, titulo_atividade, ROUND(I_I, 2) AS I_I, ROUND(I_U, 2) AS I_U,
    -- IPA Ajustado: min(5.0, IPA + Bonificações)
    LEAST(5.0, ipa_bruto + 
        (CASE WHEN P = 5 THEN 1.0 ELSE 0.0 END) +
        (CASE WHEN DATEDIFF(data_entrega, CURRENT_DATE) BETWEEN 0 AND 3 THEN 1.0 ELSE 0.0 END) +
        (CASE WHEN DATEDIFF(data_entrega, CURRENT_DATE) < 0 THEN 1.0 ELSE 0.0 END)
    ) AS ipa_final
FROM ipa_base;

-- ==================== FIRST INSERTS ==================== 
-- Limpando dados antigos para evitar duplicidade
TRUNCATE TABLE subtarefas;

DELETE FROM atividades;

DELETE FROM materias;

DELETE FROM tipos_atribuicoes;

-- 1. Inserindo Matérias
INSERT INTO
    materias (nome_materia, nome_professor, indice_afinidade)
VALUES
    ('Estrutura de Dados', 'Ana Paula', 5), -- Alta afinidade
    ('Cálculo II', 'Marcos Pontes', 1), -- Baixa afinidade
    ('Interface Humano-Computador', 'Julia Mendes', 4),
    ('Arquitetura de Computadores', 'Carlos Ed.', 3);

-- 2. Inserindo Tipos de Atribuições
INSERT INTO
    tipos_atribuicoes (nome_atribuicao, peso_tipo)
VALUES
    ('Exercício de Fixação', 1),
    ('Relatório', 3),
    ('Seminário', 4),
    ('Projeto', 5);

-- 3. Inserindo Atividades
INSERT INTO
    atividades (
        titulo_atividade,
        data_entrega,
        nivel_dificuldade,
        materia_id,
        tipo_id
    )
VALUES
    (
        'Implementar Árvore Binária',
        '2026-03-05',
        4,
        1,
        4
    ), -- Difícil, mas gosta da matéria
    ('Lista de Integrais', '2026-03-03', 5, 2, 1), -- Muito difícil, prazo curto, pouca afinidade
    (
        'Protótipo de Baixa Fidelidade',
        '2026-03-12',
        2,
        3,
        2
    ), -- Fácil, prazo longo
    ('Simulador de Pipeline', '2026-03-10', 4, 4, 3);

-- Difícil, peso seminário
-- 4. Inserindo Subtarefas 
INSERT INTO
    subtarefas (atividade_id, descricao, concluida)
VALUES
    (1, 'Definir estrutura do nó', 1),
    (1, 'Implementar inserção', 0),
    (1, 'Implementar busca e remoção', 0),
    (2, 'Exercícios 1 ao 10', 1),
    (2, 'Exercícios 11 ao 20', 0),
    (4, 'Pesquisa bibliográfica', 1),
    (4, 'Montagem dos slides', 0);