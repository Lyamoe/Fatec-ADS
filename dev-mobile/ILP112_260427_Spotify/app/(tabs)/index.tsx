import {
	Montserrat_400Regular,
	Montserrat_700Bold,
	useFonts,
} from "@expo-google-fonts/montserrat";
import { Feather, MaterialCommunityIcons } from "@expo/vector-icons";
import React from "react";
import {
	Image,
	ScrollView,
	StyleSheet,
	Text,
	TouchableOpacity,
	View,
} from "react-native";
import { SafeAreaProvider, SafeAreaView } from "react-native-safe-area-context";

export default function App() {
	useFonts({
		Montserrat_400Regular,
		Montserrat_700Bold,
	});

	return (
		<SafeAreaProvider>
			<SafeAreaView style={styles.container}>
				<ScrollView
					style={styles.scrollContent}
					showsVerticalScrollIndicator={false}
				>
					{/* //* --------------------------------------- */}
					{/* //* ---------------- HEADER --------------- */}
					{/* //* --------------------------------------- */}
					<View style={styles.header}>
						<Text style={styles.heading1}>Boa tarde</Text>

						<View style={styles.iconContainer}>
							<MaterialCommunityIcons
								name="bell-outline"
								size={26}
								color="white"
							/>
							<MaterialCommunityIcons name="history" size={26} color="white" />
							<Feather name="settings" size={24} color="white" />
						</View>
					</View>

					<View style={styles.pillbox}>
						<TouchableOpacity style={styles.pill}>
							<Text style={styles.parag}>Músicas</Text>
						</TouchableOpacity>
						<TouchableOpacity style={styles.pill}>
							<Text style={styles.parag}>Podcasts</Text>
						</TouchableOpacity>
						<TouchableOpacity style={styles.pill}>
							<Text style={styles.parag}>Audiobooks</Text>
						</TouchableOpacity>
					</View>

					{/* //* --------------------------------------- */}
					{/* //* --------- OUVIDOS RECENTEMENTE -------- */}
					{/* //* --------------------------------------- */}

					<View style={styles.recentSection}>
						<View style={styles.recentCol}>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album1.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>Davy D Jones</Text>
							</View>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album2.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>Ma Cigarette</Text>
							</View>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album3.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>Goodnight</Text>
							</View>
						</View>
						<View style={styles.recentCol}>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album4.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>Gato Cerveja</Text>
							</View>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album5.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>Meu Gato Te Odeia</Text>
							</View>
							<View style={styles.recentBox}>
								<Image
									source={require("../../assets/images/albuns/album6.jpeg")}
									style={styles.smallimg}
								/>
								<Text style={styles.recentAlbumName}>I ONE</Text>
							</View>
						</View>
					</View>

					{/* //* --------------------------------------- */}
					{/* //* ------------- LANÇAMENTOS ------------- */}
					{/* //* --------------------------------------- */}
					<View>
						<Text style={styles.heading1}>Novos lançamentos para você</Text>

						<ScrollView
							horizontal
							showsHorizontalScrollIndicator={false}
							style={styles.scrollView}
						>
							<View>
								<Image
									style={styles.bigimg}
									source={{
										uri: "https://cdn-images.dzcdn.net/images/cover/2858a28eade146bf94ee9a144a33077c/0x1900-000000-80-0-0.jpg",
									}}
								/>
								<Text style={styles.subtitle}>Álbum</Text>
								<Text style={styles.boldParag}>DEAD AND</Text>
								<Text style={styles.subtitle}>Xdinary Heroes</Text>
							</View>

							<View>
								<Image
									style={styles.bigimg}
									source={{
										uri: "https://i.scdn.co/image/ab67616d00001e02d3c43f3e6be5a3a895deb800",
									}}
								/>
								<Text style={styles.subtitle}>EP</Text>
								<Text style={styles.boldParag}>NAIL</Text>
								<Text style={styles.subtitle}>Yves</Text>
							</View>

							<View>
								<Image
									style={styles.bigimg}
									source={{
										uri: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb7q8u4gf1zO4Mnf_WJukhkKDaJRxZ5f9VpA&s",
									}}
								/>
								<Text style={styles.subtitle}>Single</Text>
								<Text style={styles.boldParag}>The Show</Text>
								<Text style={styles.subtitle}>DPR IAN</Text>
							</View>

							<View>
								<Image
									style={styles.bigimg}
									source={{
										uri: "https://kprofiles.com/wp-content/uploads/2026/03/Yena_Love_Catcher_digital_album_cover.webp",
									}}
								/>
								<Text style={styles.subtitle}>EP</Text>
								<Text style={styles.boldParag}>LOVE CATCHER</Text>
								<Text style={styles.subtitle}>Yena</Text>
							</View>

							<View>
								<Image
									style={styles.bigimg}
									source={{
										uri: "https://www.katseye.world/wp-content/uploads/sites/2863/2026/03/KATSEYE_PINKY-UP_Cover-Art-1000px-compressed.jpg",
									}}
								/>
								<Text style={styles.subtitle}>Single</Text>
								<Text style={styles.boldParag}>PINKY UP</Text>
								<Text style={styles.subtitle}>KATSEYE</Text>
							</View>
						</ScrollView>
					</View>

					{/* //* --------------------------------------- */}
					{/* //* ---------- ARTISTAS FAVORITOS --------- */}
					{/* //* --------------------------------------- */}
					<View>
						<Text style={styles.heading1}>Seus artistas favoritos</Text>

						<ScrollView
							horizontal
							showsHorizontalScrollIndicator={false}
							style={styles.scrollView}
						>
							<View style={styles.artistInfo}>
								<Image
									style={styles.profileimg}
									source={{
										uri: "https://i.scdn.co/image/ab6761610000e5ebbca2d3a56c90d3a50fb0597d",
									}}
								/>
								<Text style={styles.artistName}>WOODZ</Text>
							</View>

							<View style={styles.artistInfo}>
								<Image
									style={styles.profileimg}
									source={{
										uri: "https://i.scdn.co/image/ab6761610000e5eb9c00ad0308287b38b8fdabc2",
									}}
								/>
								<Text style={styles.artistName}>My Chemical Romance</Text>
							</View>

							<View style={styles.artistInfo}>
								<Image
									style={styles.profileimg}
									source={{
										uri: "https://i.scdn.co/image/ab6761610000e5eb54fc4bff90d96d3ef0179e62",
									}}
								/>
								<Text style={styles.artistName}>TOMORROW X TOGETHER</Text>
							</View>

							<View style={styles.artistInfo}>
								<Image
									style={styles.profileimg}
									source={{
										uri: "https://i.scdn.co/image/ab676161000051748d6e3894be7b8f3914928c50",
									}}
								/>
								<Text style={styles.artistName}>P1Harmony</Text>
							</View>
						</ScrollView>
					</View>
				</ScrollView>
			</SafeAreaView>
		</SafeAreaProvider>
	);
}

