import * as BackgroundFetch from "expo-background-fetch";

export const BACKGROUND_FETCH_TASK = "BACKGROUND_TASK_UPDATE_PRIORITIES";
export const TASKS_STORAGE_KEY = "USER_TASKS_LIST";

export async function registerBackgroundFetchAsync() {
	return BackgroundFetch.registerTaskAsync(BACKGROUND_FETCH_TASK, {
		minimumInterval: 60 * 60 * 24, // 24 hours (in seconds)
		stopOnTerminate: false, // Keep running if app is closed
		startOnBoot: true, // Start task when device turns on
	});
}
