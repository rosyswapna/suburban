<?php    if($this->session->userdata('dbSuccess') != '') { ?>
        <div class="success-message">
            <div class="alert alert-success alert-dismissable">
                <i class="fa fa-check"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <?php 
                echo $this->session->userdata('dbSuccess');
                $this->session->set_userdata(array('dbSuccess'=>''));
                ?>
           </div>
       </div>
       <?php    } 
if(!isset($trip_pick_date)){
$trip_pick_date='';
}
if(!isset($trip_drop_date)){
$trip_drop_date='';
}
if(!isset($customer)){
$customer='';
}
if(!isset($driver_id)){
$driver_id='';
}
if(!isset($vehicle_id)){
$vehicle_id='';
}
if(!isset($trip_status_id)){
$trip_status_id='';
}
if(!isset($customer_group_id)){
$customer_group_id='';
}
if(!isset($customer_name)){
$customer_name='';
}
$page=$this->uri->segment(4);
if($page==''){
$trip_sl_no=1;
}else{
$trip_sl_no=$page;
}
$tariffs='';
?>

<div class="trips">

<div class="box">
    <div class="box-body1">
<div class="page-outer">    
	<fieldset class="body-border">
		<legend class="body-head">Trips</legend>
		<div class="box-body table-responsive no-padding">
			
			<?php echo form_open(base_url()."organization/front-desk/trips"); ?>
			<table class="table list-trip-table no-border">
				<tbody>
					<tr>
						<!---->
					    <td>
						<?php 
						$class = 'pickupdatepicker initialize-date-picker form-control'.$input_class['trip_pick_date'];
						echo form_input(array('name'=>'trip_pick_date','class'=>$class ,'placeholder'=>'Pick up Date','value'=>$trip_pick_date)); ?></td>
					    <td><?php  
						$class = 'dropdatepicker initialize-date-picker form-control'.$input_class['trip_drop_date'];
						echo form_input(array('name'=>'trip_drop_date','class'=>'dropdatepicker initialize-date-picker form-control' ,'placeholder'=>'Drop Date','value'=>$trip_drop_date)); ?></td>
						 <td><?php 
						$class="form-control".$input_class['vehicles'];$id='vehicles';
						echo $this->form_functions->populate_dropdown('vehicles',$vehicles,$vehicle_id,$class,$id,$msg="Vehicle");?></td>
						 <td><?php 
						$class="form-control".$input_class['drivers'];$id='drivers';
						echo $this->form_functions->populate_dropdown('drivers',$drivers,$driver_id,$class,$id,$msg="Driver");?></td>
						<td><?php 
						$class="form-control".$input_class['trip_status_id']; $id='trip-status';
						echo $this->form_functions->populate_dropdown('trip_status_id',$trip_statuses,$trip_status_id,$class,$id,$msg="Trip Status");?></td>
					     <td><?php $class="form-control".$input_class['cgroups']; $id='cgroups';
						echo $this->form_functions->populate_dropdown('cgroups',$customer_groups,$customer_group_id,$class,$id,$msg="Company");?></td>
						<td><?php 
						$class =  'customer form-control'.$input_class['customer'];
						echo form_input(array('name'=>'customer','class'=>$class ,'placeholder'=>'Name','value'=>$customer_name,'id'=>'c_name')); ?></td>
						<td><?php echo form_submit("trip_search","Search","class='btn btn-primary'");