{
	/* //* --------------------------------------- */
	/* //* -------------- STYLESHEET ------------- */
	/* //* --------------------------------------- */
}

const sizeBigImg = 150;
const sizeSmallImg = 50;
const styles = StyleSheet.create({
	//* --------------- Textos ---------------
	heading1: {
		fontSize: 22,
		fontWeight: "bold",
		color: "white",
		fontFamily: "Montserrat_700Bold",
		marginTop: 40,
	},
	parag: {
		color: "#f4f4f4",
		fontSize: 14,
		fontFamily: "Montserrat_400Regular",
		fontWeight: "500",
	},
	boldParag: {
		color: "#f4f4f4",
		fontSize: 14,
		fontFamily: "Montserrat_700Bold",
	},
	subtitle: {
		color: "#f4f4f498",
		fontSize: 14,
		fontFamily: "Montserrat_400Regular",
		fontWeight: "500",
	},
	recentAlbumName: {
		color: "#f4f4f4",
		fontSize: 14,
		fontWeight: "500",
		margin: 10,
		fontFamily: "Montserrat_400Regular",
	},
	artistName: {
		color: "#f4f4f4",
		fontSize: 14,
		fontFamily: "Montserrat_700Bold",
		textAlign: "center",
	},

	//* --------------- Caixas ---------------
	container: {
		flex: 1,
		backgroundColor: "#121212",
		gap: 20,
	},
	scrollContent: {
		padding: 20,
		paddingBottom: 40,
	},
	header: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
	},
	iconContainer: {
		flexDirection: "row",
		alignItems: "center",
		gap: 15,
	},
	pillbox: {
		flexDirection: "row",
		alignItems: "flex-start",
		marginVertical: 15,
		gap: 10,
	},
	pill: {
		backgroundColor: "#2A2A2A",
		paddingVertical: 8,
		paddingHorizontal: 20,
		borderRadius: 50,
		alignSelf: "flex-start",
	},
	recentSection: {
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-between",
	},
	recentCol: {
		flexDirection: "column",
		gap: 5,
		width: "49%",
	},
	recentBox: {
		backgroundColor: "#313131",
		borderRadius: 5,
		flexDirection: "row",
		alignItems: "center",
		maxHeight: sizeSmallImg,
	},
	scrollView: {
		marginTop: 20,
	},
	artistInfo: {
		width: sizeBigImg,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 20,
	},

	//* --------------- Imagens ---------------
	smallimg: {
		height: sizeSmallImg,
		width: sizeSmallImg,
		objectFit: "contain",
	},
	bigimg: {
		width: sizeBigImg,
		height: sizeBigImg,
		marginRight: 10,
		marginBottom: 10,
	},
	profileimg: {
		width: sizeBigImg,
		height: sizeBigImg,
		marginRight: 10,
		marginBottom: 10,
		borderRadius: "100%",
	},
});
