import React, { useState, useEffect } from "react";
import {
	StyleSheet,
	Text,
	View,
	SafeAreaView,
	ScrollView,
	TouchableOpacity,
	Alert,
	Platform,
} from "react-native";
import * as Notifications from "expo-notifications";

Notifications.setNotificationHandler({
	handleNotification: async () => ({
		shouldShowAlert: true,
		shouldPlaySound: true,
		shouldSetBadge: false,
		shouldShowBanner: true,
		shouldShowList: true,
	}),
});

export default function App() {
	const [tasks, setTasks] = useState([
		{
			id: "1",
			title: "Tarefa 1",
			subject: "Matéria relacionada",
			progress: "0% feita",
			date: "13/03/2026",
			type: "high",
		},
		{
			id: "2",
			title: "Tarefa 2",
			subject: "Matéria relacionada",
			progress: "0% feita",
			date: "15/03/2026",
			type: "high",
		},
		{
			id: "3",
			title: "Tarefa 3",
			subject: "Matéria relacionada",
			progress: "80% feita",
			date: "12/03/2026",
			type: "high",
		},
		{
			id: "4",
			title: "Tarefa 4",
			subject: "Matéria relacionada",
			progress: "43% feita",
			date: "16/03/2026",
			type: "medium",
		},
		{
			id: "5",
			title: "Tarefa 5",
			subject: "Matéria relacionada",
			progress: "83% feita",
			date: "20/03/2026",
			type: "low",
		},
	]);

	// Request permissions on mount
	useEffect(() => {
		async function requestPermissions() {
			const { status } = await Notifications.requestPermissionsAsync();
			if (status !== "granted") {
				Alert.alert(
					"Permission required",
					"Please enable notifications to use this feature.",
				);
			}
		}
		requestPermissions();
	}, []);

	// Function to schedule a notification 10 seconds after adding a task
	const scheduleTaskNotification = async (taskTitle: string) => {
		await Notifications.scheduleNotificationAsync({
			content: {
				title: "Task Reminder! ⏰",
				body: `It's time to work on: ${taskTitle}`,
				sound: true,
			},
			trigger: {
        type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
				seconds: 10, // Fires exactly 10 seconds later
			},
		});
	};

	// Handler for the Floating Action Button
	const handleAddTask = async () => {
		const nextId = (tasks.length + 1).toString();
		const newTaskName = `Tarefa ${nextId}`;

		const newTask = {
			id: nextId,
			title: newTaskName,
			subject: "Matéria relacionada",
			progress: "0% feita",
			date: "25/03/2026",
			type: "medium",
		};

		setTasks([...tasks, newTask]);

		// Fire the notification trigger
		await scheduleTaskNotification(newTaskName);
		Alert.alert(
			"Sucesso",
			`${newTaskName} criada! Notificação em 10 segundos.`,
		);
	};

	// Dynamic style helper for different task priority colors
	const getPriorityStyle = (type: string) => {
		switch (type) {
			case "high":
				return {
					bg: "#FFF5F5",
					iconBg: "#FF8A8A",
					icon: "🔥",
					textColor: "#E53E3E",
				};
			case "medium":
				return {
					bg: "#F0F4FF",
					iconBg: "#93C5FD",
					icon: "⚠️",
					textColor: "#1D4ED8",
				};
			case "low":
				return {
					bg: "#F2FBF4",
					iconBg: "#86EFAC",
					icon: "☕",
					textColor: "#166534",
				};
			default:
				return { bg: "#FFF", iconBg: "#CCC", icon: "•", textColor: "#000" };
		}
	};

	return (
		<SafeAreaView style={styles.container}>
			{/* Top Header Section */}
			<View style={styles.header}>
				<Text style={styles.headerTitle}>Para essa semana</Text>

				<View style={styles.statsContainer}>
					<View style={styles.statBox}>
						<Text style={styles.statLabel}>Tarefas</Text>
						<View style={styles.circle}>
							<Text style={styles.circleText}>{tasks.length}</Text>
						</View>
					</View>

					<View style={styles.statBox}>
						<Text style={styles.statLabel}>Andamento</Text>
						<View style={styles.circle}>
							<Text style={styles.circleText}>31%</Text>
						</View>
					</View>
				</View>
			</View>

			{/* Pendências Title */}
			<View style={styles.sectionTitleContainer}>
				<Text style={styles.sectionTitle}>Pendências</Text>
				<View style={styles.underline} />
			</View>

			{/* Task List */}
			<ScrollView
				style={styles.taskList}
				contentContainerStyle={{ paddingBottom: 100 }}
			>
				{tasks.map((task) => {
					const styleConfig = getPriorityStyle(task.type);
					return (
						<View
							key={task.id}
							style={[styles.taskCard, { backgroundColor: styleConfig.bg }]}
						>
							<View style={styles.taskLeft}>
								<View
									style={[
										styles.iconCircle,
										{ backgroundColor: styleConfig.iconBg },
									]}
								>
									<Text style={styles.iconText}>{styleConfig.icon}</Text>
								</View>
								<View>
									<Text style={styles.taskTitle}>{task.title}</Text>
									<Text style={styles.taskSub}>{task.subject}</Text>
								</View>
							</View>

							<View style={styles.taskRight}>
								<Text
									style={[
										styles.taskProgress,
										{ color: styleConfig.textColor },
									]}
								>
									{task.progress}
								</Text>
								<Text style={styles.taskDate}>{task.date}</Text>
							</View>
						</View>
					);
				})}
			</ScrollView>

			{/* Floating Action Button */}
			<TouchableOpacity style={styles.fab} onPress={handleAddTask}>
				<Text style={styles.fabText}>+</Text>
			</TouchableOpacity>
		</SafeAreaView>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: "#FAFAFA",
		paddingTop: Platform.OS === "android" ? 40 : 0,
	},
	header: {
		backgroundColor: "#EBF7FC",
		paddingHorizontal: 20,
		paddingVertical: 24,
		borderBottomLeftRadius: 4,
		borderBottomRightRadius: 4,
		alignItems: "center",
	},
	headerTitle: {
		fontSize: 22,
		fontWeight: "700",
		color: "#111",
		marginBottom: 16,
	},
	statsContainer: {
		flexDirection: "row",
		justifyContent: "space-around",
		width: "100%",
	},
	statBox: {
		alignItems: "center",
	},
	statLabel: {
		fontSize: 14,
		fontWeight: "600",
		color: "#444",
		marginBottom: 8,
	},
	circle: {
		width: 75,
		height: 75,
		borderRadius: 37.5,
		borderWidth: 4,
		borderColor: "#66D1FF",
		backgroundColor: "#FFF",
		justifyContent: "center",
		alignItems: "center",
	},
	circleText: {
		fontSize: 20,
		fontWeight: "bold",
		color: "#111",
	},
	sectionTitleContainer: {
		alignItems: "center",
		marginVertical: 20,
	},
	sectionTitle: {
		fontSize: 20,
		fontWeight: "700",
		color: "#222",
	},
	underline: {
		width: 120,
		height: 3,
		backgroundColor: "#66D1FF",
		marginTop: 4,
	},
	taskList: {
		paddingHorizontal: 16,
	},
	taskCard: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		padding: 14,
		borderRadius: 8,
		marginBottom: 12,
	},
	taskLeft: {
		flexDirection: "row",
		alignItems: "center",
	},
	iconCircle: {
		width: 38,
		height: 38,
		borderRadius: 19,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 12,
	},
	iconText: {
		fontSize: 16,
	},
	taskTitle: {
		fontSize: 15,
		fontWeight: "bold",
		color: "#222",
	},
	taskSub: {
		fontSize: 12,
		color: "#777",
		marginTop: 2,
	},
	taskRight: {
		alignItems: "flex-end",
	},
	taskProgress: {
		fontSize: 13,
		fontWeight: "bold",
	},
	taskDate: {
		fontSize: 11,
		color: "#888",
		marginTop: 4,
	},
	fab: {
		position: "absolute",
		bottom: 30,
		right: 24,
		backgroundColor: "#54D4FF",
		width: 60,
		height: 60,
		borderRadius: 30,
		justifyContent: "center",
		alignItems: "center",
		elevation: 4,
		shadowColor: "#000",
		shadowOpacity: 0.15,
		shadowOffset: { width: 0, height: 2 },
		shadowRadius: 4,
	},
	fabText: {
		fontSize: 32,
		color: "#FFF",
		lineHeight: 34,
	},
});
