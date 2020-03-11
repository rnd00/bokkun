import "bootstrap";
import { toggleReceipt } from '../receiptEmployer/receipt-ticket';
import { employeeNavbarToggle } from '../employeeNavbar/toggle';
import '../plugins/flatpickr'
import { autoSubmitPhoto } from '../plugins/submit_photo';

// Select2 requirements
import {initSelect2} from '../plugins/init_select2'
import 'select2/dist/css/select2.css';
// Collapse toggle
import {collapseToggle} from '../plugins/collapse_toggle'
// GCal Autofil
import {calAutofill} from '../plugins/cal-autofill'

initSelect2();
if(document.querySelector("#employeeNavbarToggle")){
  employeeNavbarToggle();
}
toggleReceipt();
if(document.getElementById("collapse-link")){
  collapseToggle();
}

if(document.querySelectorAll('.items-body-content')){
calAutofill();
}

autoSubmitPhoto();
