import { useEffect, useState } from "react";
import {
	StyleSheet,
	Text,
	View,
	Image,
	TouchableOpacity,
	StatusBar,
	ScrollView,
	Alert,
} from "react-native";
import { SafeAreaView, SafeAreaProvider } from "react-native-safe-area-context";
import { MaterialCommunityIcons, Ionicons } from "@expo/vector-icons";
import AsyncStorage from "@react-native-async-storage/async-storage";

// --- CUSTOM IMPORTS ---
import { mockTasks } from "@/constants/mockData";
import { calculateInitialPriorities } from "@/utils/priorityEngine";
import {
	registerBackgroundFetchAsync,
	TASKS_STORAGE_KEY,
} from "@/services/backgroudTasks";
import { registerForPushNotificationsAsync } from "@/utils/notifications";
import { AddTaskModal } from "@/components/addTaskModal";

export default function App() {
	const [tasks, setTasks] = useState<any[]>([]);
	const [modalVisible, setModalVisible] = useState(false);

	useEffect(() => {
		try {
			registerForPushNotificationsAsync().catch((err) =>
				console.log("Push notification registration failed:", err),
			);
		} catch (e) {
			console.log("Push notification crashed natively:", e);
		}

		try {
			registerBackgroundFetchAsync().catch((err) =>
				console.log("Background fetch registration skipped:", err.message),
			);
		} catch (e) {
			console.log("Background fetch crashed natively:", e);
		}

		loadAndInitializeTasks();
	}, []);

	const loadAndInitializeTasks = async () => {
		try {
			const storedData = await AsyncStorage.getItem(TASKS_STORAGE_KEY);
			if (storedData) {
				setTasks(JSON.parse(storedData));
			} else {
				// 🚨 SUSPECT 2: Safety check around priority calculation
				console.log("Initializing mock tasks...");
				if (!mockTasks) {
					console.log("Warning: mockTasks is empty or undefined!");
					return;
				}

				const initializedMocks = calculateInitialPriorities([...mockTasks]);
				await AsyncStorage.setItem(
					TASKS_STORAGE_KEY,
					JSON.stringify(initializedMocks),
				);
				setTasks(initializedMocks);
			}
		} catch (error) {
			// This catches JSON parse errors or AsyncStorage lockdown failures
			console.error("Failed to load tasks safely:", error);
			Alert.alert(
				"Erro de Inicialização",
				"Não foi possível carregar os dados locais.",
			);
		}
	};

	// Recalculates prioritization indexes immediately after custom tasks get saved
	const handleSaveNewTask = async (newTask: any) => {
		try {
			const updatedList = calculateInitialPriorities([...tasks, newTask]);
			await AsyncStorage.setItem(
				TASKS_STORAGE_KEY,
				JSON.stringify(updatedList),
			);
			setTasks(updatedList);
		} catch (error) {
			console.error("Error saving task:", error);
		}
	};

	const totalTasks = tasks.length;
	const averageProgress =
		totalTasks > 0
			? Math.round(
					tasks.reduce((acc, t) => acc + (t.progress || 0), 0) / totalTasks,
				)
			: 0;

	return (
		<SafeAreaProvider>
			<SafeAreaView style={styles.container}>
				<StatusBar barStyle="dark-content" backgroundColor="#fff" />

				{/* CABEÇALHO */}
				<View style={styles.header}>
					<TouchableOpacity>
						<Ionicons name="menu" size={40} color="black" />
					</TouchableOpacity>
					<Image
						source={{ uri: "https://i.pravatar.cc/100?img=5" }}
						style={styles.profilePic}
					/>
				</View>

				<ScrollView
					contentContainerStyle={styles.scrollContent}
					showsVerticalScrollIndicator={false}
				>
					{/* RESUMO */}
					<View style={styles.summaryContainer}>
						<Text style={styles.summaryTitle}>Suas tarefas pendentes</Text>
						<View style={styles.statsRow}>
							<View style={styles.statItem}>
								<Text style={styles.statLabel}>Tarefas</Text>
								<View style={styles.circle}>
									<Text style={styles.circleNumber}>{totalTasks}</Text>
								</View>
							</View>
							<View style={styles.statItem}>
								<Text style={styles.statLabel}>Andamento</Text>
								<View style={styles.circle}>
									<Text style={styles.circleNumber}>{averageProgress}%</Text>
								</View>
							</View>
						</View>
					</View>

					{/* LISTA */}
					<View style={styles.listContainer}>
						<View style={styles.listHeader}>
							<Text style={styles.listTitle}>Pendências</Text>
							<View style={styles.titleUnderline} />
						</View>

						<View style={styles.tableHeaders}>
							{/* 🎯 FIXED: Strings are kept compact on single lines to prevent space injection */}
							<Text style={styles.tableHeaderText}>
								{"Índice de\nprioridade"}
							</Text>
							<Text style={styles.tableHeaderText}>
								{"descrição da\ntarefa"}
							</Text>
							<Text style={[styles.tableHeaderText, { textAlign: "right" }]}>
								{"andamento\ne prazo"}
							</Text>
						</View>

						{tasks.map((task) => (
							<View
								key={task.id}
								style={[
									styles.taskCard,
									{ backgroundColor: task.cardBgColor || "#fafafa" },
								]}
							>
								<View
									style={[
										styles.iconContainer,
										{ backgroundColor: task.iconBgColor || "#eee" },
									]}
								>
									<MaterialCommunityIcons
										name={task.icon || "help-circle"}
										size={20}
										color={
											task.icon === "coffee"
												? "#5c4033"
												: task.icon === "alert"
													? "#ffcc00"
													: "#ff4d4d"
										}
									/>
								</View>

								<View style={styles.taskInfo}>
									<Text style={styles.taskTitle}>{task.title}</Text>
									<Text style={styles.taskDesc}>{task.desc}</Text>
								</View>

								<View style={styles.taskStatus}>
									<Text
										style={[
											styles.progressText,
											{ color: task.progressColor || "#333" },
										]}
									>
										{task.progressText}
									</Text>
									<Text
										style={[
											styles.dateText,
											{ color: task.dateColor || "#888" },
										]}
									>
										{task.dateText}
									</Text>
								</View>
							</View>
						))}
					</View>
				</ScrollView>

				{/* FLOATING ACTION BUTTON (FAB) */}
				<TouchableOpacity
					style={styles.fab}
					onPress={() => setModalVisible(true)}
				>
					<Ionicons name="add" size={32} color="#8a2be2" />
				</TouchableOpacity>

				{/* REFACTORED MODAL COMPONENT */}
				<AddTaskModal
					visible={modalVisible}
					onClose={() => setModalVisible(false)}
					onSave={handleSaveNewTask}
				/>
			</SafeAreaView>
		</SafeAreaProvider>
	);
}

