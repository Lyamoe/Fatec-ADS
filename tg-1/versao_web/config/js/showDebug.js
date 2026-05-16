function finishDebug(state) {
	const url = new URL(window.location);
	url.searchParams.delete(state);
	window.history.replaceState({}, document.title, url);
}

const urlParams = new URLSearchParams(window.location.search);

const messages = {
	"success=1": {
		message: "Data sent successfully!",
		state: "success",
	},
	"fail=1": {
		message: "Server unable to find uploads folder.",
		state: "fail",
	},
	"fail=2": {
		message: "Error receiving the image. Did you select a file?",
		state: "fail",
	},
	"fail=3": {
		message: "File bigger than 10MB. Choose another one.",
		state: "fail",
	},
	"fail=4": {
		message: "Type of file not allowed. Only PNG, JPEG or GIF.",
		state: "fail",
	},
	"fail=5": {
		message: "Failed to send file into uploads folder.",
		state: "fail",
	},
	"fail=6": {
		message: "Internal failure: Database table not found.",
		state: "fail",
	},
	"fail=7": {
		message: "One or more fields are too short. At least 4 chars.",
		state: "fail",
	},
	"fail=8": {
		message: "Internal failure: Error preparing the query.",
		state: "fail",
	},
	"fail=9": {
		message: "Internal failure: Failed to save in database.",
		state: "fail",
	},
	"fail=10": {
		message: "Wrong username or password.",
		state: "fail",
	},
};

const params = new URLSearchParams(window.location.search);
for (const key in messages) {
    const [type, value] = key.split('=');
    if (params.get(type) === value) {
        alert(messages[key].message);
        finishDebug(messages[key].state);
        break;
    }
}

