ALTER TABLE `trips`  ADD `payment_no` INT(11) NOT NULL AFTER `advance_amount`;

//need to be updated 
CREATE TABLE IF NOT EXISTS `driver_statuses` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;
INSERT INTO `driver_statuses` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Owned', 'Owned', NULL, 1, 5, '2014-09-09 00:49:29', '0000-00-00 00:00:00'),
(2, 'Attached', 'Attached', NULL, 1, 5, '2014-09-09 00:50:04', '0000-00-00 00:00:00');

ALTER TABLE `drivers`  ADD `driver_status_id` INT(11) NOT NULL AFTER `minimum_working_days`;
ALTER TABLE `trip_vouchers` ADD `tax_group_id` INT(11) NOT NULL AFTER `id`;


ALTER TABLE `trips`  ADD `payment_no` INT(11) NOT NULL AFTER `advance_amount`;
ALTER TABLE `trip_vouchers` ADD UNIQUE `voucher_no` (`voucher_no`);

