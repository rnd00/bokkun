var activateButton = () => {
  var receiptTotal = document.getElementById("receipt-total");
  var checkButton = document.getElementById("check-button");
  if (receiptTotal.innerText !== "￥0") {
    checkButton.classList.add("yellow-halo");
    checkButton.firstElementChild.classList.add("my-float-check");
    checkButton.classList.remove("disabled-halo");
    checkButton.firstElementChild.classList.remove("disabled-check");
    console.log(receiptTotal.innerText)
    console.log(receiptTotal.innerText !== "￥0")
  } else {
    checkButton.classList.remove("yellow-halo");
    checkButton.firstElementChild.classList.remove("my-float-check");
    checkButton.classList.add("disabled-halo");
    checkButton.firstElementChild.classList.add("disabled-check");
  }
}

export { activateButton }
