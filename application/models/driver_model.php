<?php
class Driver_model extends CI_Model {

	public function addDriverdetails($data,$login=false){
		
		$org_id=$this->session->userdata('organisation_id');
			if($org_id){ 
				$login_id = $this->getLoginId($data,$login);
				$data['login_id'] = $login_id;
				$this->db->set('created', 'NOW()', FALSE);
				$this->db->insert('drivers',$data);
				$driver = $this->db->insert_id();
		if($driver > 0){ //echo "inserted";exit;
			return $driver;
		}else{
			$this->db->delete('users', array('id' => $login_id)); //echo "deleted";exit;
			return false;
		}
			
		
		}else{
			return false;
		}
	}

	//add new vehicle from trip booiking
	public function addDriverFromTripBooking($value = null){

		if($value !=null){
			$data['name'] = $value;
			$data['organisation_id']=$this->session->userdata('organisation_id');
			$data['user_id']=$this->session->userdata('id');
			$this->db->set('created', 'NOW()', FALSE);
			$this->db->insert('drivers',$data);
			return mysql_insert_id();
		}
		return -1;
	}
	
	
	
	public function getLoginId($data,$login)
	{
		$this->load->model('organization_model');
			if($login['username']!='' && $login['password'] != ''){
				$login_id = $this->organization_model->insertUser($data['name'],'',$data['present_address'],$login['username'],$login['password'],$data['email'],$data['mobile'],DRIVER);
			}else{
				$login_id = 0;
			}
		return $login_id;
	}

	public function getDriverDetails($data){ 
		
	$this->db->from('customers');
	$this->db->where($data);
	return $this->db->get()->result_array();
	
	}
	public function getCurrentStatuses($id){ 
	$qry='SELECT * FROM trips WHERE CONCAT(pick_up_date," ",pick_up_time) <= "'.date("Y-m-d H:i").'" AND CONCAT(drop_date," ",drop_time) >= "'.date("Y-m-d H:i").'" AND driver_id="'.$id.'" AND organisation_id = '.$this->session->userdata('organisation_id').' AND trip_status_id='.TRIP_STATUS_CONFIRMED;
	$results=$this->db->query($qry);
	$results=$results->result_array();
	if(count($results)>0){
	
		return $results;
	}else{
		return false;
	}
	}

	public function getDrivers(){ 
	$qry='SELECT D.name,D.id,D.mobile,VD.from_date,VD.to_date,VD.driver_id,VD.vehicle_id FROM drivers AS D LEFT JOIN vehicle_drivers AS VD ON  D.id =VD.driver_id AND D.organisation_id = '.$this->session->userdata('organisation_id').' WHERE VD.organisation_id = '.$this->session->userdata('organisation_id').' AND VD.to_date="9999-12-30"';
	$results=$this->db->query($qry);
	$results=$results->result_array();
	if(count($results)>0){
	for($i=0;$i<count($results);$i++){
		$drivers[$results[$i]['vehicle_id']]['driver_name']=$results[$i]['name'];
		$drivers[$results[$i]['vehicle_id']]['mobile']=$results[$i]['mobile'];
		$drivers[$results[$i]['vehicle_id']]['from_date']=$results[$i]['from_date'];

		}
		return $drivers;
	}else{
		return false;
	}
	}

	function getDriversArray($condion=''){
	$this->db->from('drivers');
	$this->db->where('organisation_id',$this->session->userdata('organisation_id'));
	if($condion!=''){
    $this->db->where($condion);
	}
	$qry=$this->db->order_by("name", "Asc"); 
    $results = $this->db->get()->result();
	

		for($i=0;$i<count($results);$i++){
		$values[$results[$i]->id]=$results[$i]->name;
		}
		if(!empty($values)){
		return $values;
		}
		else{
		return false;
		}

	}

	public function UpdateDriverdetails($data,$id,$login='',$flag=''){ 
		
		$qry=$this->db->where('id',$id );
		$qry=$this->db->get("drivers");
		
		if(count($qry)>0){
					
			$login_id=$qry->row()->login_id; 
		}else{
			$login_id=0;
		}
				
		if($login_id > 0){//user exists
			if($flag==0){
				$login['password'] = md5($login['password']);
			}
				$this->db->set('updated', 'NOW()', FALSE);
				$this->db->where('id',$login_id );
				$this->db->update("users",$login);
		}else{//new user
				$login_id = $this->getLoginId($data,$login);
		}		
	
	$arry=array('id'=>$id,'organisation_id'=>$data['organisation_id']);
	$this->db->set('login_id', $login_id);
	$this->db->set('updated', 'NOW()', FALSE);
	$qry=$this->db->where($arry);
	$qry=$this->db->update("drivers",$data);
	
	return true;
	}

	



}?>