echo form_close();?></td>
					<td><?php
						if((!$this->session->userdata('driver'))&&(!$this->session->userdata('customer'))){					
						echo form_button('print-trip','Print',"class='btn btn-primary print-trip'");
						} ?></td>
						
					</tr>
				</tbody>
			</table>
		</div>
	
	<div class="msg"> <?php 
			if (isset($result)){ echo $result;} else {?></div>
		
		<div class="box-body table-responsive no-padding trips-table">
			<table class="table table-hover table-bordered">
				<tbody>
					<tr>	
						
					    <th style="width:2%">Trip ID </th>
					    <th style="width:4%">Booking Date</th>
						<!--<th style="width:15%">Customer</th>-->
					    <th style="width:4%">Pickup Date</th>
						 <th style="width:4%">Pickup Time</th>
					    
					    <th  style="width:11%">Location</th>
					    <th  style="width:11%">Guest</th>
						<!--<th style="width:11%">Visit To</th>-->
						<th style="width:11%">Called By</th>						
						<th style="width:11%">Vehicle</th>
						<th style="width:11%">Driver</th>
						 <th style="width:11%">Status</th>
						 <th style="width:13%">Action</th>
					</tr>
					<?php
					
					
					for($trip_index=0;$trip_index<count($trips);$trip_index++){ //print_r($trips);exit;
					
					
						$pickdate=$trips[$trip_index]['pick_up_date'].' '.$trips[$trip_index]['pick_up_time'];
						$dropdate=$trips[$trip_index]['drop_date']." ".$trips[$trip_index]['drop_time'];

						$date1 = date_create($pickdate);
						$date2 = date_create($dropdate);
						
						$diff= date_diff($date1, $date2);
						if($diff->d > 0 && $diff->h >= 0 && $diff->i >=1 ){
							$no_of_days=$diff->d+1;
						}else{
							$no_of_days=$diff->d;
						}
					?>
			<tr class="row_click common" style="cursor:pointer;" limited="true">
						
						<td><?php echo $trips[$trip_index]['trip_id'];?></td>
						<td><?php echo $trips[$trip_index]['booking_date'];?></td>
					   <!-- <td><?php echo $customers[$trips[$trip_index]['customer_id']].br();
						if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){
						echo '';}else{
						echo $customer_groups[$trips[$trip_index]['customer_group_id']];}?></td>-->
					    <td><?php echo $trips[$trip_index]['pick_up_date']; ?></td>
						<td><?php echo $trips[$trip_index]['pick_up_time']; ?></td>
					    
						 <td><?php if(isset($trips[$trip_index]['pick_up_city'])){
						 echo substr($trips[$trip_index]['pick_up_city'],0,10)."..";}else{
						 
						 };
									
									/*if(isset($trips[$trip_index]['drop_area'])){ echo ",".$trips[$trip_index]['drop_area'].br();}else{};*/
						 ?></td>
					  <td>
					  <?php if($trips[$trip_index]['guest_id']==gINVALID || $trips[$trip_index]['guest_id']==0){
					  echo '';}else{
					  echo $trips[$trip_index]['guest_name'].br();
					    } ?>
					  </td>
						<!-- <td><?php echo $trips[$trip_index]['drop_city'].br();
									echo $trips[$trip_index]['drop_area'];
						 ?></td>-->
					 <td><?php if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){
					 echo '';}else{
					 echo $trips[$trip_index]['customer_name'].br();
					    }
					   // if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){echo '';}else{ echo $trips[$trip_index]['customer_group'].br();
					    //}
					    //if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){echo '';}else{ echo $trips[$trip_index]['customer_mobile'];
					   // }
					    ?></td>
					    <td><?php 
					    if($trips[$trip_index]['vehicle_id']==gINVALID || $trips[$trip_index]['vehicle_id']==0){
					    echo 'Nil';}else{
					    echo $trips[$trip_index]['registration_number'].br();
					    }
					   // if($trips[$trip_index]['vehicle_model_id']==gINVALID || $trips[$trip_index]['vehicle_model_id']==0){echo '';}else{ echo $trips[$trip_index]['model'].br();
					   // }
					    /*if($trips[$trip_index]['vehicle_ownership_types_id']==gINVALID || $trips[$trip_index]['vehicle_ownership_types_id']==0){echo '';}else{ echo $trips[$trip_index]['ownership'].br();
					    }*/
					    ?></td>
					  <td><?php
						if($trips[$trip_index]['driver_id']==gINVALID || $trips[$trip_index]['driver_id']==0){
						echo 'Nil';}else{
						echo $trips[$trip_index]['driver'];
					    }
						?></td>
					    <td>
							<span class="label <?php echo $status_class[$trips[$trip_index]['trip_status_id']]; ?>"><?php echo $trip_statuses[$trips[$trip_index]['trip_status_id']];?></span> 
						
						</td>	
						
						
						<td>
						
		<?php if(count($trip_action_allowed)>0){?>
		<?php if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED || $trips[$trip_index]['trip_status_id']==TRIP_STATUS_PENDING ) { 
			
			if(in_array('edit',$trip_action_allowed)){
				if(isset($input_class) && $trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED ){
				$hide=$input_class['hide_edit'];
				}else{
				$hide=' ';
				}
				echo anchor_popup_default(base_url().'organization/front-desk/trip-booking/'.$trips[$trip_index]['trip_id'],'<span></span>',array('class'=>' fa fa-edit '.$hide.'','title'=>'Edit')).nbs(5);
				
			}
			if(in_array('proposal',$trip_action_allowed)){
			echo "<a href=".base_url().'trip/proposal/'.$trips[$trip_index]['trip_id']." class= ' fa fa-paperclip' target='_blank' title='Proposal'></a>".nbs(5); 
			
			}
			if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED && in_array('complete',$trip_action_allowed)) { 
			echo "<a href=".base_url().'trip/complete/'.$trips[$trip_index]['trip_id']."/".$this->uri->segment(4)." title='Complete' class='fa fa-caret-square-o-right complete-trip'><span vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' trip_id='".$trips[$trip_index]['trip_id']."'></span></a>"; 
			
			}
			//----for mobile sms starts
			if(in_array('send_sms',$trip_action_allowed)){
			$dbdata=array('driver_id'=>$trips[$trip_index]['driver_id'],
						  'pick_up_date'=>$trips[$trip_index]['pick_up_date'],	
						  'pick_up_time'=>$trips[$trip_index]['pick_up_time'],
						  'pick_up_city'=>$trips[$trip_index]['pick_up_city'],
						  'drop_city'=>$trips[$trip_index]['drop_city']); 
			$dbcustomer=array( 'name'=>$trips[$trip_index]['customer_name'],
						  'mob'=>$trips[$trip_index]['customer_mobile']);				
			echo nbs(5) ."<a href=".base_url().'trip_booking/SendTripConfirmation/'.urlencode(serialize($dbdata))."/".$trips[$trip_index]['trip_id']."/".urlencode(serialize($dbcustomer))."/1 title='Send SMS' class='fa fa-mobile '></a>"; 
			//----ends 
			}
			
		}else if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_TRIP_COMPLETED && in_array('new_voucher',$trip_action_allowed)){ 
			echo "<a href=".base_url().'trip/view/'.$trips[$trip_index]['trip_id']." class= ' fa fa-print' target='_blank' title='Print'></a>".nbs(5)."<span title='Voucher' class=' sp-btn fa fa-mail-forward voucher' trip_id='".$trips[$trip_index]['trip_id']."' driver_id='".$trips[$trip_index]['driver_id']."' vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' vehicle_ac_type_id='".$trips[$trip_index]['vehicle_ac_type_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' type='button' no_of_days='".$no_of_days."' pick_up_time='".$trips[$trip_index]['pick_up_time']."' pick_up_date='".$trips[$trip_index]['pick_up_date']."' drop_date='".$trips[$trip_index]['drop_date']."' new_voucher = 1 company_name='".$trips[$trip_index]['company_name']."' customer_name='".$trips[$trip_index]['customer_name']."' customer_id='".$trips[$trip_index]['customer_id']."' model='".$trips[$trip_index]['model']."' vehicle_no='".$trips[$trip_index]['registration_number']."' description='".$trips[$trip_index]['remarks']."' ></span>"; 
			
		}else if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_TRIP_BILLED && in_array('edit_voucher',$trip_action_allowed)){
			echo "<span title='Voucher' class='sp-btn fa fa-mail-forward voucher' trip_id='".$trips[$trip_index]['trip_id']."' driver_id='".$trips[$trip_index]['driver_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' type='button' no_of_days='".$no_of_days."' pick_up_time='".$trips[$trip_index]['pick_up_time']."' vehicle_ac_type_id='".$trips[$trip_index]['vehicle_ac_type_id']."' new_voucher = 0 vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' pick_up_date='".$trips[$trip_index]['pick_up_date']."' drop_date='".$trips[$trip_index]['drop_date']."' company_name='".$trips[$trip_index]['company_name']."' customer_name='".$trips[$trip_index]['customer_name']."' customer_id='".$trips[$trip_index]['customer_id']."' model='".$trips[$trip_index]['model']."' vehicle_no='".$trips[$trip_index]['registration_number']."' description='".$trips[$trip_index]['remarks']."' ></span>"; 
			} ?>
			<?php }//action buttons?>
			</td>
			
			
					</tr>
					
					<?php // hidden values?>

								<tr style="display:none;" class="hide-row common" style="cursor:pointer; " limited="false" >
									<td><?php echo $trips[$trip_index]['trip_id'];?></td>
						<td><?php echo $trips[$trip_index]['booking_date'];?></td>
					   <!-- <td><?php echo $customers[$trips[$trip_index]['customer_id']].br();
						if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){echo '';}else{ echo $customer_groups[$trips[$trip_index]['customer_group_id']];}?></td>-->
					    <td><?php echo $trips[$trip_index]['pick_up_date']; ?></td>
						<td><?php echo $trips[$trip_index]['pick_up_time']; ?></td>
					    
						 <td><?php if(isset($trips[$trip_index]['pick_up_city'])){echo $trips[$trip_index]['pick_up_city'];}else{};
									if($trips[$trip_index]['pick_up_area']!=null){ echo ",".br().$trips[$trip_index]['pick_up_area'];}else{};
									if($trips[$trip_index]['drop_city']!=null){   echo "-".br().$trips[$trip_index]['drop_city'];}else{};
									/*if(isset($trips[$trip_index]['drop_area'])){ echo ",".$trips[$trip_index]['drop_area'].br();}else{};*/
						 ?></td>
					  <td>
					  <?php if($trips[$trip_index]['guest_id']==gINVALID || $trips[$trip_index]['guest_id']==0){echo '';}else{ echo $trips[$trip_index]['guest_name'].br().$trips[$trip_index]['guest_info'];
					    } ?>
					  </td>
						<!-- <td><?php echo $trips[$trip_index]['drop_city'].br();
									echo $trips[$trip_index]['drop_area'];
						 ?></td>-->
					 <td><?php if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){
					 echo '';}else{
					 echo $trips[$trip_index]['customer_name'].br();
					    }
					    if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){
					    echo '';}else{
					    echo $trips[$trip_index]['customer_group'].br();
					    }
					    if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){
					    echo '';}else{
					    echo $trips[$trip_index]['customer_mobile'];
					    }
					    ?></td>
					    <td><?php 
					    if($trips[$trip_index]['vehicle_id']==gINVALID || $trips[$trip_index]['vehicle_id']==0){
					    echo 'Vehicle Not Allocated'.br();}else{
					    echo $trips[$trip_index]['registration_number'].br();
					    }
					    if($trips[$trip_index]['vehicle_model_id']==gINVALID || $trips[$trip_index]['vehicle_model_id']==0){
					    echo '';}else{
					    echo $trips[$trip_index]['model'].br();
					    }
					    /*if($trips[$trip_index]['vehicle_ownership_types_id']==gINVALID || $trips[$trip_index]['vehicle_ownership_types_id']==0){echo '';}else{ echo $trips[$trip_index]['ownership'].br();
					    }*/
					    ?></td>
					  <td><?php
						if($trips[$trip_index]['driver_id']==gINVALID || $trips[$trip_index]['driver_id']==0){
						echo 'Driver Not Allocated';
						}else{
						echo $trips[$trip_index]['driver'].br().$trips[$trip_index]['driver_info'];
					    }
						?></td>
					<td>
							<span class="label <?php echo $status_class[$trips[$trip_index]['trip_status_id']]; ?>"><?php echo $trip_statuses[$trips[$trip_index]['trip_status_id']];?></span> 
						
					</td>	
						
						
						<td>
				<?php if(count($trip_action_allowed)>0){?>
			<?php if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED || $trips[$trip_index]['trip_status_id']==TRIP_STATUS_PENDING ) { 
			
			if(in_array('edit',$trip_action_allowed)){
			if(isset($input_class) && $trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED ){
				$hide=$input_class['hide_edit'];
				}else{
				$hide=' ';
				}
			echo anchor_popup_default(base_url().'organization/front-desk/trip-booking/'.$trips[$trip_index]['trip_id'],'<span></span>',array('class'=>' fa fa-edit '.$hide.'','title'=>'Edit')).nbs(5);
			}
			if(in_array('proposal',$trip_action_allowed)){
			echo "<a href=".base_url().'trip/proposal/'.$trips[$trip_index]['trip_id']." class= ' fa fa-paperclip' target='_blank' title='Proposal'></a>".nbs(5); 
			}
			
			if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_CONFIRMED && in_array('new_voucher',$trip_action_allowed)) {
			echo "<a href=".base_url().'trip/complete/'.$trips[$trip_index]['trip_id']."/".$this->uri->segment(4)." title='Complete' class='fa fa-caret-square-o-right complete-trip'><span vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' trip_id='".$trips[$trip_index]['trip_id']."'></span></a>"; 
			}
			//----for mobile sms starts
			if(in_array('send_sms',$trip_action_allowed)){
			$dbdata=array('driver_id'=>$trips[$trip_index]['driver_id'],
						  'pick_up_date'=>$trips[$trip_index]['pick_up_date'],	
						  'pick_up_time'=>$trips[$trip_index]['pick_up_time'],
						  'pick_up_city'=>$trips[$trip_index]['pick_up_city'],
						  'drop_city'=>$trips[$trip_index]['drop_city']); 
			$dbcustomer=array( 'name'=>$trips[$trip_index]['customer_name'],
						  'mob'=>$trips[$trip_index]['customer_mobile']);				
			echo nbs(5) ."<a href=".base_url().'trip_booking/SendTripConfirmation/'.urlencode(serialize($dbdata))."/".$trips[$trip_index]['trip_id']."/".urlencode(serialize($dbcustomer))."/1 title='Send SMS' class='fa fa-mobile '></a>"; 
			}
			//----ends 
			
			
			}else if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_TRIP_COMPLETED && in_array('new_voucher',$trip_action_allowed)){ 
			echo "<a href=".base_url().'trip/view/'.$trips[$trip_index]['trip_id']." class= ' fa fa-print' target='_blank' title='Print'></a>".nbs(5)."<span title='Voucher' class=' sp-btn fa fa-mail-forward voucher' trip_id='".$trips[$trip_index]['trip_id']."' driver_id='".$trips[$trip_index]['driver_id']."' vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' vehicle_ac_type_id='".$trips[$trip_index]['vehicle_ac_type_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' type='button' no_of_days='".$no_of_days."' pick_up_time='".$trips[$trip_index]['pick_up_time']."' pick_up_date='".$trips[$trip_index]['pick_up_date']."' drop_date='".$trips[$trip_index]['drop_date']."' new_voucher = 1 company_name='".$trips[$trip_index]['company_name']."' customer_name='".$trips[$trip_index]['customer_name']."' customer_id='".$trips[$trip_index]['customer_id']."' model='".$trips[$trip_index]['model']."' vehicle_no='".$trips[$trip_index]['registration_number']."' description='".$trips[$trip_index]['remarks']."' ></span>"; 
			}else if($trips[$trip_index]['trip_status_id']==TRIP_STATUS_TRIP_BILLED && in_array('edit_voucher',$trip_action_allowed)){
			echo "<span title='Voucher' class='sp-btn fa fa-mail-forward voucher' trip_id='".$trips[$trip_index]['trip_id']."' driver_id='".$trips[$trip_index]['driver_id']."' tarrif_id='".$trips[$trip_index]['tariff_id']."' type='button' no_of_days='".$no_of_days."' pick_up_time='".$trips[$trip_index]['pick_up_time']."' vehicle_ac_type_id='".$trips[$trip_index]['vehicle_ac_type_id']."' new_voucher = 0 vehicle_model_id='".$trips[$trip_index]['vehicle_model_id']."' pick_up_date='".$trips[$trip_index]['pick_up_date']."' drop_date='".$trips[$trip_index]['drop_date']."' company_name='".$trips[$trip_index]['company_name']."' customer_name='".$trips[$trip_index]['customer_name']."' customer_id='".$trips[$trip_index]['customer_id']."' model='".$trips[$trip_index]['model']."' vehicle_no='".$trips[$trip_index]['registration_number']."' description='".$trips[$trip_index]['remarks']."' ></span>"; 
			} ?>
					<?php }//action buttons?>
			</td>
			
			
					</tr>
								
								
								
								
								
								
								<?php //ends hidden tr	?>
					
					<?php 
						$trip_sl_no++;
						}
					?>
				</tbody>
			</table><?php echo $page_links;?>
		</div>
		<?php } ?>
	</fieldset>
