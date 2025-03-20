const result = document.getElementById("result");
const buttons = document.querySelectorAll(".buttons button");

let currentInput = "";
let operator = "";
let firstNumber = "";

buttons.forEach(button => {
  button.addEventListener("click", () => {
    const value = button.getAttribute("data-value");

    if (!isNaN(value)) {
      
      currentInput += value;
      result.textContent = currentInput;
    } else if (["+", "-", "*", "/"].includes(value)) {
      
      if (currentInput !== "") {
        firstNumber = currentInput;
        operator = value;
        currentInput = "";
      }
    } else if (value === "=") {
      
      if (firstNumber !== "" && currentInput !== "") {
        result.textContent = eval(`${firstNumber} ${operator} ${currentInput}`);
        firstNumber = "";
        currentInput = result.textContent;
      }
    } else if (value === "C") {
     
      firstNumber = "";
      operator = "";
      currentInput = "";
      result.textContent = "0";
    }
  });
});
