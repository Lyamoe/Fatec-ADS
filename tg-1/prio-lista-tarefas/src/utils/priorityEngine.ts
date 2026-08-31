const styleByPriority = [
	{
		icon: "fire",
		iconBgColor: "#ff9e9e",
		cardBgColor: "#fff5f5",
		progressColor: "#e60000",
		dateColor: "#888",
	},
	{
		icon: "alert",
		iconBgColor: "#a1cfff",
		cardBgColor: "#f2f8ff",
		progressColor: "#007bff",
		dateColor: "#888",
	},
	{
		icon: "coffee",
		iconBgColor: "#a8e6a8",
		cardBgColor: "#f4fff4",
		progressColor: "#008000",
		dateColor: "#888",
	},
];

/**
 * Calculates the urgency of a task based on the assigned date and deadline.
 * @param dateAssigned day the task was assigned
 * @param deadline day the task is due
 * @returns A number between 0 and 1 representing the urgency, where 1 is most urgent.
 */
function setUrgency(
	dateAssigned: string | Date,
	deadline: string | Date,
): number {
	const today = new Date().getTime();
	const start = new Date(dateAssigned).getTime();
	const end = new Date(deadline).getTime();

	if (end - start === 0) return 1; // Considera 100% urgente se o prazo é imediato

	const urgency = ((today - start) / (end - start)) * 1.25;

	// Math.min garante que o resultado nunca passe de 1 (100%)
	// Math.max garante que não retorne números negativos caso "today" seja anterior ao lançamento
	return Math.min(1, Math.max(0, urgency));
}

/**
 * Calculates the progress of a task based on its subtasks.
 * @param subtasks Array of subtasks with a 'completed' property
 * @returns A number between 0 and 100 representing the progress percentage
 */
function setProgress(subtasks: { completed: boolean }[]): number {
	const total = subtasks.length;
	const completed = subtasks.filter((subtask) => subtask.completed).length;
	return total > 0 ? (completed / total) * 100 : 0;
}

/**
 * Calculates the importance of a task based on its subject affinity, progress, type weight, and difficulty.
 * @param subjectAffinity A number between 1 and 5 representing the subject affinity
 * @param progress A number between 0 and 100 representing the progress percentage
 * @param typeWeight A number between 1 and 5 representing the type weight
 * @param dificulty A number between 1 and 5 representing the difficulty
 * @returns A number between 0 and 1 representing the importance, where 1 is most important
 */
function setImportance(
	subjectAffinity: number,
	progress: number,
	typeWeight: number,
	dificulty: number,
): number {
	const maxSubjectAffinity = 5; // Supondo que a afinidade máxima seja 5
	const reversedSubjectAffinity = maxSubjectAffinity + 1 - subjectAffinity; // Inverte a afinidade para que 1 seja mais importante que 5
	const maxProgress = 100; // Progresso máximo em porcentagem
	const maxTypeWeight = 5; // Peso máximo para o tipo de tarefa
	const maxDificulty = 5; // Dificuldade máxima

	const maxImportance = maxSubjectAffinity * 1.5 + maxTypeWeight + maxDificulty;
	const currentImportance =
		reversedSubjectAffinity *
		(0.5 + (progress / maxProgress) * typeWeight + dificulty);

	const importance = currentImportance / maxImportance;
	return Math.min(1, importance); // Garante que a importância não ultrapasse 1
}

/**
 * Calculates the priority of a task based on its importance, urgency, progress, deadline, and type weight.
 * @param importance A number between 0 and 1 representing the importance, where 1 is most important
 * @param urgency A number between 0 and 1 representing the urgency, where 1 is most urgent
 * @param progress A number between 0 and 100 representing the progress percentage
 * @param deadline day the task is due
 * @param typeWeight A number between 1 and 5 representing the type weight
 * @returns A number between 0 and 5 representing the priority, where 5 is highest priority
 */
function setPriority(
	importance: number,
	urgency: number,
	progress: number,
	deadline: string | Date,
	typeWeight: number,
): number {
	if (progress === 100) return 0;

	const today = new Date().getTime();
	const end = new Date(deadline).getTime();

	if (today > end) return 5;

	const calculatedPriority = 5 * ((importance + urgency) / 2);
	const priority = Number(calculatedPriority.toFixed(2));

	if (typeWeight >= 4) {
		return Math.min(5, priority + 1);
	}

	return priority;
}

export function calculatePriorities(tasks: any[]): any[] {
	return tasks
		.map((task) => {
			const progress = setProgress([...task.subtasks]);
			const urgency = setUrgency(task.dateAssigned, task.deadline);
			const importance = setImportance(
				task.subject.affinity,
				progress,
				task.type.weight,
				task.dificulty,
			);

			const finalPriority = setPriority(
				importance,
				urgency,
				progress,
				task.deadline,
				task.type.weight,
			);

			//TODO: Add a new style for priority 5 and make it more visually distinct
			let styleTheme = styleByPriority[2]; // Default low
			if (finalPriority >= 3.5) {
				styleTheme = styleByPriority[0]; // High
			} else if (finalPriority >= 2) {
				styleTheme = styleByPriority[1]; // Medium
			}

			return {
				...task,
				urgency,
				importance,
				priority: finalPriority,
				progress,
				...styleTheme,
				progressText: `${Math.round(progress)}% feito`,
				dateText: new Date(task.deadline).toLocaleDateString("pt-BR"),
				desc: `${task.subject.name} • ${task.type.name}`,
			};
		})
		.sort((a, b) => b.priority - a.priority);
}
