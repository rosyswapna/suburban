
----------------need to update in standard and arc--------------

--table vehicles--
ALTER TABLE `vehicles`  ADD `vehicle_percentage` INT(11) NOT NULL AFTER `tax_renewal_date`,  ADD `driver_percentage` INT(11) NOT NULL AFTER `vehicle_percentage`;

--trip expense--
ALTER TABLE `trip_vouchers`  ADD `trip_expense` TEXT NOT NULL AFTER `vehicle_trip_amount`;


--supplier group table
CREATE TABLE IF NOT EXISTS `supplier_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `value` int(11) DEFAULT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

--supplier group id in vehicles
ALTER TABLE `vehicles`  ADD `supplier_group_id` INT(11) NOT NULL AFTER `vehicle_owner_id`;



