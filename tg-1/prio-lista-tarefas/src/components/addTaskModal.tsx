import React, { useState } from "react";
import {
	StyleSheet,
	Text,
	View,
	TouchableOpacity,
	Modal,
	TextInput,
	ScrollView,
	Platform,
	Alert,
} from "react-native";
import Slider from "@react-native-community/slider";
import { Picker } from "@react-native-picker/picker";
import DateTimePicker from "@react-native-community/datetimepicker";
import { mockSubjects, mockTypes } from "@/constants/mockData";

interface AddTaskModalProps {
	visible: boolean;
	onClose: () => void;
	onSave: (newTask: any) => void;
}

export default function AddTaskModal({
	visible,
	onClose,
	onSave,
}: AddTaskModalProps) {
	// --- FORM STATES ---
	const [taskName, setTaskName] = useState("");
	const [selectedSubject, setSelectedSubject] = useState<string>(
		mockSubjects[0].name,
	);
	const [selectedType, setSelectedType] = useState<string>(mockTypes[0].name);
	const [difficulty, setDifficulty] = useState(3);
	const [dateAssigned, setDateAssigned] = useState(new Date());
	const [deadline, setDeadline] = useState(new Date());
	const [subtasks, setSubtasks] = useState<
		{ title: string; completed: boolean }[]
	>([]);

	// Picker visibility toggles
	const [showAssignedPicker, setShowAssignedPicker] = useState(false);
	const [showDeadlinePicker, setShowDeadlinePicker] = useState(false);

	const handleAddSubtaskInput = () => {
		if (subtasks.length >= 5) {
			Alert.alert(
				"Limite atingido",
				"Você só pode adicionar até 5 subtarefas.",
			);
			return;
		}
		setSubtasks([...subtasks, { title: "", completed: false }]);
	};

	const handleSubtaskTextChange = (text: string, index: number) => {
		const updatedSubtasks = [...subtasks];
		updatedSubtasks[index].title = text;
		setSubtasks(updatedSubtasks);
	};

	const resetForm = () => {
		setTaskName("");
		setSelectedSubject(mockSubjects[0].name);
		setSelectedType(mockTypes[0].name);
		setDifficulty(3);
		setDateAssigned(new Date());
		setDeadline(new Date());
		setSubtasks([]);
	};

	const handleSubmit = () => {
		if (!taskName.trim()) {
			Alert.alert("Erro", "Por favor, digite o nome da tarefa.");
			return;
		}

		const subjectObj = mockSubjects.find((s) => s.name === selectedSubject);
		const typeObj = mockTypes.find((t) => t.name === selectedType);

		const newTask = {
			id: Date.now().toString(),
			title: taskName,
			subject: subjectObj,
			type: typeObj,
			dificulty: Math.round(difficulty),
			subtasks: subtasks.filter((sub) => sub.title.trim() !== ""),
			dateAssigned: dateAssigned.toISOString().split("T")[0],
			deadline: deadline.toISOString().split("T")[0],
		};

		onSave(newTask);
		resetForm();
		onClose();
	};

	return (
		<Modal
			animationType="slide"
			transparent={true}
			visible={visible}
			onRequestClose={onClose}
		>
			<View style={styles.modalOverlay}>
				<View style={styles.modalContainer}>
					<ScrollView showsVerticalScrollIndicator={false}>
						<Text style={styles.modalHeaderTitle}>Nova Tarefa</Text>

						{/* Task Name */}
						<Text style={styles.label}>Nome da Tarefa</Text>
						<TextInput
							style={styles.input}
							value={taskName}
							onChangeText={setTaskName}
							placeholder="Ex: Estudar Álgebra"
						/>

						{/* Subject Dropdown */}
						<Text style={styles.label}>Matéria</Text>
						<View style={styles.pickerWrapper}>
							{Platform.OS === "web" ? (
								<select
									value={selectedSubject}
									onChange={(e) => setSelectedSubject(e.target.value)}
									style={styles.webSelect}
								>
									{mockSubjects.map((sub) => (
										<option key={sub.name} value={sub.name}>
											{sub.name}
										</option>
									))}
								</select>
							) : (
								<Picker
									selectedValue={selectedSubject}
									onValueChange={(itemValue) => setSelectedSubject(itemValue)}
								>
									{mockSubjects.map((sub) => (
										<Picker.Item
											key={sub.name}
											label={sub.name}
											value={sub.name}
										/>
									))}
								</Picker>
							)}
						</View>

						{/* Type Dropdown */}
						<Text style={styles.label}>Tipo de Atividade</Text>
						<View style={styles.pickerWrapper}>
							{Platform.OS === "web" ? (
								<select
									value={selectedType}
									onChange={(e) => setSelectedType(e.target.value)}
									style={styles.webSelect}
								>
									{mockTypes.map((t) => (
										<option key={t.name} value={t.name}>
											{t.name}
										</option>
									))}
								</select>
							) : (
								<Picker
									selectedValue={selectedType}
									onValueChange={(itemValue) => setSelectedType(itemValue)}
								>
									{mockTypes.map((t) => (
										<Picker.Item key={t.name} label={t.name} value={t.name} />
									))}
								</Picker>
							)}
						</View>

						{/* Difficulty Slider */}
						<Text style={styles.label}>
							Dificuldade: {Math.round(difficulty)}
						</Text>
						<Slider
							minimumValue={1}
							maximumValue={5}
							step={1}
							value={difficulty}
							onValueChange={setDifficulty}
							minimumTrackTintColor="#4dd0e1"
							maximumTrackTintColor="#ccc"
						/>

						{/* Date Assigned */}
						<Text style={styles.label}>Data de Atribuição</Text>
						<TouchableOpacity
							style={styles.dateButton}
							onPress={() => setShowAssignedPicker(true)}
						>
							<Text>{dateAssigned.toLocaleDateString("pt-BR")}</Text>
						</TouchableOpacity>
						{showAssignedPicker && (
							<DateTimePicker
								value={dateAssigned}
								mode="date"
								maximumDate={new Date()}
								display="default"
								onChange={(event, selectedDate) => {
									setShowAssignedPicker(false);
									if (selectedDate) setDateAssigned(selectedDate);
								}}
							/>
						)}

						{/* Deadline */}
						<Text style={styles.label}>Prazo Final (Deadline)</Text>
						<TouchableOpacity
							style={styles.dateButton}
							onPress={() => setShowDeadlinePicker(true)}
						>
							<Text>{deadline.toLocaleDateString("pt-BR")}</Text>
						</TouchableOpacity>
						{showDeadlinePicker && (
							<DateTimePicker
								value={deadline}
								mode="date"
								minimumDate={new Date()}
								display="default"
								onChange={(event, selectedDate) => {
									setShowDeadlinePicker(false);
									if (selectedDate) setDeadline(selectedDate);
								}}
							/>
						)}

						{/* Subtasks Section */}
						<View style={styles.subtaskHeaderRow}>
							<Text style={styles.label}>Subtarefas ({subtasks.length}/5)</Text>
							<TouchableOpacity
								style={styles.addSubtaskBtn}
								onPress={handleAddSubtaskInput}
							>
								<Text style={styles.addSubtaskBtnText}>+ Adicionar</Text>
							</TouchableOpacity>
						</View>

						{subtasks.map((subtask, index) => (
							<TextInput
								key={index}
								style={styles.input}
								value={subtask.title}
								onChangeText={(text) => handleSubtaskTextChange(text, index)}
								placeholder={`Subtarefa ${index + 1}`}
							/>
						))}

						{/* Form Actions */}
						<View style={styles.actionRow}>
							<TouchableOpacity
								style={[styles.actionBtn, styles.cancelBtn]}
								onPress={onClose}
							>
								<Text style={styles.cancelBtnText}>Cancelar</Text>
							</TouchableOpacity>
							<TouchableOpacity
								style={[styles.actionBtn, styles.saveBtn]}
								onPress={handleSubmit}
							>
								<Text style={styles.saveBtnText}>Criar Tarefa</Text>
							</TouchableOpacity>
						</View>
					</ScrollView>
				</View>
			</View>
		</Modal>
	);
}

