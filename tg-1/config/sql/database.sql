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
CREATE
OR REPLACE VIEW v_prioridade_escolar AS
WITH
    calculo_base AS (
        SELECT
            atv.id,
            atv.titulo_atividade,
            atv.data_entrega,
            atv.nivel_dificuldade,
            -- 1. CÁLCULO DA IMPORTÂNCIA
            (
                (
                    (6 - mt.indice_afinidade) + atv.nivel_dificuldade + tipo.peso_tipo
                ) * (
                    0.5 + (
                        COALESCE(
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    subtarefas
                                WHERE
                                    atividade_id = atv.id
                                    AND concluida = 1
                            ),
                            0
                        ) / NULLIF(
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    subtarefas
                                WHERE
                                    atividade_id = atv.id
                            ),
                            0
                        )
                    )
                )
            ) / 22.5 AS importancia,
            -- 2. CÁLCULO DA URGÊNCIA
            LEAST (
                1,
                (
                    DATEDIFF (CURRENT_DATE, atv.data_atribuicao) / NULLIF(
                        DATEDIFF (atv.data_entrega, atv.data_atribuicao),
                        0
                    )
                ) * 1.5
            ) AS urgencia
        FROM
            atividades atv
            JOIN materias mt ON atv.materia_id = mt.id
            JOIN tipos_atribuicoes tipo ON atv.tipo_id = tipo.id
        WHERE
            atv.concluida = FALSE
    ),
    calculo_prioridade AS (
        SELECT
            *,
            ROUND(5 * ((importancia + urgencia) / 2), 1) AS prioridade_preliminar
        FROM
            calculo_base
    )
SELECT
    id,
    titulo_atividade,
    importancia,
    urgencia,
    -- 4. CÁLCULO DA PRIORIDADE FINAL
    CASE
    -- Se não há subtarefas pendentes
        WHEN (
            SELECT
                COUNT(*)
            FROM
                subtarefas
            WHERE
                atividade_id = id
                AND concluida = 0
        ) = 0 THEN 0
        -- Se está atrasado
        WHEN DATEDIFF (data_entrega, CURRENT_DATE) < 0 THEN 5
        -- Se é difícil ou está perto do prazo
        WHEN nivel_dificuldade = 5
        OR DATEDIFF (data_entrega, CURRENT_DATE) <= 2 THEN LEAST (5, prioridade_preliminar + 1)
        ELSE prioridade_preliminar
    END AS prioridade_final
FROM
    calculo_prioridade;

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