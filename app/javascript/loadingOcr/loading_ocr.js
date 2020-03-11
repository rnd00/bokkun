const submitButton = document.querySelector(".submit-button")
  const form = document.querySelector("#new_receipt")
  if (submitButton) {
    submitButton.addEventListener('click', (e) => {
      console.log(submitButton);
      submitButton.innerHTML = ""
      submitButton.insertAdjacentHTML("afterbegin"," <i class='fas fa-circle-notch fa-spin'></i> Reading the receipt")
      console.log("changed")
      e.preventDefault();
      form.submit();
    });
  };

export { submitButton };
