$(document).ready(function(){

 var base_url=window.location.origin;

$('.complete-trip').click(function(){
if($(this).find('span').attr('vehicle_model_id')>0){
return true;
}else{
var trip_id=$(this).find('span').attr('trip_id');
var url=base_url+"/organization/front-desk/trip-booking/"+trip_id;
var r = confirm("Please Select Vehicle Model To Complete The Trip..Click OK to Continue..!");
    if (r == true) {
       window.open(url, '_blank');
		return false; 
    } else {
       return false; 
    }
   
}
});

//--to expand and collapse table rows for trips	

	$('.common').click(function(){ 
		$(this).hide();
	if($(this).attr('limited')=='true'){
		
		$(this).next().show();
	}else if($(this).attr('limited')=='false'){
		$(this).prev().show();
	}

	
	});
	
			//ends function		

$('.voucher').on('click',function(){ 
	var new_voucher = $(this).attr('new_voucher');
	var trip_id=$(this).attr('trip_id');
	var driver_id=$(this).attr('driver_id');
	var tarrif_id=$(this).attr('tarrif_id');
	//var no_of_days=$(this).attr('no_of_days');
	var pick_up_time=$(this).attr('pick_up_time'); 
	var vehicle_model_id=$(this).attr('vehicle_model_id');
	var vehicle_ac_type_id=$(this).attr('vehicle_ac_type_id');


	var pick_up_date=$(this).attr('pick_up_date');
	var drop_date=$(this).attr('drop_date');
	
	var customer_id=$(this).attr('customer_id');
	var customer_name=$(this).attr('customer_name');
	var company_name=$(this).attr('company_name');
	var model=$(this).attr('model');
	var vehicle_no=$(this).attr('vehicle_no');
	var description=$(this).attr('description');


	if(vehicle_ac_type_id==-1){
		vehicle_ac_type_id=1;
	}
	id='#trip-tariff';
	generateTariffs(vehicle_model_id,vehicle_ac_type_id,tarrif_id,id,customer_id);
	

	$('.overlay-container').css('display','block');

	var top=-1*(Number($('.trips-table').height())+70);
	$('.modal-body').css('top',top);

	
	$('.trip-voucher-save').attr('trip_id',trip_id);
	$('.trip-voucher-save').attr('driver_id',driver_id);
	$('.trip-voucher-save').attr('new_voucher',new_voucher);



	$('.customer').val(customer_name);
	$('.company').val(company_name);
	$('.startdt').val(formatDate_d_m_Y(pick_up_date));
	$('.enddt').val(formatDate_d_m_Y(drop_date));
	$('.model').val(model);
	$('.vehicleno').val(vehicle_no);
	$('.description').val(description);




	$.post(base_url+"/trip-booking/getVouchers",
		  {
			trip_id:trip_id,
			ajax:'YES'
			
		},function(data){
			if(data=='false'){
				start_time=pick_up_time.split(':');
				$('.tripstartingtime').val(start_time[0]+':'+start_time[1]);
				
			}else{
				var total_km = data[0].end_km_reading-data[0].start_km_reading;
				if(pick_up_date!='' && data[0].trip_starting_time!='' && drop_date!='' && data[0].trip_ending_time!='' && data[0].trip_starting_time!=''){
					var time_diff = timeDifference(pick_up_date,data[0].trip_starting_time,drop_date,data[0].trip_ending_time);
				
				time_diff = time_diff.split('-');
					$('.triptime').val(time_diff[1]+':'+time_diff[2]);
				
				
				}

				
				
				$('.daysno').val(data[0].no_of_days);
				//set_tarif_row_with_daysno(data[0].no_of_days);

				$('.startkm').val(data[0].start_km_reading);
				$('.endkm').val(data[0].end_km_reading);
				$('.totalkm').val(total_km);
				$('.garageclosingkm').val(data[0].garage_closing_kilometer_reading);
				$('.garageclosingtime').val(data[0].garage_closing_time);
				$('.releasingplace').val(data[0].releasing_place);
				$('.parkingfee').val(data[0].parking_fees);
				$('.tollfee').val(data[0].toll_fees);
				$('.statetax').val(data[0].state_tax);
				start_time=data[0].trip_starting_time.split(':');
				$('.tripstartingtime').val(start_time[0]+':'+start_time[1]);
				end_time=data[0].trip_ending_time.split(':');
				$('.tripendingtime').val(end_time[0]+':'+end_time[1]);
				
			
				$('.nighthalt').val(data[0].night_halt_charges);
				$('.extrafuel').val(data[0].fuel_extra_charges);
				$('.driverbata').val(data[0].driver_bata);

				$('.vehicletarif').val(data[0].vehicle_tarif);//need to b changed

				$('.voucherno').val(data[0].voucher_no);
				$('.kmhr').val(data[0].km_hr);
				
				if(data[0].km_hr == hr_flag){
					$('.basehrs').val(data[0].base_tarif);
					$('.basehrsamount').val(data[0].base_amount);
					$('.adthrs').val(data[0].adt_tarif);
					$('.adlhrrate').val(data[0].adt_tarif_rate);
					setHR_Tariff(data[0].base_tarif,data[0].base_amount,data[0].adt_tarif_rate);
				}else if(data[0].km_hr == km_flag && data[0].no_of_days > 1){
						$('.perdaykm').val(data[0].base_tarif);
						$('.perdaykmamount').val(data[0].base_amount);
						$('.adtperdaykm').val(data[0].adt_tarif);
						$('.adtperdaykmrate').val(data[0].adt_tarif_rate);
						setPerDay_Tariff(data[0].base_tarif,data[0].base_amount,data[0].adt_tarif_rate);
				} else{
						$('.basekm').val(data[0].base_tarif);
						$('.baseamount').val(data[0].base_amount);
						$('.adtkm').val(data[0].adt_tarif);
						$('.adlkmrate').val(data[0].adt_tarif_rate);
						setKM_Tariff(data[0].base_tarif,data[0].base_amount,data[0].adt_tarif_rate);
				}
				
				

			
			
			}
		});
			
});


//formatting date
function formatDate_d_m_Y(date) {
        var d = new Date(date);
        var day = d.getDate();
        var month = d.getMonth() + 1;
        var year = d.getFullYear();
        if (day < 10) {
            day = "0" + day;
        }
        if (month < 10) {
            month = "0" + month;
        }
        var date = day + "-" + month + "-" + year;

        return date;
    }

/*function formatDate_Y_m_d(date) {
        var d = new Date(date);
        var day = d.getDate();
        var month = d.getMonth() + 1;
        var year = d.getFullYear();
        if (day < 10) {
            day = "0" + day;
        }
        if (month < 10) {
            month = "0" + month;
        }
        var date = year + "-" + month + "-" + day;

        return date;
    }*/
function formatDate_Y_m_d(date) {
        var d = date.split('-');
        var day = d[0];
        var month = d[1];
        var year = d[2];
        
        var date = year + "-" + month + "-" + day;

        return date;
    }
function toSeconds(time_str) {
    // Extract hours, minutes and seconds
    var parts = time_str.split(':');
    var sec = 0;
    // compute  and return total seconds
	if(parts[0]){
		sec = Number(sec) + Number(parts[0]) * 3600;
	}
	if(parts[1]){
		sec = Number(sec) + Number(parts[1]) * 60;
	}
	if(parts[2]){
		sec = Number(sec) + Number(parts[2]) * 1;
	}
    //return parts[0] * 3600 + parts[1] * 60 + parts[2]*1; // seconds
	return sec;
}

function timeDifference(fromdate,fromtime,todate,totime){ 

	var fromdate=fromdate.split('-');
	var todate=todate.split('-');
    var start_actual_time  =  fromdate[0]+'/'+fromdate[1]+'/'+fromdate[2]+' '+fromtime;
    var end_actual_time    =  todate[0]+'/'+todate[1]+'/'+todate[2]+' '+totime;
	
    start_actual_time = new Date(start_actual_time);
    end_actual_time = new Date(end_actual_time);

    var diff = end_actual_time - start_actual_time;

    var diffSeconds = diff/1000;
    var HH = Math.floor(diffSeconds/3600);
    var MM = Math.floor(diffSeconds%3600)/60;
	var result='';
	var no_of_days=Math.floor(HH/24);  
    if(HH%24==0 && MM==0){
    result+=no_of_days+'-'+HH+'-'+MM;	
    }
    else if((HH>=24 && MM>=1) || HH>24){
      no_of_days=no_of_days+1; 
	result+=no_of_days+'-'+HH+'-'+MM;	
    }else{
 	result+='1'+'-'+HH+'-'+MM;
	
	}
	return result;
}


$('.modal-close').on('click',function(){
	clearErrorLabels();
	resetTax();

});

//calculate total km readming
$('.endkm').keyup(function(e) {
	var start = $('.startkm').val();
	var end = $(this).val();
	var total = end - start;
	$('.totalkm').val(total);
	
});

$('.startkm').keyup(function(e) {
	var end = $('.endkm').val();
	var start = $(this).val();
	var total = end - start;
	$('.totalkm').val(total);

	
});

/*function set_tarif_row_with_daysno(days=1)
{
	if(days==1){
		enablekmfields();
		enablehrfields();
		disableperdayfields();
		clearperdaykmfields();
		total_tarif=0;
		setTotalAmount();
	}else{
		total_tarif=0;
		setTotalAmount();
		disablekmfields();
		disablehrfields();
		enableperdayfields();
		clearkmfields();
		clearhrfields();
	}
}*/

//calculate total hrs readming
$('.tripendingtime').blur(function(e) {
	var start = $('.tripstartingtime').val();
	var end = $('.tripendingtime').val();
	var fromdate=formatDate_Y_m_d($('#startdt').val()); 
	var todate=formatDate_Y_m_d($('.enddt').val());
	if(fromdate!='' && todate!='' && end!='' && start!=''){
		var total = timeDifference(fromdate,start,todate,end);
		total=total.split('-');
		$('.triptime').val(total[1]+':'+total[2]);
		$('.daysno').val(total[0]);
		if(total[0]==1){
			enablekmfields();
			enablehrfields();
			setHR_Tariff();
			setKM_Tariff();
		}else{
			enablekmfields();
			setKM_Tariff();
			disablehrfields();
			//clearkmfields();
			//clearhrfields();
		}
			
	}else{
		$('.triptime').val('');
		$('.daysno').val('');
		enablekmfields();
		enablehrfields();
		
	}
});

$('.tripstartingtime').blur(function(e) {
	var end = $('.tripendingtime').val();
	var start =$('.tripstartingtime').val();
	var fromdate=formatDate_Y_m_d($('#startdt').val());
	var todate=formatDate_Y_m_d($('.enddt').val());
	if(fromdate!='' && todate!='' && end!='' && start!=''){
	var total = timeDifference(fromdate,start,todate,end);
	total=total.split('-');
	$('.triptime').val(total[1]+':'+total[2]);
	$('.daysno').val(total[0]);
	if(total[0]==1){
	enablekmfields();
	enablehrfields();
	setHR_Tariff()
	}else{
	enablekmfields();
	setKM_Tariff();
	disablehrfields();
	//clearkmfields();
	//clearhrfields();
	}
	}else{
	$('.triptime').val('');
	$('.daysno').val('');
	enablekmfields();
	enablehrfields();
	enableperdayfields();
	}
});

$('.enddt').blur(function(e) {
	var end = $('.tripendingtime').val();
	var start = $('.tripstartingtime').val();
	var fromdate=formatDate_Y_m_d($('#startdt').val());
	var todate=formatDate_Y_m_d($('.enddt').val());
	if(fromdate!='' && todate!='' && end!='' && start!=''){
	var total = timeDifference(fromdate,start,todate,end);
	total=total.split('-');
	$('.triptime').val(total[1]+':'+total[2]);
	$('.daysno').val(total[0]);
	if(total[0]==1){
	enablekmfields();
	enablehrfields();
	setHR_Tariff();
	setKM_Tariff();
	}else{
	enablekmfields();
	setKM_Tariff();
	disablehrfields();
	//clearkmfields();
	//clearhrfields();
	}
	}else{
	$('.triptime').val('');
	$('.daysno').val('');
	enablekmfields();
	enablehrfields();
	enableperdayfields();
	}
	
});

$('.startkm,.endkm').blur(function(){
if($('.startkm').val()!='' && $('.endkm').val()!='' ){
setKM_Tariff();
}
});




$(document).keydown(function(e) {
  
  if (e.keyCode == 27) { 
	clearErrorLabels();
 }   // esc

});
function clearErrorLabels(){
$('.overlay-container').css('display','	none');
$('.start-km-error').html('');
$('.end-km-error').html('');
$('.garage-km-error').html('');
$('.garage-time-error').html('');
$('.tariff-error').html('');

$('.startdt').val('');
$('.enddt').val('');

$('.startkm').val('');
$('.endkm').val('');
$('.totalkm').val('');
$('.garageclosingkm').val('');
$('.garageclosingtime').val('');
$('.releasingplace').val('');
$('.parkingfee').val('');
$('.tollfee').val('');
$('.statetax').val('');
$('.tripstartingtime').val('');
$('.tripendingtime').val('');
$('#tarrif').val('');
$('.nighthalt').val('');
$('.extrafuel').val('');
$('.driverbata').val('');
}




function disablekmfields(){

$('.basekm').attr('disabled','true');
$('.baseamount').attr('disabled','true');
$('.adlkmrate').attr('disabled','true');
$('.adtkmrate').attr('disabled','true');

$('.basedriverkm').attr('disabled','true');
$('.basedriveramount').attr('disabled','true');
$('.adldriverkmrate').attr('disabled','true');
$('.adtdriverkmrate').attr('disabled','true');

$('.basevehiclekm').attr('disabled','true');
$('.basevehicleamount').attr('disabled','true');
$('.adlvehiclekmrate').attr('disabled','true');
$('.adtvehiclekmrate').attr('disabled','true');
}
function clearkmfields(){
total_tarif = 0;
$('.totaltarif').val('');
$('.basekm').val('');
$('.baseamount').val('');
$('.adlkmrate').val('');
$('.adtkm').val('');
}

function disablehrfields(){

$('.basehrs').attr('disabled','true');
$('.basehrsamount').attr('disabled','true');
$('.adlhrrate').attr('disabled','true');
$('.aditionalhramount').attr('disabled','true');
$('.adthrsrate').attr('disabled','true');

$('.basedriverhrs').attr('disabled','true');
$('.basedriverhrsamount').attr('disabled','true');
$('.adldriverhrrate').attr('disabled','true');
$('.aditionaldriverhramount').attr('disabled','true');
$('.adtdriverhrrate').attr('disabled','true');

$('.basevehiclehrs').attr('disabled','true');
$('.basevehiclehrsamount').attr('disabled','true');
$('.adlvehiclehrrate').attr('disabled','true');
$('.aditionalvehiclehramount').attr('disabled','true');
$('.adtvehiclehrrate').attr('disabled','true');
}

function clearhrfields(){
total_tarif = 0;
$('.totaltarif').val('');
$('.basehrs').val('');
$('.basehrsamount').val('');
$('.adlhrrate').val('');
$('.adthrs').val('');
}

function enablekmfields(){

$('.basekm').removeAttr('disabled');
$('.baseamount').removeAttr('disabled');
$('.adlkmrate').removeAttr('disabled');
$('.adtkmrate').removeAttr('disabled');

$('.basedriverkm').removeAttr('disabled');
$('.basedriveramount').removeAttr('disabled');
$('.adldriverkmrate').removeAttr('disabled');
$('.adtdriverkmrate').removeAttr('disabled');

$('.basevehiclekm').removeAttr('disabled');
$('.basevehicleamount').removeAttr('disabled');
$('.adlvehiclekmrate').removeAttr('disabled');
$('.adtvehiclekmrate').removeAttr('disabled');

}

function enablehrfields(){
$('.basehrs').removeAttr('disabled');
$('.basehrsamount').removeAttr('disabled');
$('.adlhrrate').removeAttr('disabled');
$('.aditionalhramount').removeAttr('disabled');
$('.adthrsrate').removeAttr('disabled');

$('.basedriverhrs').removeAttr('disabled');
$('.basedriverhrsamount').removeAttr('disabled');
$('.adldriverhrrate').removeAttr('disabled');
$('.aditionaldriverhramount').removeAttr('disabled');
$('.adtdriverhrrate').removeAttr('disabled');

$('.basevehiclehrs').removeAttr('disabled');
$('.basevehiclehrsamount').removeAttr('disabled');
$('.adlvehiclehrrate').removeAttr('disabled');
$('.aditionalvehiclehramount').removeAttr('disabled');
$('.adtvehiclehrrate').removeAttr('disabled');
}



//clear all tariff inputs
function clearAllTariff(){
	clearkmfields();
	clearhrfields();
	clearperdaykmfields();
}



//KM tariff calculation
function setKM_Tariff()
{
	var basekm=$('.basekm').val();
	var basekmamount=$('.basekmamount').val();
	var tariff_id=$('.trip-tariff').val();
	var adlkmrate=$('.adtkmrate').val();
	var totalkm=$('.totalkm').val();
	var noofdays=$('.daysno').val();
		
	if(totalkm != '' && Number(totalkm) > 0 && tariff_id!=-1){
	
	
		if(totalkm!='' && basekm!=''){
			if(noofdays==1){
				if(Number(totalkm) <= Number(basekm)){
					$('.adtkm').val('');
					$('.adlkmrate').val('');
					$('.aditionalkmamount').val('');
					$('.totalkmamount').val(basekmamount);
			
					//driver
					$('.aditionaldriverkmamount').val('');
					$('.totaldriverkmamount').val(basekmamount);
					$('.adtdriverkm').val('');
					compareCustomAmounts('driver');

					//vehicle
					$('.aditionalvehiclekmamount').val('');
					$('.totalvehiclekmamount').val(basekmamount);
					$('.adtvehiclekm').val('');
					compareCustomAmounts('vehicle');

					$('.totaldriverkmamount').attr('totamountset','true');
					$('.totalvehiclekmamount').attr('totamountset','true');
				
				}else{
					
					var adtkm = totalkm-basekm;
					if(Number(adtkm)>0){
						$('.adtkm').val(adtkm);
					}else{
						$('.adtkm').val('');
					}

					if(basekmamount!='' && adlkmrate!=''){
						if(Number(adtkm)>0){
							var adtamt = Number(adtkm)*Number(adlkmrate);
							total_tarif = Number(basekmamount)+Number(adtamt);
							$('.aditionalkmamount').val(adtamt);
							$('.totalkmamount').val(total_tarif);
							//driver
							if($('.totaldriverkmamount').attr('totamountset')=='false'){
							$('.aditionaldriverkmamount').val(adtamt);
							$('.totaldriverkmamount').val(total_tarif);
							$('.adtdriverkm').val(adtkm);
							compareCustomAmounts('driver');
							}
							//vehicle
							if($('.totalvehiclekmamount').attr('totamountset')=='false'){
							$('.aditionalvehiclekmamount').val(adtamt);
							$('.totalvehiclekmamount').val(total_tarif);
							$('.adtvehiclekm').val(adtkm);
							compareCustomAmounts('vehicle');
							}
							$('.totaldriverkmamount').attr('totamountset','true');
							$('.totalvehiclekmamount').attr('totamountset','true');

						}else{

							$('.aditionalkmamount').val(adtamt);
							$('.totalkmamount').val(total_tarif);
	
							//driver
							$('.aditionaldriverkmamount').val('');
							$('.totaldriverkmamount').val(total_tarif);
							$('.adtdriverkm').val('');
						
							//vehicle
							$('.aditionalvehiclekmamount').val('');
							$('.totalvehiclekmamount').val(total_tarif);
							$('.adtvehiclekm').val('');
						
							$('.totaldriverkmamount').attr('totamountset','false');
							$('.totalvehiclekmamount').attr('totamountset','false');

						}
					}
				}
			}else if(noofdays>1){
				mutipledaysbasekm=Number(basekm)*Number(noofdays);
				mutipledaysbasekmamount=Number(basekmamount)*Number(noofdays);
				if(Number(totalkm) <= Number(mutipledaysbasekm)){
					$('.adtkm').val('');
					$('.adlkmrate').val('');
					$('.aditionalkmamount').val('');
					$('.totalkmamount').val(mutipledaysbasekmamount);

					//driver
					$('.aditionaldriverkmamount').val('');
					$('.totaldriverkmamount').val(mutipledaysbasekmamount);
					$('.adtdriverkm').val('');
					compareCustomAmounts('driver');

					//vehicle
					$('.aditionalvehiclekmamount').val('');
					$('.totalvehiclekmamount').val(mutipledaysbasekmamount);
					$('.adtvehiclekm').val('');
					compareCustomAmounts('vehicle');

					$('.totaldriverkmamount').attr('totamountset','true');
					$('.totalvehiclekmamount').attr('totamountset','true');
				
				}else{
					
					var adtkm = totalkm-mutipledaysbasekm;
					if(Number(adtkm)>0){
						$('.adtkm').val(adtkm);
					}else{
						$('.adtkm').val('');
					}

					if(basekmamount!='' && adlkmrate!=''){
						if(Number(adtkm)>0){
						var adtamt = adtkm*adlkmrate;
						total_tarif = Number(basekmamount)+Number(adtamt);
							$('.aditionalkmamount').val(adtamt);
							$('.totalkmamount').val(total_tarif);
							if($('.totaldriverkmamount').attr('totamountset')=='false'){
							$('.adtdriverkm').val(adtkm);
							$('.aditionaldriverkmamount').val(adtamt);
							$('.totaldriverkmamount').val(total_tarif);
							compareCustomAmounts('driver');
							}
							if($('.totalvehiclekmamount').attr('totamountset')=='false'){
							$('.adtvehiclekm').val(adtkm);
							$('.aditionalvehiclekmamount').val(adtamt);
							$('.totalvehiclekmamount').val(total_tarif);
							compareCustomAmounts('vehicle');
							}
							$('.totaldriverkmamount').attr('totamountset','true');
							$('.totalvehiclekmamount').attr('totamountset','true');

						}else{

							$('.aditionalkmamount').val(adtamt);
							$('.totalkmamount').val(total_tarif);
	
							//driver
							$('.aditionaldriverkmamount').val('');
							$('.adtdriverkm').val('');
							$('.totaldriverkmamount').val('');
						
							//vehicle
							$('.aditionalvehiclekmamount').val('');
							$('.totalvehiclekmamount').val('');
							$('.adtvehiclekm').val('');

							$('.totaldriverkmamount').attr('totamountset','false');
							$('.totalvehiclekmamount').attr('totamountset','false');

						}
					}
				}

			}
		}
		compareAmounts();
		//$('.kmhr').val( km_flag);
		//setTotalAmount();
		
	}else{
		//clearAllTariff();
	}
}
//Hours tariff calculation
function setHR_Tariff()
{
	
	var basehrs=$('.basehrs').val();
	var tariff_id=$('.trip-tariff').val();
	var basehrsamount=$('.basehrsamount').val();
	var adlhrrate=$('.adthrsrate').val();
	var triptime=$('.triptime').val();
	
	if(triptime != '' && tariff_id!=-1){

		if(triptime!='' && basehrs!=''){
			if(basehrs.indexOf(':')>-1 ){
				basehrs=basehrs.split(':');
				base=basehrs[0]+'.'+basehrs[1];
			}else{
				base=basehrs;

			}
			triptime=triptime.split(':');

			tottime=triptime[0]+'.'+triptime[1];
			if(Number(tottime) <= Number(base)){
				total_tarif = Number(basehrsamount);
				$('.adthrs').val('');
				$('.adlhrrate').val('');
				$('.aditionalhramount').val('');
				$('.totalhramount').val(basehrsamount);
				
			}else{
				
				$('.adlhrrate').removeAttr('disabled');
				var adthrs=Number(tottime)-Number(base); //time difference
				
				adthrs=adthrs.toFixed(2);
				adthrsnew=adthrs.replace(/\./g, ':');
				

				if(basehrsamount!='' && adlhrrate!=''){

					var adtamt = calculateHrsAmount(adthrsnew,adlhrrate);
					total_tarif = Number(basehrsamount)+Number(adtamt);
				}
				
				if(Number(adthrs)>0){
					$('.adthrs').val(adthrsnew);
					$('.aditionalhramount').val(adtamt);
					$('.totalhramount').val(total_tarif);
					if($('.totaldriverhramount').attr('totamountset')=='false'){
						$('.aditionaldriverhramount').val(adtamt);
						$('.totaldriverhramount').val(total_tarif);
						$('.adtdriverhrs').val(adthrsnew);
						compareCustomAmounts('driver');
						}
						if($('.totalvehiclehramount').attr('totamountset')=='false'){
						$('.aditionalvehiclehramount').val(adtamt);
						$('.adtvehiclehrs').val(adthrsnew);
						$('.totalvehiclehramount').val(total_tarif);
						compareCustomAmounts('vehicle');
						}
						$('.totaldriverhramount').attr('totamountset','true');
						$('.totalvehiclehramount').attr('totamountset','true');
				}else{
					$('.adthrs').val('');
					$('.aditionalhramount').val('');
					$('.totalhramount').val('');
						
					//driver
					$('.aditionaldriverhramount').val('');
					$('.totaldriverhramount').val('');
					$('.adtdriverhrs').val('');
					$('.totaldriverhramount').attr('totamountset','false');
					$('.totalvehiclehramount').attr('totamountset','false');
				
					//vehicle
					$('.aditionalvehiclehramount').val('');
					$('.totalvehilcerhramount').val('');
					$('.adtvehiclehrs').val('');
					$('.totaldriverhramount').attr('totamountset','false');
					$('.totalvehiclehramount').attr('totamountset','false');
				}	
			}	
			
		}
		compareAmounts();
		//$('.kmhr').val(hr_flag);
		//setTotalAmount();

	}else{
		//clearAllTariff();
	}
}


function compareAmounts(){
var totalhramount=$('.totalhramount').val();
var totalkmamount=$('.totalkmamount').val();
var noofdays=$('.daysno').val();
	if(Number(noofdays)==1){
	if(totalhramount!='' && totalkmamount!=''){
		if(Number(totalhramount)>Number(totalkmamount)){
			$('.totamount-radio-container2 > .iradio_minimal > .iCheck-helper').trigger('click');
		}else if(Number(totalhramount)<Number(totalkmamount)){
			$('.totamount-radio-container1 > .iradio_minimal > .iCheck-helper').trigger('click');
		}

	}
	}else if(Number(noofdays)>1){
		$('.totamount-radio-container1 > .iradio_minimal > .iCheck-helper').trigger('click');
	}
}

//set which amount is to select

$('.totamount-radio-container2 > .iradio_minimal > .iCheck-helper').click(function(){
$('.totalamount').attr('amount-class-to-be-selected','totalhramount');
checkTotAmount();
});

$('.totamount-radio-container1 > .iradio_minimal > .iCheck-helper').click(function(){

$('.totalamount').attr('amount-class-to-be-selected','totalkmamount');
checkTotAmount();
});

//return true if tot amounts not null
function checkTotAmount(){
	var totalhramount=$('.totalhramount').val();
	var totalkmamount=$('.totalkmamount').val();
	if(totalhramount!='' && totalkmamount!=''){
	setTotalAmount();
	}
}
//calculate amount with time string and hourly rate
function calculateHrsAmount(time_str,hrsrate){
	
	var parts = time_str.split(':');
	var hr_amount = 0;
	var min_amount = 0;
	if(hrsrate != ''){
		if(parts[0]){
			var hrs = Number(parts[0]);
			hr_amount = hrs*hrsrate;
		}
		if(parts[1]){
			var mns = Number(parts[1]);
			if(mns >0 && mns < 16){
				min_amount = hrsrate*0.25;
			}else if(mns > 15 && mns < 31){
				min_amount = hrsrate*0.5;
			}else  if(mns > 30 && mns < 46){
				min_amount = hrsrate*0.75;
			}else if(mns > 45 && mns < 60){
				min_amount = hrsrate;
			}
		}
	}
	
	return Number(hr_amount)+Number(min_amount);
}

//calculate total 

function setTotalAmount()
{
	var statetax = $('.statetax').val();
	var driverbata = $('.driverbata').val();
	var tollfee = $('.tollfee').val();
	var nighthalt = $('.nighthalt').val();
	var parkingfee = $('.parkingfee').val();
	var extrafuel=$('.extrafuel').val();
	if($('.totalamount').attr('amount-class-to-be-selected')!=''){
		var total_tarif=$('.'+$('.totalamount').attr('amount-class-to-be-selected')).val();
		var total = Number(total_tarif)+Number(statetax)+Number(driverbata)+Number(tollfee)+Number(nighthalt)+Number(parkingfee)+Number(extrafuel);
		$('.totalamount').val(total);
	}
	
}
//calculating tax amount on changing tax group from voucher
$(".taxgroup").change(function(){
var amount = $('.totalamount').val();
$obj=$(this);
$id = $obj.val();
var amt = $('.totalamount').val();
$.post(base_url+"/account/getTotalTax",{id:$id, amt:amount},
function(data){

$obj.parent().find('#totaltax').val(data);
$obj.hide();
$obj.parent().find('#totaltax').show();
});



});
function resetTax()
{
$('#totaltax').val('');
$(".taxgroup").val('');
$('#totaltax').hide();
$(".taxgroup").show();
}


//km keyup event
$('.basekm,.basekmamount,.adlkmrate,.adtkmrate').keyup(function(){
	
	setKM_Tariff();
});

//hourly tariff calculation
$('.basehrs,.basehrsamount,.adlhrrate,.adthrrate').keyup(function(){
	
	setHR_Tariff();
});





$('.statetax,.driverbata,.tollfee,.nighthalt,.parkingfee,.extrafuel').keyup(function(){
	checkTotAmount();
});



$('.trip-voucher-save').on('click',function(){
	var new_voucher=$(this).attr('new_voucher');
	var tax_group = $('.taxgroup').val();//tax calculating factor
    var error = false;
    if(new_voucher == 1 && tax_group == ''){
	 error = true;
	}
    var trip_id=$(this).attr('trip_id');
    var driver_id=$(this).attr('driver_id');

    var voucherno = $('.voucherno').val();
    var remarks = $('.description').val();	
	var releasingplace=$('.releasingplace').val();
	var tariff_id=$('#trip-tariff').attr('tariff');
	
	var startdt=$('.startdt').val();   
    var enddt=$('.enddt').val();
    var trip_starting_time=$('.tripstartingtime').val();
    var trip_ending_time=$('.tripendingtime').val();

    var startkm=$('.startkm').val();
    var endkm=$('.endkm').val();

   
    var no_of_days=$('.daysno').val();

    //tarif values
    var basekm=$('.basekm').val();
    var basekmamount=$('.basekmamount').val();
    var adtkmrate=$('.adtkmrate').val();
	if($('.totalamount').attr('amount-class-to-be-selected')=='totalhramount'){
    	var base_km_hr='H';
	}else if($('.totalamount').attr('amount-class-to-be-selected')=='totalkmamount'){
 		var base_km_hr='K';
	}
    
	var driverbasekm=$('.basedriverkm').val();
    var driverbasekmamount=$('.basedriverkmamount').val();
    var driveradtkmrate=$('.adtdriverkmrate').val();
    if($('.totaldriverkmamount').attr('amount-class-to-be-selected')=='totaldriverhramount'){
    	 var driverbase_km_hr='H';
	}else if($('.totaldriverkmamount').attr('amount-class-to-be-selected')=='totaldriverkmamount'){
 		 var driverbase_km_hr='K';
	}else{
			alert('Please Select Total Driver Amount!!.. ');
			return false;
	}	

	var vehiclebasekm=$('.basevehiclekm').val();
    var vehiclebaseamount=$('.basevehiclekmamount').val();
    var vehicleadtkmrate=$('.adtvehiclekmrate').val();
    if($('.totalvehiclekmamount').attr('amount-class-to-be-selected')=='totalvehiclehramount'){
    	 var vehiclebase_km_hr='H';
	}else if($('.totalvehiclekmamount').attr('amount-class-to-be-selected')=='totalvehiclekmamount'){
 		 var vehiclebase_km_hr='K';
	}else{
			alert('Please Select Total Vehicle Amount!!.. ');
			return false;
	}	
   
	var basehr=$('.basehrs').val();
    var basehramount=$('.basehrsamount').val();
    var adthrrate=$('.adthrsrate').val();
    
    
	var driverbasehr=$('.basedriverhrs').val();
    var driverbasehramount=$('.basedriverhrsamount').val();
    var driveradthrrate=$('.adtdriverhrrate').val();
    
	
	var vehiclebasehr=$('.basevehiclehrs').val();
    var vehiclebasehramount=$('.basevehiclehrsamount').val();
    var vehicleadthrrate=$('.adtvehiclehrrate').val();
    
   
    //other charges
    var parkingfee=$('.parkingfee').val();
    var tollfee=$('.tollfee').val();
    var statetax=$('.statetax').val();
    var nighthalt=$('.nighthalt').val();
    var driverbata=$('.driverbata').val();
    var vehicletarif=$('.vehicletarif').val();

    //total
    var totalamount=$('.totalamount').val();


    if(error==false){
         $.post(base_url+"/trip-booking/tripVoucher",
              {
                trip_id:trip_id,
                remarks:remarks,
                voucherno:voucherno,
                enddt:enddt,
                trip_starting_time:trip_starting_time,
                trip_ending_time:trip_ending_time,
                startkm:startkm,
                endkm:endkm,
                releasingplace:releasingplace,
                no_of_days:no_of_days,
                basetarif:basetarif,
                baseamount:baseamount,
                adttarif:adttarif,
                adttarifrate:adttarifrate,
                kmhr:kmhr,
                parkingfee:parkingfee,
                tollfee:tollfee,
                statetax:statetax,
                nighthalt:nighthalt,
                driverbata:driverbata,
                vehicletarif:vehicletarif,
                driver_id:driver_id,
                totalamount:totalamount,
				tax_group:tax_group
               
            },function(data){
              if(data!='false'){
                var fa_link = '';
                var fa_val;
                var arr = $.parseJSON(data);
                $.each(arr,function(key,value){
                    fa_val = value;
                    if(key == 'NewDelivery'){
                        fa_link = 'NewDelivery';

                    }else if(key == 'ModifyDelivery'){
                        fa_link = 'ModifyDelivery';
                    }
                });
               
                if(fa_link != ''){
                    window.location.replace(base_url+'/account/front_desk/'+fa_link+'/'+fa_val);
                }
               }
            });
    }else{
        return false;
    }
});

function generateTariffs(vehicle_model,vehicle_ac_type,tarif_id='',id,customer_id){
	var tarif_id=tarif_id;
	 $.post(base_url+"/tarrif/tariffSelecter",
		  {
			vehicle_model:vehicle_model,
			vehicle_ac_type:vehicle_ac_type
		  },function(data){
			if(data!='false'){
			data=jQuery.parseJSON(data);
			$(id+' option').remove();
			 $(id).append($("<option rate='-1' additional_kilometer_rate='-1' minimum_kilometers='-1'></option>").attr("value",'-1').text('--Select Tariffs--'));
			i=0;//alert(data.data.length);
			for(var i=0;i<data.data.length;i++){
			if(tarif_id==data.data[i].id){
			var selected="selected=selected";
			}else{
			var selected="";
			}
			  $(id).append($("<option customer_id='"+customer_id+"' rate='"+data.data[i].rate+"' additional_kilometer_rate='"+data.data[i].additional_kilometer_rate+"' minimum_kilometers='"+data.data[i].minimum_kilometers+"' driver_bata='"+data.data[i].driver_bata+"' night_halt='"+data.data[i].night_halt+"' additional_hour_rate='"+data.data[i].additional_hour_rate+"' minimum_hours='"+data.data[i].minimum_hours+"' vehicle_model_id='"+data.data[i].vehicle_model_id+"' vehicle_ac_type_id ='"+data.data[i].vehicle_ac_type_id+"' tariff_master_id='"+data.data[i].tariff_master_id+"' "+selected+"></option>").attr("value",data.data[i].id).text(data.data[i].title));
				
			}
				customizedTariff();
			}else{
			 $(id+' option').remove();
			 $(id).append($("<option rate='-1' additional_kilometer_rate='-1' minimum_kilometers='-1'></option>").attr("value",'-1').text('--Select Tariffs--'));
				$('.display-me').css('display','none');
			}
			
		  });
		

}	

	$('#trip-tariff').change(function(){
		if($('#trip-tariff').val()!=-1){
			res=customizedTariff();
			if(res=true){
				var triptime=$('.triptime').val();
					if(triptime != ''){
				setHR_Tariff();
				setKM_Tariff();
				}
			}
		}
		
	});
	

	function customizedTariff(){
			var vehicle_model=$('#trip-tariff option:selected').attr('vehicle_model_id');
			var vehicle_ac_type=$('#trip-tariff option:selected').attr('vehicle_ac_type_id');
			var tariff_master_id=$('#trip-tariff option:selected').attr('tariff_master_id');
			var customer_id=$('#trip-tariff option:selected').attr('customer_id');

			 $.post(base_url+"/tarrif/customertariff",
			  {
				vehicle_model_id:vehicle_model,
				vehicle_ac_type_id:vehicle_ac_type,
				tariff_master_id:tariff_master_id,
				customer_id:customer_id,
				from:'trip-voucher'
			  },function(data){

			data=jQuery.parseJSON(data);
			if(data!=false){
				var additional_kilometer_rate = data.data[0].additional_kilometer_rate;
				var minimum_kilometers = data.data[0].minimum_kilometers;
				var additional_hour_rate = data.data[0].additional_hour_rate;
				var minimum_hours = data.data[0].minimum_hours;
				var rate = data.data[0].rate;
				var driver_bata=data.data[0].driver_bata;
				var night_halt=data.data[0].night_halt;
			}else{
		
				var additional_kilometer_rate = $('#trip-tariff option:selected').attr('additional_kilometer_rate');
				var minimum_kilometers = $('#trip-tariff option:selected').attr('minimum_kilometers');
				var additional_hour_rate = $('#trip-tariff option:selected').attr('additional_hour_rate');
				var minimum_hours = $('#trip-tariff option:selected').attr('minimum_hours');
				var rate = $('#trip-tariff option:selected').attr('rate');
				var driver_bata=$('#trip-tariff option:selected').attr('driver_bata');
				var night_halt=$('#trip-tariff option:selected').attr('night_halt');

			} 
			$('.basekm').val(minimum_kilometers);
			$('.basehrs').val(minimum_hours);
			$('.basehrsamount').val(rate);
			$('.basekmamount').val(rate);
			$('.driverbata').val(driver_bata);
			$('.nighthalt').val(night_halt);
			$('.adthrsrate').val(additional_hour_rate);
			$('.adtkmrate').val(additional_kilometer_rate);

			//driver km
			if($('.totaldriverkmamount').attr('totamountset')=='false'){
				$('.basedriverkm').val(minimum_kilometers);
				$('.basedriverkmamount').val(rate);
				$('.adtdriverkmrate').val(additional_kilometer_rate);
			}
			//driver hr
			if($('.totaldriverhramount').attr('totamountset')=='false'){
			$('.basedriverhrs').val(minimum_hours);
			$('.basedriverhrsamount').val(rate);
			$('.adtdriverhrrate').val(additional_hour_rate);
			}
			//vehicle km
			if($('.totalvehiclekmamount').attr('totamountset')=='false'){
				$('.basevehiclekm').val(minimum_kilometers);
				$('.basevehiclekmamount').val(rate);
				$('.adtvehiclekmrate').val(additional_kilometer_rate);
			}
			//vehicle hr
			if($('.totalvehiclehramount').attr('totamountset')=='false'){
				$('.basevehiclehrs').val(minimum_hours);
				$('.basevehiclehrsamount').val(rate);
				$('.adtvehiclehrrate').val(additional_hour_rate);
			}
		});
		return true;
	}


//KM tariff calculation
function setCustomKM_Tariff(whom)
{
	var basekm=$('.base'+whom+'km').val();
	var basekmamount=$('.base'+whom+'kmamount').val();
	var tariff_id=$('.trip-tariff').val();
	var adlkmrate=$('.adt'+whom+'kmrate').val();
	var totalkm=$('.totalkm').val();
	var noofdays=$('.daysno').val();
		
	if(totalkm != '' && Number(totalkm) > 0 && tariff_id!=-1){
	
	
		if(totalkm!='' && basekm!=''){
			if(noofdays==1){
				if(Number(totalkm) <= Number(basekm)){

					$('.adt'+whom+'km').val('');
					$('.adl'+whom+'kmrate').val('');
					$('.aditional'+whom+'kmamount').val('');
					$('.total'+whom+'kmamount').val(basekmamount);
			
				
				}else{
					
					var adtkm = totalkm-basekm;
					if(Number(adtkm)>0){
						$('.adt'+whom+'km').val(adtkm);
					}else{
						$('.adt'+whom+'km').val('');
					}

					if(basekmamount!='' && adlkmrate!=''){
						if(Number(adtkm)>0){
							var adtamt = Number(adtkm)*Number(adlkmrate);
							total_tarif = Number(basekmamount)+Number(adtamt);
							$('.aditional'+whom+'kmamount').val(adtamt);
							$('.total'+whom+'kmamount').val(total_tarif);
							

						}else{

							$('.aditional'+whom+'kmamount').val(adtamt);
							$('.total'+whom+'kmamount').val(total_tarif);
	
							
						}
					}
				}
			}else if(noofdays>1){
				mutipledaysbasekm=Number(basekm)*Number(noofdays);
				mutipledaysbasekmamount=Number(basekmamount)*Number(noofdays);
				if(Number(totalkm) <= Number(mutipledaysbasekm)){
					$('.adt'+whom+'km').val('');
					$('.adl'+whom+'kmrate').val('');
					$('.aditional'+whom+'kmamount').val('');
					$('.total'+whom+'kmamount').val(mutipledaysbasekmamount);

				
				}else{
					
					var adtkm = totalkm-mutipledaysbasekm;
					if(Number(adtkm)>0){
						$('.adt'+whom+'km').val(adtkm);
					}else{
						$('.adt'+whom+'km').val('');
					}

					if(basekmamount!='' && adlkmrate!=''){
						if(Number(adtkm)>0){
						var adtamt = adtkm*adlkmrate;
						total_tarif = Number(basekmamount)+Number(adtamt);
							$('.aditional'+whom+'kmamount').val(adtamt);
							$('.total'+whom+'kmamount').val(total_tarif);
							

						}else{

							$('.aditional'+whom+'kmamount').val(adtamt);
							$('.total'+whom+'kmamount').val(total_tarif);
	
							23
						}
					}
				}

			}
		}
		compareCustomAmounts(whom);
		calculateCommisionAmount('vehicle');
		calculateCommisionAmount('driver');
		//$('.kmhr').val( km_flag);
		//setTotalAmount();
		
	}else{
		//clearAllTariff();
	}
}
//Hours tariff calculation
function setCustomHR_Tariff(whom)
{
	
	var basehrs=$('.base'+whom+'hrs').val();
	var tariff_id=$('.trip-tariff').val();
	var basehrsamount=$('.base'+whom+'hrsamount').val();
	var adlhrrate=$('.adt'+whom+'hrrate').val();
	var triptime=$('.triptime').val();
	
	if(triptime != '' && tariff_id!=-1){

		if(triptime!='' && basehrs!=''){
			if(basehrs.indexOf(':')>-1 ){
				basehrs=basehrs.split(':');
				base=basehrs[0]+'.'+basehrs[1];
			}else{
				base=basehrs;

			}
			triptime=triptime.split(':');

			tottime=triptime[0]+'.'+triptime[1];
			if(Number(tottime) <= Number(base)){
				total_tarif = Number(basehrsamount);
				$('.adt'+whom+'hrs').val('');
				$('.adl'+whom+'hrrate').val('');
				$('.aditional'+whom+'hramount').val('');
				$('.total'+whom+'hramount').val(basehrsamount);
				
			}else{
				
				$('.adl'+whom+'hrrate').removeAttr('disabled');
				var adthrs=Number(tottime)-Number(base); //time difference
				
				adthrs=adthrs.toFixed(2);
				adthrsnew=adthrs.replace(/\./g, ':');
				

				if(basehrsamount!='' && adlhrrate!=''){

					var adtamt = calculateHrsAmount(adthrsnew,adlhrrate);
					total_tarif = Number(basehrsamount)+Number(adtamt);
				}
				
				if(Number(adthrs)>0){
					$('.adt'+whom+'hrs').val(adthrsnew);
					$('.aditional'+whom+'hramount').val(adtamt);
					$('.total'+whom+'hramount').val(total_tarif);
					
				}else{
					$('.adt'+whom+'hrs').val('');
					$('.aditional'+whom+'hramount').val('');
					$('.total'+whom+'hramount').val('');
					
					
				}	
			}	
			
		}
		compareCustomAmounts(whom);
		calculateCommisionAmount('vehicle');
		calculateCommisionAmount('driver');
		//$('.kmhr').val(hr_flag);
		//setTotalAmount();

	}else{
		//clearAllTariff();
	}
}


function compareCustomAmounts(whom){
var totalhramount=$('.total'+whom+'hramount').val();
var totalkmamount=$('.total'+whom+'kmamount').val();
var noofdays=$('.daysno').val();
	if(Number(noofdays)==1){
	if(totalhramount!='' && totalkmamount!=''){
		if(Number(totalhramount)>Number(totalkmamount)){
			$('.tot'+whom+'amount-radio-container2 > .iradio_minimal > .iCheck-helper').trigger('click');
		}else if(Number(totalhramount)<Number(totalkmamount)){
			$('.tot'+whom+'amount-radio-container1 > .iradio_minimal > .iCheck-helper').trigger('click');
		}

	}
	}else if(Number(noofdays)>1){
		$('.tot'+whom+'amount-radio-container1 > .iradio_minimal > .iCheck-helper').trigger('click');
	}
}

//set which amount is to select-driver

$('.totdriveramount-radio-container2 > .iradio_minimal > .iCheck-helper').click(function(){
$('.totaldriverkmamount').attr('amount-class-to-be-selected','totaldrivehramount');

});

$('.totdriveramount-radio-container1 > .iradio_minimal > .iCheck-helper').click(function(){

$('.totaldriverkmamount').attr('amount-class-to-be-selected','totaldrivekmamount');

});

//set which amount is to select-vehicle

$('.totvehicleamount-radio-container2 > .iradio_minimal > .iCheck-helper').click(function(){
$('.totalvehiclekmamount').attr('amount-class-to-be-selected','totalvehiclehramount');

});

$('.totvehicleamount-radio-container1 > .iradio_minimal > .iCheck-helper').click(function(){

$('.totalvehiclekmamount').attr('amount-class-to-be-selected','totalvehiclekmamount');

});



//km keyup event
$('.basedriverkm,.basedriverkmamount,.adtdriverkmrate').keyup(function(){
	
	setCustomKM_Tariff('driver');
});

$('.basevehiclekm,.basevehiclekmamount,.adtvehiclekmrate').keyup(function(){
	
	setCustomKM_Tariff('vehicle');
});

//hourly tariff calculation
$('.basedriverhrs,.basedriverhrsamount,.adtdriverhrrate').keyup(function(){
	
	setCustomHR_Tariff('driver');
});

$('.basevehiclehrs,.basevehiclehrsamount,.adtvehiclehrrate').keyup(function(){
	
	setCustomHR_Tariff('vehicle');

});

$('.driverkmcommisionpercentage,.driverhrcommisionpercentage').blur(function(){
	
	calculateCommisionAmount('driver');

});

$('.vehiclekmcommisionpercentage,.vehiclehrcommisionpercentage').blur(function(){
	
	calculateCommisionAmount('vehicle');

});


function calculateCommisionAmount(whom){

totkmamount=$('.total'+whom+'kmamount').val();
tothramount=$('.total'+whom+'hramount').val();

kmcommisionpercentage=$('.'+whom+'kmcommisionpercentage').val();
hrcommisionpercentage=$('.'+whom+'hrcommisionpercentage').val();

if(totkmamount!='' && tothramount!='' && kmcommisionpercentage!='' && hrcommisionpercentage!=''){


kmcommsn=Number(totkmamount)*(Number(kmcommisionpercentage)/100);
hrcommsn=Number(tothramount)*(Number(hrcommisionpercentage)/100);

$('.'+whom+'commisionkmamount').val(kmcommsn);
$('.'+whom+'commisionhramount').val(hrcommsn);

}

}

});

