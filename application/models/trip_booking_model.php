<?php 
class Trip_booking_model extends CI_Model {
	
	function getDriver($vehicle_id){

		$this->db->from('vehicle_drivers');
		$condition=array('vehicle_id'=>$vehicle_id,'organisation_id'=>$this->session->userdata('organisation_id'),'to_date'=>'9999-12-30');
		$this->db->where($condition);
	
		$results = $this->db->get()->result();
		if(count($results)>0){
			return $results[0]->driver_id;
		}
		return gINVALID;
	}
	function getTripBokkingDate($id){

	$this->db->from('trips');
	$condition=array('id'=>$id,'organisation_id'=>$this->session->userdata('organisation_id'));
    $this->db->where($condition);
	
    $results = $this->db->get()->result();
	if(count($results)>0){
	return $results[0]->booking_date;
	}
	}

	function getVehicle($id){

	$this->db->from('vehicles');
	$condition=array('id'=>$id,'organisation_id'=>$this->session->userdata('organisation_id'));
    $this->db->where($condition);
	
    $results = $this->db->get()->result();
	if(count($results)>0){
	return $results;
	}else{
		return false;
	}
	}

	function getDriverDetails($id){

	$this->db->from('drivers');
	$condition=array('id'=>$id,'organisation_id'=>$this->session->userdata('organisation_id'));
    $this->db->where($condition);
	
    $results = $this->db->get()->result();
	if(count($results)>0){
	return $results;
	}
	}
	function getCustomerDetails($id){

	$this->db->from('customers');
	$condition=array('id'=>$id,'organisation_id'=>$this->session->userdata('organisation_id'));
    $this->db->where($condition);
	
    $results = $this->db->get()->result();
	if(count($results)>0){
	return $results;
	}
	}

	function getTripExpenses(){
		$org_id=$this->session->userdata('organisation_id');
		$this->db->from('trip_expense_type');
    		$this->db->where( 'organisation_id', $org_id );
		//---
    		$results = $this->db->get()->result();
		if(count($results)>0){//print_r($results);
			return $results;
		}else{
			return gINVALID;
		}
	}

	function checkTripVoucherEntry($trip_id){

		$this->db->from('trip_vouchers');
    		$this->db->where('trip_id',$trip_id);
		//newly added-to be organisation based
		$org_id=$this->session->userdata('organisation_id');
		$this->db->where( 'organisation_id', $org_id );
    		$results = $this->db->get()->result();
		if(count($results)>0){//print_r($results);
			return $results;
		}else{
			return gINVALID;
		}
	}

	function checkVoucherNo($voucher_no){
		$this->db->from('trip_vouchers');
    		$this->db->where('voucher_no',$voucher_no);
    		$qry = $this->db->get();
		return ($qry->num_rows() == 1)?true:false;
	}

	function getTripVoucher($trip_id){

		$retArray = array('trip'=>false,'voucher'=>false);

		$org_id=$this->session->userdata('organisation_id');	

		$this->db->select('ORG.name as company_name ,VO.name as ownership,T.customer_id,T.customer_group_id,T.remarks,T.vehicle_model_id,T.vehicle_ac_type_id,T.driver_id,T.vehicle_id,T.guest_id,V.vehicle_ownership_types_id,T.tariff_id,T.trip_status_id,T.id as trip_id,T.booking_date,T.drop_date,T.drop_time,T.pick_up_date,T.pick_up_time,T.advance_amount,VM.name as model,V.registration_number,T.pick_up_city,T.pick_up_area,G.name as guest_name,G.mobile as guest_info,T.drop_city,T.drop_area,C.name as customer_name,C.mobile as customer_mobile,CG.name as customer_group,D.name as driver,D.mobile as driver_info,D.driver_status_id');
		$this->db->from('trips T');
		$this->db->join('vehicle_models VM','VM.id=T.vehicle_model_id','left');
		$this->db->join('vehicles V','V.id=T.vehicle_id','left');
		$this->db->join('customers G','G.id=T.guest_id','left');
		$this->db->join('customers C','C.id=T.customer_id','left');
		$this->db->join('customer_groups CG','CG.id=T.customer_group_id','left');
		$this->db->join('drivers D','D.id=T.driver_id','left');
		$this->db->join('vehicle_ownership_types VO','V.vehicle_ownership_types_id=VO.id','left');
		$this->db->join('organisations ORG','ORG.id = T.organisation_id','left');
    		$this->db->where(array('T.organisation_id'=>$org_id,'T.id'=>$trip_id));
    		$trip = $this->db->get();
		if($trip->num_rows() == 1){
			$retArray['trip'] = $trip->row();
		}

		$this->db->from('trip_vouchers');
    		$this->db->where('trip_id',$trip_id);
		//newly added-to be organisation based
		$org_id=$this->session->userdata('organisation_id');
		$this->db->where( 'organisation_id', $org_id );
    		$voucher = $this->db->get();
		if($voucher->num_rows() > 0){
			$retArray['voucher'] = $voucher->row();
		}

		return $retArray;
	}


