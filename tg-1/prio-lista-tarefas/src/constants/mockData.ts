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
		dateAssigned: "2026-06-01",
		deadline: "2026-06-15",
	},
	{
		id: "2",
		title: "Tarefa 2",
		subject: mockSubjects[1],
		type: mockTypes[0],
		dificulty: 2,
		subtasks: [
			{ title: "Subtarefa 1", completed: true },
			{ title: "Subtarefa 2", completed: false },
		],
		dateAssigned: "2026-06-05",
		deadline: "2026-06-20",
	},
	{
		id: "3",
		title: "Tarefa 3",
		subject: mockSubjects[2],
		type: mockTypes[1],
		dificulty: 3,
		subtasks: [{ title: "Subtarefa 1", completed: false }],
		dateAssigned: "2026-06-10",
		deadline: "2026-06-25",
	},
	{
		id: "4",
		title: "Tarefa 4",
		subject: mockSubjects[0],
		type: mockTypes[1],
		dificulty: 4,
		subtasks: [
			{ title: "Subtarefa 1", completed: false },
			{ title: "Subtarefa 2", completed: false },
		],
		dateAssigned: "2026-06-12",
		deadline: "2026-06-18",
	},
] as const;
