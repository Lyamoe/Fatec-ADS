import { HintRow } from "@/components/hint-row";
import { ThemedText } from "@/components/themed-text";
import { ThemedView } from "@/components/themed-view";
import { WebBadge } from "@/components/web-badge";
import { BottomTabInset, MaxContentWidth, Spacing } from "@/constants/theme";
import * as Device from "expo-device";
import { Image, Platform, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

function getDevMenuHint() {
		return <ThemedText type="code">Professor me obrigou</ThemedText>;
}

export default function HomeScreen() {
	return (
		<ThemedView style={styles.container}>
			<SafeAreaView style={styles.safeArea}>
				<ThemedView style={styles.heroSection}>
					<Image
						source={require("@/assets/images/icon.png")}
						style={{ width: 150, height: 150, alignSelf: "center" }}
					/>
					<ThemedText type="title" style={styles.title}>
						Esse é o Meu Site Legal
					</ThemedText>
				</ThemedView>

				<ThemedText type="code" style={styles.code}>
					Veja como ele é legal
				</ThemedText>

				<ThemedView type="backgroundElement" style={styles.stepContainer}>
					<HintRow
						title="Pq ele é legal?"
						hint={<ThemedText type="code">feito por Lyam</ThemedText>}
					/>
					<HintRow title="Pq vc fez ele?" hint={getDevMenuHint()} />
					<HintRow
						title="E por que devo usá-lo?"
						hint={
							<ThemedText type="code">Não precisa ele n faz nada</ThemedText>
						}
					/>
				</ThemedView>

				{Platform.OS === "web" && <WebBadge />}
			</SafeAreaView>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		justifyContent: "center",
		flexDirection: "row",
	},
	safeArea: {
		flex: 1,
		paddingHorizontal: Spacing.four,
		alignItems: "center",
		gap: Spacing.three,
		paddingBottom: BottomTabInset + Spacing.three,
		maxWidth: MaxContentWidth,
	},
	heroSection: {
		alignItems: "center",
		justifyContent: "center",
		flex: 1,
		paddingHorizontal: Spacing.four,
		gap: Spacing.four,
	},
	title: {
		textAlign: "center",
	},
	code: {
		textTransform: "uppercase",
	},
	stepContainer: {
		gap: Spacing.three,
		alignSelf: "stretch",
		paddingHorizontal: Spacing.three,
		paddingVertical: Spacing.four,
		borderRadius: Spacing.four,
	},
});
