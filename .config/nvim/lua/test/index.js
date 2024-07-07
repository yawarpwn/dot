const variableNousado = "";

function createFn() {
  console.log("function created");

  const print = () => "hllll";

  const logo = () => {
    console.log(window);
  };
}

const obj = {
  name: "tree",
  getName() {
    return this.name;
  },
};

const $ = (element) => document.querySelector(element);
const $main = $("#main");

const txt = "ney txt";

const getText = () => txt;