	function getdriverPercentages(){
		$qry='SELECT name from driver_payment_percentages where organisation_id = '.$this->session->userdata('organisation_id').' order by id DESC limit 1';
	$result=$this->db->query($qry);
	$result=$result->result_array();
	if(count($result)>0){
	return $result;
	}else{
	return false;
	}
	}
	function getvehiclePercentages(){
		$qry='SELECT name from vehicle_payment_percentages where organisation_id = '.$this->session->userdata('organisation_id').' order by id DESC limit 1';
	$result=$this->db->query($qry);
	$result=$result->result_array();
	if(count($result)>0){
	return $result;
	}else{
	return false;
	}
	}

	function getPercentages()
	{
		$percentages = array();
		$qry='SELECT id,value from driver_payment_percentages where organisation_id = '.$this->session->userdata('organisation_id').' order by value DESC';
		$result = $this->db->query($qry);
		$result = $result->result_array();
		if(count($result)>0){
			$percentages['driver'] = $result;
		}

		$qry='SELECT id,value from vehicle_payment_percentages where organisation_id = '.$this->session->userdata('organisation_id').' order by value DESC';
		$result = $this->db->query($qry);
		$result = $result->result_array();
		if(count($result)>0){
			$percentages['vehicle'] = $result;
		}

		return $percentages;
	}

	function  bookTrip($data,$estimate) { //print_r($data);exit;
	$this->db->set('created', 'NOW()', FALSE);
	$this->db->insert('trips',$data);
	if($this->db->insert_id()>0){
		$id =$this->db->insert_id(); 
		if(!empty($estimate)){ 
		$estimate['trip_id']=$id;
		$estimate['organisation_id']=$this->session->userdata('organisation_id'); 
		$this->db->insert('rough_estimate',$estimate);
		}
		
		return $id;
	}else{
		return false;
	}
	 
    }	
	

	//generate new voucher for a trip
	function  generateTripVoucher($data,$tariff_id=-1,$trip_data=array()) { 
		$data['organisation_id']=$this->session->userdata('organisation_id');
		$this->db->set('created', 'NOW()', FALSE);
		$this->db->insert('trip_vouchers',$data); 
		$trip_voucher_id = $this->db->insert_id();
		
		//update trip
		$trip_id = $data['trip_id'];
		$trip_data['trip_status_id'] = TRIP_STATUS_TRIP_BILLED;	
		$trip_data['pick_up_date'] = @$data['trip_start_date'];		
		$trip_data['drop_date'] = @$data['trip_end_date'];		
		$trip_data['pick_up_time'] = @$data['trip_starting_time'];		
		$trip_data['drop_time'] = @$data['trip_ending_time'];
		
		$res=$this->updateTrip($trip_data,$trip_id);	
		if($res=true){
			return $trip_voucher_id;
		}else{
			return false;
		}
	}

	
	function  updateTripVoucher($data,$id,$tariff_id=-1,$trip_data=array()) {
		
		$this->db->where('id',$id );
		//newly added-to be organisation based
		$org_id=$this->session->userdata('organisation_id');
		$this->db->where( 'organisation_id', $org_id );
		//---
		$this->db->set('updated', 'NOW()', FALSE);
		$this->db->update("trip_vouchers",$data);
		$trip_id=$data['trip_id'];

		$trip_data['trip_status_id'] = TRIP_STATUS_TRIP_BILLED;	
		$trip_data['pick_up_date'] = @$data['trip_start_date'];		
		$trip_data['drop_date'] = @$data['trip_end_date'];	
		$trip_data['pick_up_time'] = @$data['trip_starting_time'];		
		$trip_data['drop_time'] = @$data['trip_ending_time'];
		
		
		$res=$this->updateTrip($trip_data,$trip_id);	
		return $id;
	}

