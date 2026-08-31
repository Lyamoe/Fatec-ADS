import * as Notifications from "expo-notifications";
import { Platform } from "react-native";

// Configure how notifications behave when the app is open
Notifications.setNotificationHandler({
	handleNotification: async () => ({
		shouldShowAlert: true,
		shouldPlaySound: true,
		shouldSetBadge: false,
		shouldShowBanner: true,
		shouldShowList: true,
	}),
});

// Request permissions (Call this inside your App.tsx useEffect)
export async function registerForPushNotificationsAsync() {
	if (Platform.OS === "web") return;

	const { status: existingStatus } = await Notifications.getPermissionsAsync();
	let finalStatus = existingStatus;

	if (existingStatus !== "granted") {
		const { status } = await Notifications.requestPermissionsAsync();
		finalStatus = status;
	}

	if (finalStatus !== "granted") {
		console.log("Falha ao obter permissão para notificações locais.");
		return;
	}
}

// Trigger a local notification after 1 minute (for testing)
export async function sendDelayedTestingNotification(
	title: string,
	body: string,
) {
	if (Platform.OS === "web") return;

	await Notifications.scheduleNotificationAsync({
		content: {
			title,
			body,
			sound: true,
		},
		trigger: {
			type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
			seconds: 5, // 1 minute delay
		},
	});

	console.log("Notification scheduled to fire in 5 seconds!");
}

// Trigger a local notification immediately
export async function sendLocalNotification(title: string, body: string) {
	if (Platform.OS === "web") return;

	await Notifications.scheduleNotificationAsync({
		content: {
			title,
			body,
			sound: true,
		},
		trigger: null, // null means send immediately
	});
}

export async function updateTaskNotifications(task: any) {
	// 1. Cancel previous notifications if the task was modified
	if (task.notificationIds && task.notificationIds.length > 0) {
		for (const id of task.notificationIds) {
			await Notifications.cancelScheduledNotificationAsync(id);
		}
	}

	// If task is complete, stop here (notifications remain cancelled)
	if (task.progress === 100) {
		return [];
	}

	const newNotificationIds: string[] = [];
	const deadline = new Date(task.deadline);
	const now = new Date();

	// Helper to schedule and store the ID
	const schedule = async (title: string, body: string, triggerDate: Date) => {
		if (triggerDate > now) {
			const id = await Notifications.scheduleNotificationAsync({
				content: { title, body },
				trigger: {
					date: triggerDate,
					type: Notifications.SchedulableTriggerInputTypes.DATE,
				},
			});
			newNotificationIds.push(id);
		}
	};

	// --- TRIGGER 1: 3 Days Left ---
	const threeDaysBefore = new Date(deadline);
	threeDaysBefore.setDate(threeDaysBefore.getDate() - 3);
	threeDaysBefore.setHours(9, 0, 0, 0); // Triggers at 9 AM
	await schedule(
		"⏳ Prazo se aproximando!",
		`Faltam apenas 3 dias para entregar: "${task.title}"`,
		threeDaysBefore,
	);

	// --- TRIGGER 2: Late Task ---
	const lateDate = new Date(deadline);
	lateDate.setDate(lateDate.getDate() + 1); // The day after deadline
	lateDate.setHours(9, 0, 0, 0);
	await schedule(
		"🚨 Tarefa Atrasada!",
		`O prazo de "${task.title}" venceu em ${task.dateText}.`,
		lateDate,
	);

	// --- TRIGGER 3 & 4: Priority Shifts ---
	// You must calculate the exact date the priority hits 2.0 and 3.5
	const mediumDate = calculateCrossoverDate(task, 2.0);
	if (mediumDate) {
		await schedule(
			"⚠️ Atenção redobrada",
			`"${task.title}" subiu para a prioridade MÉDIA.`,
			mediumDate,
		);
	}

	const highDate = calculateCrossoverDate(task, 3.5);
	if (highDate) {
		await schedule(
			"🔥 Prioridade Máxima!",
			`"${task.title}" agora é de prioridade ALTA. Organize seu tempo!`,
			highDate,
		);
	}

	// Return the new IDs to save them in AsyncStorage
	return newNotificationIds;
}

function calculateCrossoverDate(
	task: any,
	targetPriority: number,
): Date | null {
	// 1. INVERT YOUR FORMULA HERE
	// Example: If priority depends on time, solve for the days left needed to hit the target.
	const daysLeftToHitTarget = 10 / targetPriority;

	// 2. APPLY TO CALENDAR
	const crossoverDate = new Date(task.deadline);
	crossoverDate.setDate(
		crossoverDate.getDate() - Math.floor(daysLeftToHitTarget),
	);
	crossoverDate.setHours(9, 0, 0, 0);

	// If the date has already passed, return null so it doesn't schedule
	if (crossoverDate <= new Date()) {
		return null;
	}

	return crossoverDate;
}