</div>

</div><!-- /.box-body -->
   
	<div class='overlay-container'>
   		<div class="overlay modal"></div>
		<div class="loading-img"></div>
		<div class="modal-body border-2-px box-shadow">
			<div class="profile-body width-80-percent-and-margin-auto height-1250-px ">
			<fieldset class="body-border">
   			 <legend class="body-head">Trip Details</legend>

				<!-- section 1 start -->
				<div class="row-source-full-100-percent-width-with-margin-8">
					<div class="div-with-20-percent-width-with-margin-10">
				
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Voucher Number','voucherno'); ?>
						   <?php echo form_input(array('name'=>'voucherno','class'=>'form-control voucher-text-box voucherno','id'=>'voucherno','placeholder'=>'Voucher No','tabindex'=>"1")); ?>			
							<span class="voucher-no-error text-red"></span>
						</div>
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Company Name','company'); ?>
						   <?php echo form_input(array('name'=>'company','class'=>'form-control voucher-text-box company','id'=>'company','placeholder'=>'Company Name','readonly'=>'true','tabindex'=>"2")); ?>			
						</div>
					</div>
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Vehicle','model'); ?>
							<?php echo form_input(array('name'=>'model','class'=>'form-control voucher-text-box model','placeholder'=>'Vehicle Model','readonly'=>'true','tabindex'=>"13")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Customer Name','customer'); ?>
						   <?php echo form_input(array('name'=>'customer','class'=>'form-control voucher-text-box customer','id'=>'customer','placeholder'=>'Customer Name','readonly'=>'true','tabindex'=>"3")); ?>			
						</div>
											
					</div>
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Vehicle No.','vehicleno'); ?>
							<?php echo form_input(array('name'=>'vehicleno','class'=>'form-control voucher-text-box vehicleno','placeholder'=>'Vehicle Number','readonly'=>'true','tabindex'=>"14")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Description','description'); ?>
						   <?php echo form_input(array('name'=>'description','class'=>'form-control voucher-text-box voucher-text-box description','id'=>'description','placeholder'=>'Description','tabindex'=>"4")); ?>			
						</div>
						
					</div>
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px"><?php
							$id="trip-tariff";
							$class="form-control voucher-text-box padding-2px";
						echo form_label('Tariff','triptariflabel'); 
						echo $this->form_functions->populate_dropdown('tariff',$tariffs='',$tariff='',$class,$id,$msg="Tariffs");?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Releasing Place','releasingplace'); ?>
							<?php echo form_input(array('name'=>'releasingplace','class'=>'form-control releasingplace voucher-text-box','placeholder'=>'Enter Releasing Place','tabindex'=>"14")); 
							?>
						</div>
						
						
					</div>
					
					
				</div>
				<!-- section 1 ends  -->
				
				<!-- section 2 start -->				
				<div class="row-source-full-100-percent-width-with-margin-8">
					
					<div class="div-with-20-percent-width-with-margin-10">
				
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Start Date','startdt'); ?>
						   <?php echo form_input(array('name'=>'startdt','class'=>'form-control initialize-date-picker-d-m-Y voucher-text-box startdt','id'=>'startdt','placeholder'=>'Start Date','tabindex'=>"5")); ?>			
							<span class="start-dt-error text-red"></span>
						</div>
						
						<div class=" form-group margin-bottom-0-px">
						   <?php echo form_label('Start KM Reading','startkm'); ?>
						   <?php echo form_input(array('name'=>'startkm','class'=>'form-control voucher-text-box startkm','id'=>'startkm','placeholder'=>'Enter Start K M','tabindex'=>"9")); ?>			
							<span class="start-km-error text-red"></span>
						</div>
					</div>
					
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('End Date','enddt'); ?>
							<?php echo form_input(array('name'=>'enddt','class'=>'form-control initialize-date-picker-d-m-Y voucher-text-box enddt','placeholder'=>'End Date','tabindex'=>"6")); ?>
							<span class="end-dt-error text-red"></span>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('End Km Reading','endkm'); ?>
							<?php echo form_input(array('name'=>'endkm','class'=>'form-control voucher-text-box endkm','placeholder'=>'Enter End KM','tabindex'=>"10")); ?>
							<span class="end-km-error text-red"></span>
						</div>
					</div>
					<div class="div-with-20-percent-width-with-margin-10">

						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Trip Starting Time','tripstartingtime'); ?>
							<?php echo form_input(array('name'=>'tripstartingtime','class'=>'form-control voucher-text-box tripstartingtime format-time','placeholder'=>'Enter Trip Starting Time','tabindex'=>"7")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Time','triptime'); ?>
							<?php echo form_input(array('name'=>'triptime','class'=>'form-control voucher-text-box triptime format-time','placeholder'=>'Total Trip Time','readonly'=>'true','tabindex'=>"11")); 
							?>
						</div>
					</div>
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Trip Ending Time','tripendingtimelabel'); ?>
							<?php echo form_input(array('name'=>'tripendingtime','class'=>'form-control voucher-text-box tripendingtime format-time','placeholder'=>'HH:MM','tabindex'=>"8")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Km Reading','totalkm'); ?>
							<?php echo form_input(array('name'=>'totalkm','class'=>'form-control voucher-text-box totalkm','placeholder'=>'Total KM','readonly'=>'true','tabindex'=>"12")); ?>
							<span class="total-km-error text-red"></span>
						</div>

					
					</div>
					
					
					<div class=" form-group margin-bottom-0-px hide-me">
						<?php echo form_label('Gariage Clossing KM','gariageclosingkm'); ?>
						<?php echo form_input(array('name'=>'garageclosingkm','class'=>'form-control voucher-text-box garageclosingkm','placeholder'=>'Enter Gariage closing km')); ?>
						<span class="garage-km-error text-red"></span>
					</div>
					<div class=" form-group margin-bottom-0-px hide-me">
						<?php echo form_label('Gariage Closing Time','gariageclosingtime'); ?>
						<?php echo form_input(array('name'=>'garageclosingtime','class'=>'form-control voucher-text-box garageclosingtime initialize-time-picker','placeholder'=>'Enter Gariage Closing Time')); 
						?>
				Trips(		<span class="garage-time-error text-red"></span>
					</div>
						
					
				</div>
				</fieldset>
				<!-- section 2 ends -->
				<fieldset class="body-border">
   			  <legend class="body-head">Trip Payment</legend>
				<!-- section 3 start -->
				<div class="row-source-full-100-percent-width-with-margin-8">
					<!-- col 1 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base KM','basekm'); ?>
							<?php echo form_input(array('name'=>'basekm','class'=>'form-control basekm voucher-text-box','placeholder'=>'Base KM','tabindex'=>"16")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Hrs','basehrs'); ?>
							<?php echo form_input(array('name'=>'basehrs','class'=>'form-control basehrs format-time voucher-text-box','placeholder'=>'Base Hours')); 
							?>
						</div>
						
					</div>
					<!-- col 2 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basekmamnt'); ?>
							<?php echo form_input(array('name'=>'basekmamount','class'=>'form-control basekmamount voucher-text-box','placeholder'=>'Base Amount','tabindex'=>"17")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basehrslabel'); ?>
							<?php echo form_input(array('name'=>'basehrsamount','class'=>'form-control basehrsamount voucher-text-box','placeholder'=>'Base Hours ')); 
							?>
						</div>
						
						
					</div>
					<!-- col 3 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional KM','adtkm'); ?>
							<?php echo form_input(array('name'=>'adtkm','class'=>'form-control adtkm voucher-text-box','placeholder'=>'Additional KM','tabindex'=>"18")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional Hrs','adthrs'); ?>
							<?php echo form_input(array('name'=>'adthrs','class'=>'form-control adthrs voucher-text-box','placeholder'=>'Additional Hrs')); 
							?>
						</div>
						
						
					</div>
					<!-- col 4 -->
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl KM Amnt','adlkmamnt'); ?>
							<?php echo form_input(array('name'=>'aditionalkmamount','class'=>'form-control aditionalkmamount voucher-text-box','placeholder'=>'Aditional Amount','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl Hr Amnt','adlhramnt'); ?>
							<?php echo form_input(array('name'=>'aditionalhramount','class'=>'form-control aditionalhramount voucher-text-box','placeholder'=>'Additional Amount','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','totkmamnt'); ?>
							<?php echo form_input(array('name'=>'totalkmamount','class'=>'form-control totalkmamount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','tothramnt'); ?>
							<?php echo form_input(array('name'=>'totalhramount','class'=>'form-control totalhramount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
					
				<!--</div>
				<!-- section 3 end -->
				
				<!--  section 4 start
				<div class="row-source-full-100-percent-width-with-margin-8">-->
					<!-- col 1 -->
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('State Tax','statetax'); ?>
							<?php echo form_input(array('name'=>'statetax','class'=>'form-control statetax voucher-text-box','placeholder'=>'Enter State Tax')); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Night Halt','nighthalt'); ?>
							<?php echo form_input(array('name'=>'nighthalt','class'=>'form-control nighthalt voucher-text-box','placeholder'=>'Enter Night Halt')); 
							?>
						</div>
						
					</div>
					<!-- col 2 -->
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Driver Bata','driverbatalabel'); ?>
							<?php echo form_input(array('name'=>'driverbata','class'=>'form-control driverbata voucher-text-box','placeholder'=>'Enter Driver Bata')); ?>
					
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Parking Fee','parking'); ?>
							<?php echo form_input(array('name'=>'parkingfee','class'=>'form-control parkingfee voucher-text-box','placeholder'=>'Enter Parking Fee')); ?>
					
						</div>
						
					</div>
					<!-- col 3 -->
					<div class="div-with-20-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Toll Fee','tollfee'); ?>
							<?php echo form_input(array('name'=>'tollfee','class'=>'form-control tollfee voucher-text-box','placeholder'=>'Enter Toll Fee')); ?>
					
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adt Fuel Charge','adtfuel'); ?>
							<?php echo form_input(array('name'=>'extrafuel','class'=>'form-control extrafuel voucher-text-box','placeholder'=>'Adt Fuel Charge')); ?>
					
						</div>
						
					</div>
					<!-- col 4 -->
					<div class="div-with-20-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','totalamount'); ?>
							<?php echo form_input(array('name'=>'totalamount','class'=>'form-control totalamount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true')); ?>
					
						</div>
						<div class=" form-group margin-bottom-0-px">
						<?php echo form_label('Total Tax','totaltax'); ?>
						<?php 
						$class="form-control taxgroup voucher-text-box";
						$tbl="taxes";
						echo $this->form_functions->populate_editable_dropdown('taxgroup',$taxes,$class,$tbl);
						echo form_input(array('name'=>'select_text','id'=>'totaltax','class'=>'form-control voucher-text-box','style'=>'display:none','trigger'=>'true'));?>	

							</div>
						
					</div>
					
					<!-- hidden -->
					<div class=" form-group margin-bottom-0-px hide-me">
						<?php echo form_label('Extra Fuel Charge','extrafuel'); ?>
						<?php echo form_input(array('name'=>'extrafuel','class'=>'form-control extrafuel voucher-text-box','placeholder'=>'Enter Extra Fuel Charge')); ?>
				
					</div>
					
					<div class=" form-group margin-bottom-0-px hide-me">
						<?php echo form_label('Addt KM Rate','adtkmamount'); ?>
						<?php echo form_input(array('name'=>'adtkmamount','class'=>'form-control adtkmamount voucher-text-box','placeholder'=>'Additional KM Amount')); 
						?>
					</div>

					<div class=" form-group margin-bottom-0-px hide-me">
						<?php echo form_label('KM/HRs','kmhr'); ?>
						<?php echo form_input(array('name'=>'kmhr','class'=>'form-control kmhr voucher-text-box','placeholder'=>'KM/HRs')); 
						?>
					</div>

				</div>
				<!-- second section ends -->
				</fieldset>
				<fieldset class="body-border">
   					 <legend class="body-head">Driver Payment</legend>
						<div class="row-source-full-100-percent-width-with-margin-8">
					<!-- col 1 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base KM','basekm'); ?>
							<?php echo form_input(array('name'=>'basekm','class'=>'form-control basekm voucher-text-box','placeholder'=>'Base KM','tabindex'=>"16")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Hrs','basehrs'); ?>
							<?php echo form_input(array('name'=>'basehrs','class'=>'form-control basehrs format-time voucher-text-box','placeholder'=>'Base Hours')); 
							?>
						</div>
						
					</div>
					<!-- col 2 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basekmant'); ?>
							<?php echo form_input(array('name'=>'basekmamount','class'=>'form-control basekmamount voucher-text-box','placeholder'=>'Base Amount','tabindex'=>"17")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basehrslabel'); ?>
							<?php echo form_input(array('name'=>'basehrsamount','class'=>'form-control basehrsamount voucher-text-box','placeholder'=>'Base Hours ')); 
							?>
						</div>
						
						
					</div>
					<!-- col 3 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional KM','adtkm'); ?>
							<?php echo form_input(array('name'=>'adtkm','class'=>'form-control adtkm voucher-text-box','placeholder'=>'Additional KM','tabindex'=>"18")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional Hrs','adthrs'); ?>
							<?php echo form_input(array('name'=>'adthrs','class'=>'form-control adthrs voucher-text-box','placeholder'=>'Additional Hrs')); 
							?>
						</div>
						
						
					</div>
					<!-- col 4 -->
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl KM Amnt','adlkmamnt'); ?>
							<?php echo form_input(array('name'=>'aditionalkmamount','class'=>'form-control aditionalkmamount voucher-text-box','placeholder'=>'Aditional Amount','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl Hr Amnt','adlhramnt'); ?>
							<?php echo form_input(array('name'=>'aditionalhramount','class'=>'form-control aditionalhramount voucher-text-box','placeholder'=>'Additional Amount','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','totkmamnt'); ?>
							<?php echo form_input(array('name'=>'totaldriverkmamount','class'=>'form-control totaldriverkmamount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','tothramnt'); ?>
							<?php echo form_input(array('name'=>'totaldriverhramount','class'=>'form-control totaldriverhramount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
				</div>
				
				</fieldset>
				<fieldset class="body-border">
   			 		<legend class="body-head">Vehicle Payment</legend>
						<div class="row-source-full-100-percent-width-with-margin-8">
					<!-- col 1 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base KM','basekm'); ?>
							<?php echo form_input(array('name'=>'basekm','class'=>'form-control basekm voucher-text-box','placeholder'=>'Base KM','tabindex'=>"16")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Hrs','basehrs'); ?>
							<?php echo form_input(array('name'=>'basehrs','class'=>'form-control basehrs format-time voucher-text-box','placeholder'=>'Base Hours')); 
							?>
						</div>
						
					</div>
					<!-- col 2 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basekmamnt'); ?>
							<?php echo form_input(array('name'=>'basekmamount','class'=>'form-control basekmamount voucher-text-box','placeholder'=>'Base Amount','tabindex'=>"17")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Base Amount','basehrslabel'); ?>
							<?php echo form_input(array('name'=>'basehrsamount','class'=>'form-control basehrsamount voucher-text-box','placeholder'=>'Base Hours ')); 
							?>
						</div>
						
						
					</div>
					<!-- col 3 -->
					<div class="div-with-15-percent-width-with-margin-10">
						
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional KM','adtkmlabel'); ?>
							<?php echo form_input(array('name'=>'adtkm','class'=>'form-control adtkm voucher-text-box','placeholder'=>'Additional KM','tabindex'=>"18")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Additional Hrs','adthrslabel'); ?>
							<?php echo form_input(array('name'=>'adthrs','class'=>'form-control adthrs voucher-text-box','placeholder'=>'Additional Hrs')); 
							?>
						</div>
						
						
					</div>
					<!-- col 4 -->
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl KM Amnt','adlkmamnt'); ?>
							<?php echo form_input(array('name'=>'aditionalkmamount','class'=>'form-control aditionalkmamount voucher-text-box','placeholder'=>'Aditional Amount','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Adl Hr Amnt','adlhramnt'); ?>
							<?php echo form_input(array('name'=>'aditionalhramount','class'=>'form-control aditionalhramount voucher-text-box','placeholder'=>'Additional Amount','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('No of Days','daysno'); ?>
							<?php echo form_input(array('name'=>'daysno','class'=>'form-control daysno voucher-text-box','placeholder'=>'No Of Days','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						
						
					</div>
					<div class="div-with-15-percent-width-with-margin-10">
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','totkmamnt'); ?>
							<?php echo form_input(array('name'=>'totalvehiclekmamount','class'=>'form-control totalvehiclekmamount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"15")); 
							?>
						</div>
						<div class=" form-group margin-bottom-0-px">
							<?php echo form_label('Total Amount','tothramnt'); ?>
							<?php echo form_input(array('name'=>'totalvehiclehramount','class'=>'form-control totalvehiclehramount voucher-text-box','placeholder'=>'Total Amount','readonly'=>'true','tabindex'=>"19")); 
							?>
						</div>
						
						
					</div>
					
				</div>
				
				</fieldset>
				<!-- controls  -->
				<div class="row-source-full-100-percent-width-with-margin-8">
			   		<div class="box-footer">
					<?php 
						echo form_submit("trip-voucher-save","SAVE","class='btn btn-success trip-voucher-save'").nbs(5);  ?>
					<button class='btn btn-danger modal-close' type='button'>CLOSE</button>  
					</div>
				</div>
			
			
		</div><!-- body -->

		</div>
	</div>
    <!-- end loading -->
</div>	
</div>

