export const mockSubjects = [
	{ name: "Matéria 1", affinity: 1 },
	{ name: "Matéria 2", affinity: 5 },
	{ name: "Matéria 3", affinity: 3 },
] as const;

export const mockTypes = [
	{ name: "Exercício", weight: 1 },
	{ name: "Atividade", weight: 3 },
	{ name: "Projeto", weight: 5 },
] as const;

export const mockTasks = [
	{
		id: "1",
		title: "Tarefa 1",
		subject: mockSubjects[0],
		type: mockTypes[2],
		dificulty: 4,
		subtasks: [
			{ title: "Subtarefa 1", completed: false },
			{ title: "Subtarefa 2", completed: true },
			{ title: "Subtarefa 3", completed: false },
		],
		dateAssigned: "2026-08-10",
		deadline: "2026-09-10",
	},
] as const;
