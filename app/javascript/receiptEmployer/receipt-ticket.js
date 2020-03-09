const receipts = document.querySelectorAll('.receipt');

receipts.forEach(receipt => {
  const button = receipt.querySelector('button');
  button.addEventListener('click', () =>{
    receipt.classList.toggle('active');

    if(receipt.classList.contains('active')) {
      button.innerHTML = 'Less info';
    } else {
      button.innerHTML = 'More info';
    }
  });
})


