<?php 
class Customers_model extends CI_Model {
	//newly added- to be organisation based---
	var $organisation_id;
	public function __construct()
		{ 
		parent::__construct();
		$this->organisation_id=$this->session->userdata('organisation_id');
		

		}
	//------
	
	// to get customer details corresponding to the values provided 
	public function getCustomerDetails($data){ 
	//newly added- to be organisation based---
	$data['organisation_id']=$this->organisation_id;
	//----
	$this->db->from('customers');
	
	if($data!=''){
		$this->db->where($data);
	}
	return $this->db->get()->result_array();
	
	}

	//to add customer details with unique mobile number
	public function addCustomer($data){ 
		$data['organisation_id']=$this->session->userdata('organisation_id');
		$data['user_id']=$this->session->userdata('id');
		
 		if($data['mobile']!=''){
		$condition['mobile']=$data['mobile'];
		//newly added- to be organisation based---
		//$condition['organisation_id']=$this->session->userdata('organisation_id');
		//----
		$res=$this->getCustomerDetails($condition); 
		if(count($res)==0){
			$this->db->set('created', 'NOW()', FALSE);
			$this->db->insert('customers',$data);
			$insert_id=$this->db->insert_id();

			if($insert_id > 0){
				return $insert_id;
			}else{
				return false;
			}
		}else{
			return $res[0]['id'];
		}
	
	}else{
			$this->db->set('created', 'NOW()', FALSE);
			$this->db->insert('customers',$data);
			$insert_id=$this->db->insert_id();

			if($insert_id > 0){
				return $insert_id;
			}else{
				return false;
			}

	}
	}
	
	public function getCurrentStatuses($id){ 
	$qry='SELECT * FROM trips WHERE CONCAT(pick_up_date," ",pick_up_time) <= "'.date("Y-m-d H:i").'" AND CONCAT(drop_date," ",drop_time) >= "'.date("Y-m-d H:i").'" AND customer_id="'.$id.'" AND organisation_id = '.$this->session->userdata('organisation_id').' AND trip_status_id='.TRIP_STATUS_CONFIRMED;
	$results=$this->db->query($qry);
	$results=$results->result_array();
	if(count($results)>0){
	
		return $results;
	}else{
		return false;
	}
	}
	
	function  updateCustomers($data,$id) {
	$this->db->where('id',$id );
	$this->db->set('updated', 'NOW()', FALSE);
	$this->db->update("customers",$data);
	return true;
	}
	
	public function getArray(){
		//newly added- to be organisation based----
		$qry=$this->db->where('organisation_id',$this->organisation_id);
		//---
		$qry=$this->db->get('customers');
		$count=$qry->num_rows();
		$l= $qry->result_array();
		
			for($i=0;$i<$count;$i++){
			$values[$l[$i]['id']]=$l[$i]['name'];
			}
			if(!empty($values)){
			return $values;
			}
			else{
			return false;
			}
	}
	public function getAllIds(){

	$qry=$this->db->select('id');
	$this->db->from('customers');
	//newly added- to be organisation based----
	$this->db->where('organisation_id',$this->organisation_id);
	//---
	$qry=$this->db->get();
	$count=$qry->num_rows();
	$result= $qry->result_array();
	for($i=0;$i<$count;$i++){
			$values[$result[$i]['id']]=$result[$i]['id'];
			}
	
	return $values;

	
	
	}
	public function getCustomersById($c_id){
	$qry='select id,name,mobile,email from customers where customer_group_id='.$c_id.' and organisation_id='.$this->session->userdata('organisation_id');
	$result=$this->db->query($qry);
	$result=$result->result_array();
	return $result;
	
	}
}
?>