const styles = StyleSheet.create({
	container: { flex: 1, backgroundColor: "#fff" },
	scrollContent: { paddingBottom: 100 },
	header: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		paddingHorizontal: 20,
		paddingTop: 10,
		paddingBottom: 10,
	},
	profilePic: { width: 45, height: 45, borderRadius: 25 },
	summaryContainer: {
		backgroundColor: "#eaf4f8",
		paddingVertical: 25,
		alignItems: "center",
	},
	summaryTitle: { fontSize: 22, fontWeight: "bold", marginBottom: 20 },
	statsRow: {
		flexDirection: "row",
		justifyContent: "space-around",
		width: "60%",
	},
	statItem: { alignItems: "center" },
	statLabel: { fontSize: 14, fontWeight: "600", marginBottom: 8 },
	circle: {
		width: 80,
		height: 80,
		borderRadius: 40,
		borderWidth: 4,
		borderColor: "#4dd0e1",
		justifyContent: "center",
		alignItems: "center",
		backgroundColor: "#eaf4f8",
	},
	circleNumber: { fontSize: 24, fontWeight: "bold" },
	listContainer: { paddingHorizontal: 15, paddingTop: 20 },
	listHeader: { alignItems: "center", marginBottom: 20 },
	listTitle: { fontSize: 20, fontWeight: "bold" },
	titleUnderline: {
		width: 120,
		height: 2,
		backgroundColor: "#4dd0e1",
		marginTop: 5,
	},
	tableHeaders: {
		flexDirection: "row",
		justifyContent: "space-between",
		marginBottom: 10,
		paddingHorizontal: 5,
	},
	tableHeaderText: { fontSize: 10, color: "#888", textAlign: "center" },
	taskCard: {
		flexDirection: "row",
		alignItems: "center",
		padding: 15,
		borderRadius: 10,
		marginBottom: 10,
	},
	iconContainer: {
		width: 40,
		height: 40,
		borderRadius: 20,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 15,
	},
	taskInfo: { flex: 1 },
	taskTitle: { fontSize: 16, fontWeight: "bold" },
	taskDesc: { fontSize: 13, color: "#666", marginTop: 2 },
	taskStatus: { alignItems: "flex-end" },
	progressText: { fontSize: 14, fontWeight: "bold" },
	dateText: { fontSize: 12, marginTop: 2 },
	fab: {
		position: "absolute",
		right: 20,
		bottom: 30,
		width: 60,
		height: 60,
		borderRadius: 30,
		backgroundColor: "#4dd0e1",
		justifyContent: "center",
		alignItems: "center",
		elevation: 5,
		shadowColor: "#000",
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.3,
		shadowRadius: 3,
	},
});