	function  updateTrip($data,$id,$estimate='',$guest='') {
	$this->db->where('id',$id );
		//newly added-to be organisation based
		$org_id=$this->session->userdata('organisation_id');
		$this->db->where( 'organisation_id', $org_id ); 
		//---
	$this->db->set('updated', 'NOW()', FALSE);
	$this->db->update("trips",$data);
	if(!empty($guest)){
	$this->db->where('id',$data['guest_id'] );
	$this->db->update("customers",$guest);
	}
	if(!empty($estimate)){
	$this->db->where('trip_id',$id );
	$this->db->update("rough_estimate",$estimate);
	}
	
	
	return true;
	}

	function getDetails($conditon ='',$orderby=''){

	$this->db->from('trips');
	if($conditon!=''){
		$this->db->where($conditon);
	}
	
	if($orderby!=''){
		$this->db->order_by($orderby);
	}
 	$results = $this->db->get()->result();//return $this->db->last_query();exit;
		if(count($results)>0){
		return $results;

		}else{
			return false;
		}
	}
	
	function getTripVouchers(){
$qry='SELECT TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges,TV.delivery_no,TV.invoice_no, T.id,T.pick_up_city,T.booking_date,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON  TV.trip_id =T.id AND TV.organisation_id = '.$this->session->userdata('organisation_id').' WHERE T.organisation_id = '.$this->session->userdata('organisation_id');
	$result=$this->db->query($qry);
	$result=$result->result_array();
	if(count($result)>0){
	return $result;
	}else{
	return false;
	}

	}

