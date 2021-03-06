<?php
/**********************************************************************
    Copyright (C) FrontAccounting, LLC.
	Released under the terms of the GNU General Public License, GPL, 
	as published by the Free Software Foundation, either version 3 
	of the License, or (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the License here <http://www.gnu.org/licenses/gpl-3.0.html>.
***********************************************************************/
$page_security = 'SA_SALESINVOICE';
$path_to_root = "../..";
include($path_to_root . "/includes/db_pager.inc");
//include($path_to_root . "/includes/db_pager_with_array.inc");
include($path_to_root . "/includes/session.inc");

include($path_to_root . "/sales/includes/sales_ui.inc");
include_once($path_to_root . "/reporting/includes/reporting.inc");

$js = "";
if ($use_popup_windows)
	$js .= get_js_open_window(900, 600);
if ($use_date_picker)
	$js .= get_js_date_picker();

if (isset($_GET['OutstandingOnly']) && ($_GET['OutstandingOnly'] == true))
{
	$_POST['OutstandingOnly'] = true;
	//page(_($help_context = "Search Not Invoiced Trip Deliveries"), false, false, "", $js);
	page(_($help_context = "Trip Deliveries"), false, false, "", $js);
}
else
{
	$_POST['OutstandingOnly'] = false;
	page(_($help_context = "Search All Trip Deliveries"), false, false, "", $js);
}

if (isset($_GET['selected_customer']))
{
	$selected_customer = $_GET['selected_customer'];
}
elseif (isset($_POST['selected_customer']))
{
	$selected_customer = $_POST['selected_customer'];
}
else
	$selected_customer = -1;

