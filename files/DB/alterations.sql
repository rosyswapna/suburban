--------------------10/10/2014---------------
/*completed*/
ALTER TABLE `trip_vouchers` ADD `no_of_days` INT NOT NULL AFTER `fuel_extra_charges`;
ALTER TABLE `drivers` CHANGE `date_of_joining` `date_of_joining` DATE NOT NULL ;
ALTER TABLE `vehicles` CHANGE `vehicle_manufacturing_year` `vehicle_manufacturing_year` INT NOT NULL ;
ALTER TABLE `tariffs` ADD `vehicle_model_id` INT NOT NULL AFTER `tariff_master_id` ,ADD INDEX ( `vehicle_model_id` ) ;
ALTER TABLE `trips` ADD `vehicle_model_id` INT NOT NULL AFTER `vehicle_make_id` ,ADD INDEX ( `vehicle_model_id` ) ;

/*need to b updated*/
