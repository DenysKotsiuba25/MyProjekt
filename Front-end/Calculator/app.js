const result = document.getElementById("result");
const buttons = document.querySelectorAll(".buttons button");

let currentInput = "";
let operator = "";
let firstNumber = "";
let isResultDisplayed = false;  

buttons.forEach(button => {
  button.addEventListener("click", () => {
    const value = button.getAttribute("data-value");

    if (!isNaN(value)) {
      
      if (isResultDisplayed) {
        currentInput = value;
        result.textContent = currentInput;
        isResultDisplayed = false;  
      } else {
        currentInput += value;
        result.textContent = currentInput;
      }
    } else if (["+", "-", "*", "/"].includes(value)) {
      
      if (currentInput !== "") {
        firstNumber = currentInput;
        operator = value;
        currentInput = "";
      }
      isResultDisplayed = false;  
    } else if (value === "=") {
       
      if (firstNumber !== "" && currentInput !== "") {
        result.textContent = eval(`${firstNumber} ${operator} ${currentInput}`);
        firstNumber = "";
        currentInput = result.textContent;
        isResultDisplayed = true;  
      }
    } else if (value === "C") {
      
      firstNumber = "";
      operator = "";
      currentInput = "";
      result.textContent = "0";
      isResultDisplayed = false;  
    }
  });
});
