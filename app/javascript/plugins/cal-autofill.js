const calCustomer = (calItem) => {
  const details = calItem.getElementsByClassName('cal-desc')[0].innerText;
  const regexp = /\[[^\]]*\]/g;
  const detailArray = details.match(regexp);
  const customer = detailArray[1].slice(1, -1);
  return customer
};

const calPurpose = (calItem) => {
  const details = calItem.getElementsByClassName('cal-desc')[0].innerText;
  const regexp = /\[[^\]]*\]/g;
  const detailArray = details.match(regexp);
  const purpose = detailArray[2].slice(1, -1);
  return purpose
};



const calAutofill = () => {
  const calItems = document.querySelectorAll('.items-body-content')
  calItems.forEach(calItem => {
    calItem.addEventListener('click', () => {
      document.getElementById('trip_name').value = calItem.getElementsByTagName('a')[0].innerHTML;
      document.getElementById('trip_destination').value = calItem.getElementsByClassName('cal-location')[0].innerHTML;
      document.getElementById('trip_start_date').value = calItem.getElementsByClassName('cal-start')[0].innerHTML;
      document.getElementById('trip_end_date').value = calItem.getElementsByClassName('cal-end')[0].innerHTML;
      document.getElementById('trip_customer').value = calCustomer(calItem);
      document.getElementById('trip_purpose').value = calPurpose(calItem);

    });
  })
};

export { calAutofill }
