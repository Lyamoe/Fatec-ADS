function finishDebug(state) {
	const url = new URL(window.location);
	url.searchParams.delete(state);
	window.history.replaceState({}, document.title, url);
}

const urlParams = new URLSearchParams(window.location.search);

const messages = {
	"fail=emailused": {
		message: "O email já está em uso.",
		state: "fail",
	},
	"fail=passwordsmall": {
		message: "A senha deve ter pelo menos 8 caracteres.",
		state: "fail",
	},
	"fail=passwordmismatch": {
		message: "As senhas não coincidem.",
		state: "fail",
	},
	"fail=emptyfields": {
		message: "Não deixe campos vazios.",
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

