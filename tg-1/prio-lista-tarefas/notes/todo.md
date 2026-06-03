# TODO LIST: PRIÔ LISTA DE TAREFAS ESTUDANTIL


## Front-end Telas e Componentes
[ ] Tela de cadastro de matérias (período letivo e afinidade)  
[ ] Tela de edição e exclusão de matérias cadastradas  
[ ] Tela principal de tarefas pendentes ordenadas por urgência  
[ ] Filtros de tarefas (por matéria, tipo e urgência)  
[ ] Modal/Tela de adição de tarefas (com data atual pré-selecionada)  
* [ ] Campos para alteração de data de lançamento e inserção de data de entrega  
* [ ] Campo de dificuldade subjetiva da tarefa  
* [ ] Menu dropdown para seleção do tipo de tarefa  
* [ ] Seção opcional para criação de subtarefas vinculadas  

[ ] Opção de marcar subtarefas como concluídas  
[ ] Opção de editar e excluir tarefas e subtarefas  
[ ] Tela de configurações de pesos e tipos de tarefas  


## Back-end e Regras de Negócio
[ ] Armazenamento de dados de matérias e afinidade por período letivo  
[ ] Vinculação de tarefas a matérias específicas  
[ ] Mecanismo de cálculo do índice de urgência (escala 1 a 5)  
[ ] Integração do tempo decorrido/prazo de entrega no cálculo  
[ ] Integração da dificuldade subjetiva no cálculo  
[ ] Integração do índice de afinidade da matéria no cálculo  
[ ] Redução proporcional da urgência baseado em subtarefas concluídas  
[ ] Aplicação do peso do tipo da tarefa no cálculo  
[ ] Rotina automatizada diária (CRON job) para atualizar índice de urgência  
[ ] Monitoramento de mudança no nível de urgência pós-atualização diária  
[ ] Configuração de horário preferencial do usuário para alertas diários  


## Notificações
[ ] Subida de nível na escala de urgência da tarefa (ex: passou de 2 para 3)  
[ ] 3 dias até a entrega  
[ ] Tarefa em atraso  


## Requisitos
RF01: permitir o cadastro de matérias do período letivo corrente.  
RF02: permitir a edição e exclusão de matérias cadastradas.  
RF03: associar um nível ou índice de afinidade (definido pelo usuário) a cada matéria cadastrada.  
RF04: bloquear a alteração dos dados das matérias após o salvamento inicial, permitindo modificações apenas em um novo período letivo ou mediante confirmação explícita de edição.  
RF05: permitir o cadastro de tarefas pendentes vinculadas a uma matéria.  
RF06: pré-selecionar a data atual do dispositivo como a data de lançamento da tarefa.  
RF07: permitir que o usuário altere manualmente a data de lançamento da tarefa.  
RF08: permitir a inserção da data de entrega (prazo final) da tarefa.  
RF09: disponibilizar um campo para o usuário atribuir um nível de dificuldade subjetiva à tarefa.  
RF10: disponibilizar um campo de seleção do tipo de tarefa através de um menu dropdown.  
RF11: permitir a criação opcional de uma ou mais subtarefas atreladas a uma tarefa principal.  
RF12: permitir que o usuário marque subtarefas como "concluídas".  
RF13: permitir a edição e exclusão de tarefas e subtarefas.  
RF14: disponibilizar uma tela de configurações para o usuário visualizar os tipos de tarefas cadastrados (não avaliativa, avaliativa simples, seminário e projeto).  
RF15: permitir que o usuário altere o peso numérico atribuído a cada tipo de tarefa.  
RF16: calcular o índice de urgência da tarefa em uma escala de 1 a 5.  
RF17: basear o cálculo da urgência no tempo decorrido entre a data de lançamento e a data atual (ou proximidade do prazo de entrega).  
RF18: integrar o nível de dificuldade subjetiva da tarefa no cálculo da urgência.  
RF19: integrar o índice de afinidade da matéria no cálculo da urgência.  
RF20: reduzir proporcionalmente o índice de urgência com base no percentual de subtarefas já concluídas.  
RF21: multiplicar o peso do tipo da tarefa selecionado no cálculo da urgência.  
RF22: executar uma rotina automatizada diária para atualizar o índice de urgência de todas as tarefas ativas.  
RF23: exibir uma lista de tarefas pendentes ordenadas pelo índice de urgência atual (do mais urgente para o menos urgente).  
RF24: exibir visualmente o nível de urgência (1 a 5) de cada tarefa por meio de cores ou indicadores gráficos distintos.  
RF25: permitir filtrar as tarefas por matéria, tipo de tarefa e nível de urgência.  
RF26: monitorar a mudança do nível de urgência de cada tarefa após a atualização diária.  
RF27: enviar uma notificação push para o dispositivo do usuário sempre que uma tarefa subir de nível na escala de urgência.  
RF28: permitir ao usuário configurar o horário preferencial para o recebimento das notificações diárias.  