	function getDriverVouchers($driver_id,$fpdate='',$tpdate=''){ //echo "heloo";exit;
			
		$qry='SELECT  TV.trip_id,TV.no_of_days,TV.trip_expense,D.salary,TV.driver_bata,TV.driver_payment_amount,TV.vehicle_payment_amount,TV.driver_trip_amount,TV.vehicle_trip_amount,TV.voucher_no,V.registration_number,VT.name as v_type,TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.night_halt_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON  TV.trip_id =T.id LEFT JOIN vehicles As V on T.vehicle_id=V.id LEFT JOIN vehicle_types As VT on T.vehicle_type_id=VT.id LEFT JOIN drivers As D on TV.driver_id=D.id WHERE TV.organisation_id = '.$this->session->userdata('organisation_id').' AND T.driver_id='.$driver_id;
		if($fpdate!=null && $tpdate!=null){ 
			$qry.=' AND T.pick_up_date BETWEEN "'.$fpdate.'" AND "'.$tpdate .'"';
		}
		if($fpdate!=null && $tpdate==null){
			$qry.=' AND T.pick_up_date= "'.$fpdate.'"';
		}
		if($fpdate==null && $tpdate!=null){
			$qry.=' AND T.drop_date= "'.$tpdate.'"';
		} 
		$result=$this->db->query($qry); //echo $this->db->last_query();exit;
		$result=$result->result_array();

		if(count($result)>0){
			return $result; 
		}else{
			$qry2='SELECT TV.trip_id,TV.no_of_days,TV.trip_expense,D.salary,TV.driver_bata,TV.driver_payment_amount,TV. vehicle_payment_amount,TV.driver_trip_amount,TV.vehicle_trip_amount,TV.voucher_no,V.registration_number,VT.name as v_type,TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON  TV.trip_id =T.id LEFT JOIN vehicles As V on T.vehicle_id=V.id LEFT JOIN vehicle_types As VT on T.vehicle_type_id=VT.id LEFT JOIN drivers As D on TV.driver_id=D.id WHERE TV.organisation_id = '.$this->session->userdata('organisation_id').' AND T.driver_id='.$driver_id;
			$result2=$this->db->query($qry2);
			$result2=$result2->result_array();
			if(count($result2)>0){ 
				return $result2; 
			}else{
				return false;
			}
	}

	}

	
	function getVehicleVouchers($vehicle_id,$fpdate='',$tpdate=''){
	$qry='SELECT C.name as customer,CG.name as company,TV.trip_expense,TV.trip_starting_time,TV.trip_ending_time,TV.voucher_no,TV. vehicle_payment_amount,TV.vehicle_trip_amount,TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON TV.trip_id =T.id LEFT JOIN customers AS C ON T.customer_id=C.id LEFT JOIN customer_groups AS CG ON T.customer_group_id=CG.id WHERE TV.organisation_id = '.$this->session->userdata('organisation_id').' AND T.vehicle_id='.$vehicle_id;
		if($fpdate!=null && $tpdate!=null){ 
		$qry.=' AND T.pick_up_date BETWEEN "'.$fpdate.'" AND "'.$tpdate .'"';
				}
		if($fpdate!=null && $tpdate==null){
		$qry.=' AND T.pick_up_date= "'.$fpdate.'"';
				}
		if($fpdate==null && $tpdate!=null){
		$qry.=' AND T.drop_date= "'.$tpdate.'"';
				}
	$result=$this->db->query($qry);
	$result=$result->result_array();  //print_r($result);exit;
	if(count($result)>0){
	return $result;
	}else{
	$qry2='SELECT C.name as customer,CG.name as company,TV.trip_expense,TV.trip_starting_time,TV.trip_ending_time,TV. vehicle_payment_amount,TV.vehicle_trip_amount,TV.voucher_no,TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON TV.trip_id =T.id LEFT JOIN customers AS C ON T.customer_id=C.id LEFT JOIN customer_groups AS CG ON T.customer_group_id=CG.id WHERE TV.organisation_id = '.$this->session->userdata('organisation_id').' AND T.vehicle_id='.$vehicle_id;
	$result2=$this->db->query($qry2);
	$result2=$result2->result_array();
	if(count($result2)>0){
	return $result2; 
	}
	else{
	return false;
	}
	}

	}
	function getCustomerVouchers($customer_id,$fpdate='',$tpdate=''){
	$qry='SELECT TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON  TV.trip_id =T.id AND TV.organisation_id = '.$this->session->userdata('organisation_id').' WHERE T.organisation_id = '.$this->session->userdata('organisation_id').' AND T.customer_id='.$customer_id;
	if($fpdate!=null && $tpdate!=null){ 
		$qry.=' AND T.pick_up_date BETWEEN "'.$fpdate.'" AND "'.$tpdate .'"';
				}
		if($fpdate!=null && $tpdate==null){
		$qry.=' AND T.pick_up_date= "'.$fpdate.'"';
				}
		if($fpdate==null && $tpdate!=null){
		$qry.=' AND T.drop_date= "'.$tpdate.'"';
				}
	$result=$this->db->query($qry);
	$result=$result->result_array();
	if(count($result)>0){
	return $result;
	}else{
	$qry2='SELECT TV.total_trip_amount,TV.start_km_reading,TV.end_km_reading,TV.end_km_reading,TV.releasing_place,TV.parking_fees,TV.toll_fees,TV.state_tax,TV.night_halt_charges,TV.fuel_extra_charges, T.id,T.pick_up_city,T.drop_city,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.tariff_id FROM trip_vouchers AS TV LEFT JOIN trips AS T ON  TV.trip_id =T.id AND TV.organisation_id = '.$this->session->userdata('organisation_id').' WHERE T.organisation_id = '.$this->session->userdata('organisation_id').' AND T.customer_id='.$customer_id;
	$result2=$this->db->query($qry2);
	$result2=$result2->result_array();
	if(count($result2)>0){
	return $result2; 
	}
	else{
	return false;
	}
	}

	}

