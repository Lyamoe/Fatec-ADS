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