const styles = StyleSheet.create({
	modalOverlay: {
		flex: 1,
		backgroundColor: "rgba(0,0,0,0.5)",
		justifyContent: "flex-end",
	},
	modalContainer: {
		backgroundColor: "#fff",
		borderTopLeftRadius: 20,
		borderTopRightRadius: 20,
		padding: 20,
		maxHeight: "85%",
	},
	modalHeaderTitle: {
		fontSize: 22,
		fontWeight: "bold",
		marginBottom: 20,
		textAlign: "center",
	},
	label: {
		fontSize: 14,
		fontWeight: "600",
		color: "#333",
		marginTop: 15,
		marginBottom: 5,
	},
	input: {
		borderWidth: 1,
		borderColor: "#ccc",
		borderRadius: 8,
		padding: 10,
		fontSize: 16,
		backgroundColor: "#fafafa",
	},
	pickerWrapper: {
		borderWidth: 1,
		borderColor: "#ccc",
		borderRadius: 8,
		backgroundColor: "#fafafa",
		overflow: "hidden",
	},
	webSelect: {
		width: "100%",
		padding: 10,
		fontSize: 16,
		backgroundColor: "#fafafa",
		outline: "none",
	},
	dateButton: {
		borderWidth: 1,
		borderColor: "#ccc",
		borderRadius: 8,
		padding: 12,
		backgroundColor: "#fafafa",
	},
	subtaskHeaderRow: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		marginTop: 15,
		marginBottom: 5,
	},
	addSubtaskBtn: {
		backgroundColor: "#eaf4f8",
		paddingHorizontal: 12,
		paddingVertical: 6,
		borderRadius: 6,
	},
	addSubtaskBtnText: { color: "#007bff", fontWeight: "bold" },
	actionRow: {
		flexDirection: "row",
		justifyContent: "space-between",
		marginTop: 30,
		paddingBottom: 20,
	},
	actionBtn: { flex: 0.48, padding: 15, borderRadius: 8, alignItems: "center" },
	cancelBtn: { backgroundColor: "#f5f5f5" },
	cancelBtnText: { color: "#333", fontWeight: "bold" },
	saveBtn: { backgroundColor: "#4dd0e1" },
	saveBtnText: { color: "#fff", fontWeight: "bold" },
});
