--------------------10/10/2014---------------
/*completed*/
ALTER TABLE `trip_vouchers` ADD `no_of_days` INT NOT NULL AFTER `fuel_extra_charges`;
ALTER TABLE `drivers` CHANGE `date_of_joining` `date_of_joining` DATE NOT NULL ;
ALTER TABLE `vehicles` CHANGE `vehicle_manufacturing_year` `vehicle_manufacturing_year` INT NOT NULL ;
ALTER TABLE `tariffs` ADD `vehicle_model_id` INT NOT NULL AFTER `tariff_master_id` ,ADD INDEX ( `vehicle_model_id` ) ;
ALTER TABLE `trips` ADD `vehicle_model_id` INT NOT NULL AFTER `vehicle_make_id` ,ADD INDEX ( `vehicle_model_id` ) ;




/*20-Nov-2014*/
ALTER TABLE `trip_vouchers` ADD `delivery_no` INT( 11 ) NOT NULL COMMENT 'fa delivery number',
ADD `invoice_no` INT( 11 ) NOT NULL COMMENT 'fa invoice no',
ADD INDEX ( `delivery_no` , `invoice_no` ) ;


/*26-nov-2014*/
ALTER TABLE `2_debtor_trans` ADD `tax_group_id` INT(11) NOT NULL
/*need to b updated*/