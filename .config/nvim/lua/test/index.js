const $ = (el) => document.querySelector(el);

const fibunacci = (n) => {
  if (n < 2) {
    return 1;
  }
  return fibunacci(n - 1) + fibunacci(n - 2);
};

console.log(() => true)
