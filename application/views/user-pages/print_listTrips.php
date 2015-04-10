<?php
set_time_limit(0);
header("Content-type: application/vnd.ms-excel");
header("Content-Disposition: attachment; filename=trips.xls");
header("Cache-Control: cache, must-revalidate");
header("Pragma: public");
?>
			<table class="table table-hover table-bordered">
				<tbody>
					<tr><?php if(isset($msg)){
					echo 'No Results Found';
					}
					else {?>	
						
					    <th style="width:2%">Trip ID </th>
					    <th style="width:4%">Booking Date</th>
					    <th style="width:4%">Booking Time</th>
					    <th style="width:4%">Booking Source</th>
					    <th style="width:4%">Pickup Date</th>
						 <th style="width:4%">Pickup Time</th>
						<th style="width:4%">Drop Date</th>
						 <th style="width:4%">Drop Time</th>
					    <th style="width:11%">Vehicle Reg Number</th>
						 <th style="width:11%">Vehicle Model</th>
						 <th style="width:11%">Vehicle Ownerships Types</th>
					    <th  style="width:11%">Pickup City</th>
					    <th  style="width:11%">Pickup Landmark</th>
					    <th  style="width:11%">Pickup Latitude</th>
					    <th  style="width:11%">Pickup Longitude</th>
						  <th  style="width:11%">Pickup Area</th>
					    <th  style="width:11%">Guest</th>
						 <th  style="width:11%">Guest Contact</th>
					    <th style="width:11%">Drop City</th>
						  <th style="width:11%">Drop Area</th>
						   <th style="width:11%">Drop Latitude</th>
						    <th style="width:11%">Drop Longitude</th>
						    <th style="width:11%">Via City</th>
						    <th style="width:11%">Via Landmark</th>
						    <th style="width:11%">Via Latitude</th>
						    <th style="width:11%">Via Longitude</th>
					    <th style="width:11%">Customer</th>	
						 <th style="width:11%">Customer Group</th>
						 <th style="width:11%">Customer Contact</th>					
					    <th style="width:11%">Driver</th>
						<th style="width:11%">Driver Contact</th>
					    <th style="width:11%">Status</th>
					    
					    <th style="width:11%">No:of Passengers</th>
					    <th style="width:11%">Start Km Reading</th>
					    <th style="width:11%">Drp Km Reading</th>
					    <th style="width:11%">Vehicle Type</th>
					    <th style="width:11%">Vehicle Ac Type</th>
					    <th style="width:11%">Vehicle Fuel type</th>
					    <th style="width:11%">Vehicle Seating Capacity</th>
					    <th style="width:11%">Vehicle Beacon Light Option</th>
					     <th style="width:11%">Vehicle Make</th>
					     <th style="width:11%">Vehicle Model</th>
					     <th style="width:11%">Driver Language</th>
					     <th style="width:11%">Placard</th>
					     <th style="width:11%">Uniform</th>
					     <th style="width:11%">Trip Model</th>
					     <th style="width:11%">Tariff</th>
					     <th style="width:11%">Payment Type</th>
					     <th style="width:11%">Advance Amount</th>
					     <th style="width:11%">Driver Bata</th>
					     <th style="width:11%">Total Amount</th>
					     <th style="width:11%">Remarks</th>
					    
					</tr>
				
					<?php
					
					
					for($trip_index=0;$trip_index<count($trips);$trip_index++){
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
					<tr>
						
						<td><?php echo $trips[$trip_index]['id'];?></td>
						<td><?php echo $trips[$trip_index]['booking_date'];?></td>
						<td><?php echo $trips[$trip_index]['booking_time'];?></td>
						<td><?php if($trips[$trip_index]['booking_source_id']==gINVALID || $trips[$trip_index]['booking_source_id']==0){echo '';}else{echo $booking_sources[$trips[$trip_index]['booking_source_id']];}?></td>
					   <!-- <td><?php echo $customers[$trips[$trip_index]['customer_id']].br();
						if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){echo '';}else{ echo $customer_groups[$trips[$trip_index]['customer_group_id']];}?></td>-->
					    <td><?php echo $trips[$trip_index]['pick_up_date']; ?></td>
						 <td><?php echo $trips[$trip_index]['pick_up_time']; ?></td>
						 <td><?php echo $trips[$trip_index]['drop_date']; ?></td>
						 <td><?php echo $trips[$trip_index]['drop_time']; ?></td>
					    <td><?php 
					    if($trips[$trip_index]['vehicle_id']==gINVALID || $trips[$trip_index]['vehicle_id']==0){echo 'Vehicle Not Allocated';}else{ echo $trips[$trip_index]['registration_number'];
					    }?></td><td> <?php 
					    if($trips[$trip_index]['vehicle_model_id']==gINVALID || $trips[$trip_index]['vehicle_model_id']==0){echo '';}else{ echo $vehicle_models[$trips[$trip_index]['vehicle_model_id']].br();
					    }?></td><td> <?php 
					    if($trips[$trip_index]['vehicle_ownership_types_id']==gINVALID || $trips[$trip_index]['vehicle_ownership_types_id']==0){echo '';}else{ echo $vehicle_ownership_types[$trips[$trip_index]['vehicle_ownership_types_id']].br();
					    }
					    ?></td>
						 <td><?php echo $trips[$trip_index]['pick_up_city'];?></td>
						 <td><?php 
									 echo $trips[$trip_index]['pick_up_area'];
						 ?></td>
						 <td><?php echo $trips[$trip_index]['pick_up_landmark'];?></td>
						 <td><?php echo $trips[$trip_index]['pick_up_lat'];?></td>
						 <td><?php echo $trips[$trip_index]['pick_up_lng'];?></td>
						 
					  <td>
					  <?php if($trips[$trip_index]['guest_id']==gINVALID || $trips[$trip_index]['guest_id']==0){echo '';}else{ echo $trips[$trip_index]['guest_name'];	} ?></td>
						 <td><?php 
						if($trips[$trip_index]['guest_id']==gINVALID || $trips[$trip_index]['guest_id']==0){echo '';}else{ echo $trips[$trip_index]['guest_info'];
					    } ?>
					  </td>
						 <td><?php echo $trips[$trip_index]['drop_city']; ?></td>
						 <td><?php echo $trips[$trip_index]['drop_area'];?></td>
						 <td><?php echo $trips[$trip_index]['drop_lat'];?></td>
						  <td><?php echo $trips[$trip_index]['drop_lng'];?></td>
						  <td><?php echo $trips[$trip_index]['via_city'];?></td>
						  <td><?php echo $trips[$trip_index]['via_landmark'];?></td>
						  <td><?php echo $trips[$trip_index]['via_lat'];?></td>
						  <td><?php echo $trips[$trip_index]['via_lng'];?></td>
					 <td><?php if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){echo '';}else{ echo $trips[$trip_index]['customer_name'];
					    }?></td>
						 <td><?php 
					    if($trips[$trip_index]['customer_group_id']==gINVALID || $trips[$trip_index]['customer_group_id']==0){echo '';}else{ echo $trips[$trip_index]['customer_group'];
					    }?></td>
						 <td><?php 
					    if($trips[$trip_index]['customer_id']==gINVALID || $trips[$trip_index]['customer_id']==0){echo '';}else{ echo $trips[$trip_index]['customer_mobile'];
					    }
					    ?></td>
					    
					  <td><?php
						if($trips[$trip_index]['driver_id']==gINVALID || $trips[$trip_index]['driver_id']==0){echo 'Driver Not Allocated';}else{ echo $trips[$trip_index]['driver']; } ?></td>
						 <td><?php if(isset($trips[$trip_index]['driver_info']) && $trips[$trip_index]['driver_info']!=''){ echo $trips[$trip_index]['driver_info'];}
					   
						?></td>
					    <td>
							<span class="label --><?php echo $status_class[$trips[$trip_index]['trip_status_id']]; ?>"><?php echo $trip_statuses[$trips[$trip_index]['trip_status_id']];?></span>
						
						</td>
						<td><?php echo $trips[$trip_index]['no_of_passengers'];?></td>
						<td><?php echo $trips[$trip_index]['kilometer_reading_start'];?></td>
						<td><?php echo $trips[$trip_index]['kilometer_reading_drop'];?></td>
						<td><?php if($trips[$trip_index]['vehicle_type_id']==gINVALID || $trips[$trip_index]['vehicle_type_id']==0){echo '';}else{ echo $vehicle_types[$trips[$trip_index]['vehicle_type_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_ac_type_id']==gINVALID || $trips[$trip_index]['vehicle_ac_type_id']==0){echo '';}else{ echo $vehicle_ac_types[$trips[$trip_index]['vehicle_ac_type_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_fuel_type_id']==gINVALID || $trips[$trip_index]['vehicle_fuel_type_id']==0){echo '';}else{ echo $vehicle_fuel_types[$trips[$trip_index]['vehicle_fuel_type_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_seating_capacity_id']==gINVALID || $trips[$trip_index]['vehicle_seating_capacity_id']==0){echo '';}else{ echo $vehicle_seating_capacity[$trips[$trip_index]['vehicle_seating_capacity_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_beacon_light_option_id']==gINVALID || $trips[$trip_index]['vehicle_beacon_light_option_id']==0){echo '';}else{ echo $vehicle_beacon_light_options[$trips[$trip_index]['vehicle_beacon_light_option_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_make_id']==gINVALID || $trips[$trip_index]['vehicle_make_id']==0){echo '';}else{ echo $vehicle_makes[$trips[$trip_index]['vehicle_make_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['vehicle_model_id']==gINVALID || $trips[$trip_index]['vehicle_model_id']==0){echo '';}else{ echo $vehicle_models[$trips[$trip_index]['vehicle_model_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['driver_language_id']==gINVALID || $trips[$trip_index]['driver_language_id']==0){echo '';}else{ echo $languages[$trips[$trip_index]['driver_language_id']].br();
					    }?></td>
						<td><?php if($trips[$trip_index]['pluckcard']!=0){ echo "Yes";
						}else{ echo "No";
						}?></td>
						<td><?php if($trips[$trip_index]['uniform']!=0){ echo "Yes";
						}else{ echo "No";
						}?></td>
						<td><?php if($trips[$trip_index]['trip_model_id']==gINVALID || $trips[$trip_index]['trip_model_id']==0){echo '';}else{ echo $trip_models[$trips[$trip_index]['trip_model_id']].br();
					    }?></td>
					
						
						<td><?php echo $trips[$trip_index]['title'];?></td>
						<td><?php echo $trips[$trip_index]['name'];?></td>
						<td><?php echo $trips[$trip_index]['advance_amount'];?></td>
						<td><?php echo $trips[$trip_index]['driver_batta'];?></td>
						<td><?php echo $trips[$trip_index]['total_amount'];?></td>
						<td><?php echo $trips[$trip_index]['remarks'];?></td>	
						
						
					
					</tr>
					<?php 
						}
						
						}
					?>
				</tbody>
			</table>
		
