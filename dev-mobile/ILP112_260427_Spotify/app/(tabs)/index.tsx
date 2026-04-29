import {
  Montserrat_400Regular,
  Montserrat_700Bold,
  useFonts,
} from "@expo-google-fonts/montserrat";
import { Feather, MaterialCommunityIcons } from "@expo/vector-icons";
import React from "react";
import {
  Image,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  ScrollView,
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
            <View style={styles.bigimg}>
              <Text>Item 2</Text>
            </View>
            <View style={styles.bigimg}>
              <Text>Item 3</Text>
            </View>
            <View style={styles.bigimg}>
              <Text>Item 4</Text>
            </View>
          </ScrollView>
        </View>
      </SafeAreaView>
    </SafeAreaProvider>
  );

  {
    /* <Image
                style={styles.smallimg}
                source={{
                  uri: 'https://reactnative.dev/img/tiny_logo.png',
                }}
              /> */
  }
}

{
  /* //* --------------------------------------- */
  /* //* -------------- STYLESHEET ------------- */
  /* //* --------------------------------------- */
}

const styles = StyleSheet.create({
  //* --------------- Textos ---------------
  heading1: {
    fontSize: 22,
    fontWeight: "bold",
    color: "white",
    fontFamily: "Montserrat_700Bold",
    marginTop: 30,
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
    margin: 5,
    fontFamily: "Montserrat_400Regular",
  },

  //* --------------- Caixas ---------------
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: "#121212",
    gap: 20,
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
  },
  scrollView: {
    marginTop: 20,
  },

  //* --------------- Imagens ---------------
  smallimg: {
    height: 50,
    width: 50,
    objectFit: "cover",
  },
  bigimg: {
    width: 150,
    height: 150,
    marginRight: 10,
    marginBottom: 10,
    backgroundColor: "skyblue",
  },
});
