import * as BackgroundFetch from "expo-background-fetch";
import * as TaskManager from "expo-task-manager";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { calculateInitialPriorities } from "../utils/priorityEngine";
import { mockTasks } from "../constants/mockData";
import { sendLocalNotification } from "../utils/notifications"; // Import helper

export const BACKGROUND_FETCH_TASK = "BACKGROUND_TASK_UPDATE_PRIORITIES";
export const TASKS_STORAGE_KEY = "USER_TASKS_LIST";

export async function registerBackgroundFetchAsync() {
	return BackgroundFetch.registerTaskAsync(BACKGROUND_FETCH_TASK, {
		minimumInterval: 60 * 60 * 24, // 24 hours (in seconds)
		stopOnTerminate: false, // Keep running if app is closed
		startOnBoot: true, // Start task when device turns on
	});
}

TaskManager.defineTask(BACKGROUND_FETCH_TASK, async () => {
	try {
		const storedData = await AsyncStorage.getItem(TASKS_STORAGE_KEY);
		let previousTasks = storedData ? JSON.parse(storedData) : [];

		if (previousTasks.length === 0) {
			// First run fallback
			const initializedMocks = calculateInitialPriorities([...mockTasks]);
			await AsyncStorage.setItem(
				TASKS_STORAGE_KEY,
				JSON.stringify(initializedMocks),
			);
			return BackgroundFetch.BackgroundFetchResult.NewData;
		}

		// Calculate the newly updated priorities based on the current date change
		const newlyUpdatedTasks = calculateInitialPriorities(previousTasks);

		const todayMs = new Date().setHours(0, 0, 0, 0);

		// Loop through tasks to check conditions
		for (const newTask of newlyUpdatedTasks) {
			if (newTask.progress === 100) continue; // Skip completed tasks

			// Find the corresponding older version of this task to check priority changes
			const oldTask = previousTasks.find((t: any) => t.id === newTask.id);

			const deadlineMs = new Date(newTask.deadline).setHours(0, 0, 0, 0);
			const daysLeft = Math.ceil(
				(deadlineMs - todayMs) / (1000 * 60 * 60 * 24),
			);

			// --- TRIGGER 1: 3 Days until deadline ---
			if (daysLeft === 3) {
				await sendLocalNotification(
					"⏳ Prazo se aproximando!",
					`Faltam apenas 3 dias para entregar: "${newTask.title}"`,
				);
			}

			// --- TRIGGER 3: Task is late ---
			if (daysLeft < 0) {
				await sendLocalNotification(
					"🚨 Tarefa Atrasada!",
					`O prazo de "${newTask.title}" venceu em ${newTask.dateText}.`,
				);
			}

			// --- TRIGGER 2: Priority Index Changes ---
			if (oldTask && oldTask.priority !== undefined) {
				const oldP = oldTask.priority;
				const newP = newTask.priority;

				// Moved to High Priority (crossed 3.5)
				if (newP >= 3.5 && oldP < 3.5) {
					await sendLocalNotification(
						"🔥 Prioridade Máxima!",
						`"${newTask.title}" agora é de prioridade ALTA. Organize seu tempo!`,
					);
				}
				// Moved to Medium Priority (crossed 2.0 but below 3.5)
				else if (newP >= 2.0 && newP < 3.5 && oldP < 2.0) {
					await sendLocalNotification(
						"⚠️ Atenção redobrada",
						`"${newTask.title}" subiu para a prioridade MÉDIA.`,
					);
				}
			}
		}

		// Save the newly updated lists back to local device storage
		await AsyncStorage.setItem(
			TASKS_STORAGE_KEY,
			JSON.stringify(newlyUpdatedTasks),
		);

		return BackgroundFetch.BackgroundFetchResult.NewData;
	} catch (error) {
		console.error(
			"Background fetch priority and notification handler failed:",
			error,
		);
		return BackgroundFetch.BackgroundFetchResult.Failed;
	}
});

