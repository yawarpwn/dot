const variableNousado = "";

function createFn() {
  console.log("function created");

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

//disable
//T
