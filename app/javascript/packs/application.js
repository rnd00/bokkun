import "bootstrap";
import { toggleReceipt } from '../receiptEmployer/receipt-ticket';
import { employeeNavbarToggle } from '../employeeNavbar/toggle';

// Select2 requirements
import {initSelect2} from '../plugins/init_select2'
import 'select2/dist/css/select2.css';


initSelect2();

employeeNavbarToggle();


toggleReceipt();
