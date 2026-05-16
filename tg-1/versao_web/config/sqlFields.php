<?php
$sqlTables = [
    'materias', //? 0
    'tipos_atribuicoes', //? 1
    'atividades', //? 2
    'subtarefas', //? 3
];
$sqlFields = [
    // * ---------- MATÉRIAS ----------
    'nome_materia', //? 0
    'nome_professor', //? 1
    'indice_afinidade', //? 2

    // * ---------- TIPOS ATRIBUICOES ----------
    'nome_atribuicao', //? 3
    'peso_tipo', //? 4

    // * ---------- ATIVIDADES ----------
    'titulo_atividade', //? 5
    'descricao_atividade', //? 6
    'data_atribuicao', //? 7
    'data_entrega', //? 8
    'nivel_dificuldade', //? 9
    'materia_id', //? 10
    'tipo_id', //? 11
    'concluida', //? 12

    // * ---------- SUBTAREFAS ----------
    'atividade_id', //? 13
    'descricao', //? 14
    'concluida', //? 15
];