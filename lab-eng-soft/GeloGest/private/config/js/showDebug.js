function finishDebug(state) {
	const url = new URL(window.location);
	url.searchParams.delete(state);
	window.history.replaceState({}, document.title, url);
}

const urlParams = new URLSearchParams(window.location.search);

const messages = {
	"fail=1": {
		message: "Nome de usuário ou senha incorretos.",
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