if (isset($_POST['BatchInvoice']))
{
	// checking batch integrity
    $del_count = 0;
    foreach($_POST['Sel_'] as $delivery => $branch) {
	  	$checkbox = 'Sel_'.$delivery;
	  	if (check_value($checkbox))	{
	    		if (!$del_count) {
				$del_branch = $branch;
	    		}
	    		else {
				if ($del_branch != $branch)	{
		    		$del_count=0;
		    		break;
				}
	    		}
	    		$selected[] = $delivery;
			$trip_voucher[] = get_trip_voucher_id_with_delivery_no($delivery);
	    		$del_count++;
	  	}

		//get voucher numbers for selected deliveries
		
    }

    if (!$del_count) {
		display_error(_('For batch invoicing you should
		    select at least one delivery. All items must be dispatched to
		    the same company and tax group.'));
    } else {
		$_SESSION['DeliveryBatch'] = $selected;
		$_SESSION['TripVoucherBatch'] = $trip_voucher;
		meta_forward($path_to_root . '/sales/customer_invoice.php','BatchInvoice=Yes');
    }
}

//-----------------------------------------------------------------------------------
if (get_post('_DeliveryNumber_changed')) 
{
	$disable = get_post('DeliveryNumber') !== '';
	$Ajax->addDisable(true, 'TripId', $disable);
	$Ajax->addDisable(true, 'CustomerGroup', $disable);
	$Ajax->addDisable(true, 'Customer', $disable);
	$Ajax->addDisable(true, 'DeliveryAfterDate', $disable);
	$Ajax->addDisable(true, 'DeliveryToDate', $disable);
		
	// if search is not empty rewrite table
	if ($disable) {
		$Ajax->addFocus(true, 'DeliveryNumber');
	} else
		$Ajax->addFocus(true, 'TripId');
	$Ajax->activate('deliveries_tbl');
}

if (get_post('_TripId_changed')) 
{
	$disable = get_post('TripId') !== '';
	$Ajax->addDisable(true, 'CustomerGroup', $disable);
	$Ajax->addDisable(true, 'Customer', $disable);
	$Ajax->addDisable(true, 'DeliveryNumber', $disable);
	$Ajax->addDisable(true, 'DeliveryAfterDate', $disable);
	$Ajax->addDisable(true, 'DeliveryToDate', $disable);
		
	// if search is not empty rewrite table
	if ($disable) {
		$Ajax->addFocus(true, 'TripId');
	} else
		$Ajax->addFocus(true, 'DeliveryAfterDate');
	$Ajax->activate('deliveries_tbl');
}

//-----------------------------------------------------------------------------------

start_form(false, false, $_SERVER['PHP_SELF'] ."?OutstandingOnly=".$_POST['OutstandingOnly']);

start_table_left(TABLESTYLE_NOBORDER);

	start_row();
		ref_cells(_("#:"), 'DeliveryNumber', '',null, '', true,5);
		date_cells(_("from:"), 'DeliveryAfterDate', '', null, -30);
		taxi_customer_group_list_cells(_("Customer Group:"), 'CustomerGroup', null, true, true);
		
		null_date_cells(_("Trip Pickup Date:"), 'PickupDate', '', null);
		submit_cells('SearchOrders', _("Search"),'',_('Select documents'), 'default');
	end_row();
	start_row();
		ref_cells(_("Trip Id:"), 'TripId', '',null, '', true,5);
		date_cells(_("to:"), 'DeliveryToDate', '', null, 1);
		taxi_customer_list_cells(_("Customer:"), 'Customer', null, true, true);
		null_date_cells(_("Trip Drop Date:"), 'DropDate', '', null);
		
	end_row();

//start_row();








//locations_list_cells(_("Location:"), 'StockLocation', null, true);
hidden('StockLocation');


//stock_items_list_cells(_("Item:"), 'SelectStockFromList', null, true);



hidden('OutstandingOnly', $_POST['OutstandingOnly']);

//end_row();

end_table_left(1);br();
//---------------------------------------------------------------------------------------------

if (isset($_POST['SelectStockFromList']) && ($_POST['SelectStockFromList'] != "") &&
	($_POST['SelectStockFromList'] != ALL_TEXT))
{
 	$selected_stock_item = $_POST['SelectStockFromList'];
}
else
{
	$selected_stock_item = null;
}

//---------------------------------------------------------------------------------------------
function trans_view($trans, $trans_no)
{
	//return get_customer_trans_view_str(ST_CUSTDELIVERY, $trans['trans_no']);
	return $trans['trans_no'];
}

function batch_checkbox($row)
{
	$name = "Sel_" .$row['trans_no'];
	return $row['Done'] ? '' :
		"<input type='checkbox' name='$name' value='1' >"
// add also trans_no => branch code for checking after 'Batch' submit
	 ."<input name='Sel_[".$row['trans_no']."]' type='hidden' value='"
	 .$row['branch_code']."_".$row['tax_group_id']."'>\n";
}

function edit_link($row)
{
	return $row["Outstanding"]==0 ? '' :
		pager_link(_('Edit'), "/sales/customer_delivery.php?ModifyDelivery="
			.$row['trans_no'], ICON_EDIT);
}

function prt_link($row)
{
	return print_document_link($row['trans_no'], _("Print"), true, ST_CUSTDELIVERY, ICON_PRINT);
}

function invoice_link($row)
{
	return $row["Outstanding"]==0 ? '' :
		pager_link(_('Invoice'), "/sales/customer_invoice.php?DeliveryNumber=" 
			.$row['trans_no'], ICON_DOC);
}

function check_overdue($row)
{
   	return date1_greater_date2(Today(), sql2date($row["due_date"])) && 
			$row["Outstanding"]!=0;
}
//------------------------------------------------------------------------------------------------
$sql = get_sql_for_sales_deliveries_view($selected_customer, $selected_stock_item);

$cols = array(
		_("Delivery #") => array('fun'=>'trans_view'), 
		'branch_code' => 'skip',
		_("Company"), 
		_("Customer") => array('ord'=>''),
		_("Guest") => array('ord'=>''),		
		_("Trip Id"),
		_("Voucher"), 
		_("Trip Date"), 
		_("Delivery Date") => array('type'=>'date', 'ord'=>''),
		_("Amount") => array('type'=>'amount', 'ord'=>''),
		
		submit('BatchInvoice',_("Batch"), false, _("Batch Invoicing")) 
			=> array('insert'=>true, 'fun'=>'batch_checkbox', 'align'=>'center'),
		array('insert'=>true, 'fun'=>'invoice_link')
);

//-----------------------------------------------------------------------------------
if (isset($_SESSION['Batch']))
{
    foreach($_SESSION['Batch'] as $trans=>$del)
    	unset($_SESSION['Batch'][$trans]);
    unset($_SESSION['Batch']);
}




$table =& new_db_pager('deliveries_tbl', $sql, $cols);
$table->set_marker('check_overdue', _("Marked items are overdue."));

$table->width = "100%";

display_db_pager($table);


end_form();
end_page();

?>