	/* INTELLIGENCE PORTION
	function selectAvailableVehicles($data){

		$onTripVehicleQry = "SELECT T.vehicle_id FROM trips T 
		WHERE T.organisation_id = ".$this->db->escape($data['organisation_id'])." 
		AND (".$this->db->escape($data['pickupdatetime'])." BETWEEN CONCAT(T.pick_up_date, ' ', T.pick_up_time) AND CONCAT(T.drop_date, ' ', T.drop_time))
		OR (".$this->db->escape($data['dropdatetime'])." BETWEEN CONCAT(T.pick_up_date, ' ', T.pick_up_time) AND CONCAT(T.drop_date, ' ', T.drop_time))";

		//exclude selected trip vehicle
		//if(isset($data['trip_vehicle']) && $data['trip_vehicle'] > 0){
			//$onTripVehicleQry .= " AND T.vehicle_id <>".$this->db->escape($data['trip_vehicle']);
		//}
		
		$qry = "SELECT V1.id as vehicle_id, SUBSTR(V1.registration_number, -4)as registration_number,V1.vehicle_model_id,V1.vehicle_make_id 
		FROM vehicles V1 
		WHERE V1.vehicle_model_id =".$this->db->escape($data['vehicle_model'])." 
			AND V1.vehicle_ac_type_id =".$this->db->escape($data['vehicle_ac_type'])." 
			AND V1.organisation_id = ".$this->db->escape($data['organisation_id'])."
			AND V1.id NOT IN (".$onTripVehicleQry.")";

		
		$qry1 = " UNION SELECT id as vehicle_id, SUBSTR(registration_number, -4)as registration_number,vehicle_model_id,vehicle_make_id FROM vehicles
		WHERE id = ".$this->db->escape($data['trip_vehicle'])."";

		$qry.= $qry1;
		//echo $qry;exit;
			
		

		$result=$this->db->query($qry);
		$result=$result->result_array();
		if(count($result)>0){
			return $result;
		}else{
			return false;
		}

	}*/



	/*function selectAvailableVehicles($data){
	$qry='SELECT V.id as vehicle_id, V.registration_number,V.vehicle_model_id,V.vehicle_make_id FROM vehicles AS V LEFT JOIN trips T ON  V.id =T.vehicle_id AND T.organisation_id = '.$data['organisation_id'].' WHERE V.vehicle_model_id = '.$data['vehicle_model'].' AND V.vehicle_ac_type_id ='.$data['vehicle_ac_type'].' AND V.organisation_id = '.$data['organisation_id'].' AND ((T.pick_up_date IS NULL AND pick_up_time IS NULL AND T.drop_date IS NULL AND drop_time IS NULL ) OR ((CONCAT(T.pick_up_date," ", T.pick_up_time) NOT BETWEEN "'.$data['pickupdatetime'].'" AND "'.$data['dropdatetime'].'") AND (CONCAT( T.drop_date," ", T.drop_time ) NOT BETWEEN "'.$data['pickupdatetime'].'" AND "'.$data['dropdatetime'].'")))';
	$result=$this->db->query($qry);
	$result=$result->result_array();
	if(count($result)>0){
	return $result;
	}else{
	return false;
	}

	}*/

