<?php 
class Sms{

function sendSms($phone,$message,$flag=''){


//$url="http://enterprise.smsgupshup.com/GatewayAPI/rest?method=SendMessage&send_to=".$phone."&msg=".$message."&msg_type=TEXT&userid=2000136385&auth_scheme=plain&password=sms13k&v=1.1&format=text";
//---original gateway---
//$url="http://india.ebensms.com/api/v1/sms/single.json?token=2bbbe622-63e4-11e4-8f8e-a1bba6839208&msisdn=".$phone."&text=".urlencode($message)."&sender_id=CncCab&route=TRANS";
		
		$CI = & get_instance();
		$CI->load->model('trip_booking_model');
		$org_id=$CI->session->userdata('organisation_id'); 
		$url_arry=$CI->trip_booking_model->get_URL($org_id); 
		$url=$url_arry[0]->sms_gateway_url;
		if($phone!='' && $message!=''){
		$old_val=array('".$phone."','".$message."');
		$new_val=array($phone,urlencode($message));
		$url=str_replace($old_val,$new_val,$url);
		}
		if($url==false){
		$url='';
		}
		echo $url.br();exit;
		$ch=curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$output=curl_exec($ch);
		curl_close($ch);                                
		return $output;

}

}
?>