	function getVehiclesArray($condion='',$trim=False){
	$this->db->from('vehicles');
	$org_id=$this->session->userdata('organisation_id');
	$this->db->where('organisation_id',$org_id);
	if($condion!=''){
    $this->db->where($condion);
	}
    $results = $this->db->get()->result();
	
				//print_r($results);
		
			for($i=0;$i<count($results);$i++){
			if($trim){
			$values[$results[$i]->id]=SUBSTR($results[$i]->registration_number,-4);
			}else{
			$values[$results[$i]->id]=$results[$i]->registration_number;
			}
			}
			if(!empty($values)){
			return $values;
			}
			else{
			return false;
			}

	}

	function getTodaysTripsDriversDetails(){

		$qry = 'SELECT T.id,T.pick_up_date,T.pick_up_time,T.drop_date,T.drop_time,T.pick_up_city,T.drop_city,D.id as driver_id,D.name 
FROM drivers D
LEFT JOIN trips T ON  T.driver_id = D.id AND T.trip_status_id='.TRIP_STATUS_CONFIRMED.'
AND T.organisation_id = '.$this->session->userdata('organisation_id').' AND CURDATE() BETWEEN T.pick_up_date AND T.drop_date
WHERE D.organisation_id = '.$this->session->userdata('organisation_id')
;
		$result=$this->db->query($qry);
		$result=$result->result_array();
	
		if(count($result)>0){
	
			return $result;
		}else{
			return false;
		}

	}

 /*function getCustomerGroups(){
 $qry='select C.id,C.customer_group_id,CG.name from customers C left join customer_groups CG on C.customer_group_id=CG.id where C.organisation_id='.$this->session->userdata('organisation_id') ;
 $result=$this->db->query($qry);
 $results=$result->result_array(); //print_r($results);exit;
 if(count($results)>0){
	for($i=0;$i<count($results);$i++){
		$c_group[$results[$i]['id']]=$results[$i]['name'];
		}
		return $c_group;
	}else{
		return false;
	}
 }*/

	function getVoucher($id){

		$qry = $this->db->get_where('trip_vouchers',array('id'=>$id));

		return $qry->row_array();

}
	//get sms gateway url organisation base
	function get_URL($org_id){
		$qry=$this->db->select('sms_gateway_url');
		$qry=$this->db->where('id',$org_id);
		$qry=$this->db->from('organisations');
		$results = $this->db->get()->result();
		if(count($results)>0){
		return $results;
		}else{
		return false;
		}
	}
	
		//get system email organisation base
	function get_System_mail($org_id){
		$qry=$this->db->select('system_email');
		$qry=$this->db->where('id',$org_id);
		$qry=$this->db->from('organisations'); 
		$results = $this->db->get()->result();
		if(count($results)>0){
		return $results;
		}else{
		return false;
		}
	}
	
	  //get customer details as per values
	function getCustomer($cust_arry){
		if($cust_arry['group_id']!=-1){
		$qry=$this->db->select('name');
		$qry=$this->db->where('id',$cust_arry['group_id']);
		$qry=$this->db->from('customer_groups'); 
		$result = $this->db->get()->result();
		$res['group'] = $result[0]->name;
		}
		if($cust_arry['cust_id']!=-1){
		$qry=$this->db->select('name,mobile');
		$qry=$this->db->where('id',$cust_arry['cust_id']);
		$qry=$this->db->from('customers'); 
		$result = $this->db->get()->result();
		$res['customer_name'] =$result[0]->name;
		$res['customer_mob'] =$result[0]->mobile;
		}
		if($cust_arry['guest_id']!=-1){
		$qry=$this->db->select('name,mobile');
		$qry=$this->db->where('id',$cust_arry['guest_id']);
		$qry=$this->db->from('customers'); 
		$result = $this->db->get()->result();
		$res['guest_name']=$result[0]->name;
		$res['guest_mob']=$result[0]->mobile;
		}
		
		return $res;
	}
	
	function getRoughEstimate($conditon=''){ 
	$this->db->where($conditon);
	$this->db->from('rough_estimate');
	$results = $this->db->get()->result();
	return $results;
	}
	
	function get_trip($id){
	$this->db->where(array('id'=>$id));
	$this->db->from('trips');
	$results = $this->db->get()->result_array();
	return $results;
	}
}
?>
