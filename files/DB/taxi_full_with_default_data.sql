-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 04, 2015 at 04:33 PM
-- Server version: 5.5.40
-- PHP Version: 5.3.10-1ubuntu3.15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `travelERP`
--

-- --------------------------------------------------------

--
-- Table structure for table `0_areas`
--

CREATE TABLE IF NOT EXISTS `0_areas` (
  `area_code` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`area_code`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_areas`
--

INSERT INTO `0_areas` (`area_code`, `description`, `inactive`) VALUES
(1, 'Global', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_attachments`
--

CREATE TABLE IF NOT EXISTS `0_attachments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `type_no` int(11) NOT NULL DEFAULT '0',
  `trans_no` int(11) NOT NULL DEFAULT '0',
  `unique_name` varchar(60) NOT NULL DEFAULT '',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `filename` varchar(60) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `filetype` varchar(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type_no` (`type_no`,`trans_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_audit_trail`
--

CREATE TABLE IF NOT EXISTS `0_audit_trail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) unsigned NOT NULL DEFAULT '0',
  `trans_no` int(11) unsigned NOT NULL DEFAULT '0',
  `user` smallint(6) unsigned NOT NULL DEFAULT '0',
  `stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(60) DEFAULT NULL,
  `fiscal_year` int(11) NOT NULL,
  `gl_date` date NOT NULL DEFAULT '0000-00-00',
  `gl_seq` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Seq` (`fiscal_year`,`gl_date`,`gl_seq`),
  KEY `Type_and_Number` (`type`,`trans_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_bank_accounts`
--

CREATE TABLE IF NOT EXISTS `0_bank_accounts` (
  `account_code` varchar(15) NOT NULL DEFAULT '',
  `account_type` smallint(6) NOT NULL DEFAULT '0',
  `bank_account_name` varchar(60) NOT NULL DEFAULT '',
  `bank_account_number` varchar(100) NOT NULL DEFAULT '',
  `bank_name` varchar(60) NOT NULL DEFAULT '',
  `bank_address` tinytext,
  `bank_curr_code` char(3) NOT NULL DEFAULT '',
  `dflt_curr_act` tinyint(1) NOT NULL DEFAULT '0',
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `last_reconciled_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ending_reconcile_balance` double NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bank_account_name` (`bank_account_name`),
  KEY `bank_account_number` (`bank_account_number`),
  KEY `account_code` (`account_code`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_bank_trans`
--

CREATE TABLE IF NOT EXISTS `0_bank_trans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) DEFAULT NULL,
  `trans_no` int(11) DEFAULT NULL,
  `bank_act` varchar(15) NOT NULL DEFAULT '',
  `ref` varchar(40) DEFAULT NULL,
  `trans_date` date NOT NULL DEFAULT '0000-00-00',
  `amount` double DEFAULT NULL,
  `dimension_id` int(11) NOT NULL DEFAULT '0',
  `dimension2_id` int(11) NOT NULL DEFAULT '0',
  `person_type_id` int(11) NOT NULL DEFAULT '0',
  `person_id` tinyblob,
  `reconciled` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bank_act` (`bank_act`,`ref`),
  KEY `type` (`type`,`trans_no`),
  KEY `bank_act_2` (`bank_act`,`reconciled`),
  KEY `bank_act_3` (`bank_act`,`trans_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_bom`
--

CREATE TABLE IF NOT EXISTS `0_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` char(20) NOT NULL DEFAULT '',
  `component` char(20) NOT NULL DEFAULT '',
  `workcentre_added` int(11) NOT NULL DEFAULT '0',
  `loc_code` char(5) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`parent`,`component`,`workcentre_added`,`loc_code`),
  KEY `component` (`component`),
  KEY `id` (`id`),
  KEY `loc_code` (`loc_code`),
  KEY `parent` (`parent`,`loc_code`),
  KEY `workcentre_added` (`workcentre_added`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_budget_trans`
--

CREATE TABLE IF NOT EXISTS `0_budget_trans` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `type_no` bigint(16) NOT NULL DEFAULT '1',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `account` varchar(15) NOT NULL DEFAULT '',
  `memo_` tinytext NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `dimension_id` int(11) DEFAULT '0',
  `dimension2_id` int(11) DEFAULT '0',
  `person_type_id` int(11) DEFAULT NULL,
  `person_id` tinyblob,
  PRIMARY KEY (`counter`),
  KEY `Type_and_Number` (`type`,`type_no`),
  KEY `Account` (`account`,`tran_date`,`dimension_id`,`dimension2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_chart_class`
--

CREATE TABLE IF NOT EXISTS `0_chart_class` (
  `cid` varchar(3) NOT NULL,
  `class_name` varchar(60) NOT NULL DEFAULT '',
  `ctype` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_chart_class`
--

INSERT INTO `0_chart_class` (`cid`, `class_name`, `ctype`, `inactive`) VALUES
('1', 'Assets', 1, 0),
('2', 'Liabilities', 2, 0),
('3', 'Income', 4, 0),
('4', 'Costs', 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_chart_master`
--

CREATE TABLE IF NOT EXISTS `0_chart_master` (
  `account_code` varchar(15) NOT NULL DEFAULT '',
  `account_code2` varchar(15) NOT NULL DEFAULT '',
  `account_name` varchar(60) NOT NULL DEFAULT '',
  `account_type` varchar(10) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_code`),
  KEY `account_name` (`account_name`),
  KEY `accounts_by_type` (`account_type`,`account_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_chart_master`
--

INSERT INTO `0_chart_master` (`account_code`, `account_code2`, `account_name`, `account_type`, `inactive`) VALUES
('1060', '', 'Checking Account', '1', 0),
('1065', '', 'Petty Cash', '1', 0),
('1200', '', 'Accounts Receivables', '1', 0),
('1205', '', 'Allowance for doubtful accounts', '1', 0),
('1510', '', 'Inventory', '2', 0),
('1520', '', 'Stocks of Raw Materials', '2', 0),
('1530', '', 'Stocks of Work In Progress', '2', 0),
('1540', '', 'Stocks of Finsihed Goods', '2', 0),
('1550', '', 'Goods Received Clearing account', '2', 0),
('1820', '', 'Office Furniture &amp; Equipment', '3', 0),
('1825', '', 'Accum. Amort. -Furn. &amp; Equip.', '3', 0),
('1840', '', 'Vehicle', '3', 0),
('1845', '', 'Accum. Amort. -Vehicle', '3', 0),
('2100', '', 'Accounts Payable', '4', 0),
('2110', '', 'Accrued Income Tax - Federal', '4', 0),
('2120', '', 'Accrued Income Tax - State', '4', 0),
('2130', '', 'Accrued Franchise Tax', '4', 0),
('2140', '', 'Accrued Real &amp; Personal Prop Tax', '4', 0),
('2150', '', 'Sales Tax', '4', 0),
('2160', '', 'Accrued Use Tax Payable', '4', 0),
('2210', '', 'Accrued Wages', '4', 0),
('2220', '', 'Accrued Comp Time', '4', 0),
('2230', '', 'Accrued Holiday Pay', '4', 0),
('2240', '', 'Accrued Vacation Pay', '4', 0),
('2310', '', 'Accr. Benefits - 401K', '4', 0),
('2320', '', 'Accr. Benefits - Stock Purchase', '4', 0),
('2330', '', 'Accr. Benefits - Med, Den', '4', 0),
('2340', '', 'Accr. Benefits - Payroll Taxes', '4', 0),
('2350', '', 'Accr. Benefits - Credit Union', '4', 0),
('2360', '', 'Accr. Benefits - Savings Bond', '4', 0),
('2370', '', 'Accr. Benefits - Garnish', '4', 0),
('2380', '', 'Accr. Benefits - Charity Cont.', '4', 0),
('2620', '', 'Bank Loans', '5', 0),
('2680', '', 'Loans from Shareholders', '5', 0),
('3350', '', 'Common Shares', '6', 0),
('3590', '', 'Retained Earnings - prior years', '7', 0),
('4010', '', 'Sales', '8', 0),
('4430', '', 'Shipping &amp; Handling', '9', 0),
('4440', '', 'Interest', '9', 0),
('4450', '', 'Foreign Exchange Gain', '9', 0),
('4500', '', 'Prompt Payment Discounts', '9', 0),
('4510', '', 'Discounts Given', '9', 0),
('5010', '', 'Cost of Goods Sold - Retail', '10', 0),
('5020', '', 'Material Usage Varaiance', '10', 0),
('5030', '', 'Consumable Materials', '10', 0),
('5040', '', 'Purchase price Variance', '10', 0),
('5050', '', 'Purchases of materials', '10', 0),
('5060', '', 'Discounts Received', '10', 0),
('5100', '', 'Freight', '10', 0),
('5410', '', 'Wages &amp; Salaries', '11', 0),
('5420', '', 'Wages - Overtime', '11', 0),
('5430', '', 'Benefits - Comp Time', '11', 0),
('5440', '', 'Benefits - Payroll Taxes', '11', 0),
('5450', '', 'Benefits - Workers Comp', '11', 0),
('5460', '', 'Benefits - Pension', '11', 0),
('5470', '', 'Benefits - General Benefits', '11', 0),
('5510', '', 'Inc Tax Exp - Federal', '11', 0),
('5520', '', 'Inc Tax Exp - State', '11', 0),
('5530', '', 'Taxes - Real Estate', '11', 0),
('5540', '', 'Taxes - Personal Property', '11', 0),
('5550', '', 'Taxes - Franchise', '11', 0),
('5560', '', 'Taxes - Foreign Withholding', '11', 0),
('5610', '', 'Accounting &amp; Legal', '12', 0),
('5615', '', 'Advertising &amp; Promotions', '12', 0),
('5620', '', 'Bad Debts', '12', 0),
('5660', '', 'Amortization Expense', '12', 0),
('5685', '', 'Insurance', '12', 0),
('5690', '', 'Interest &amp; Bank Charges', '12', 0),
('5700', '', 'Office Supplies', '12', 0),
('5760', '', 'Rent', '12', 0),
('5765', '', 'Repair &amp; Maintenance', '12', 0),
('5780', '', 'Telephone', '12', 0),
('5785', '', 'Travel &amp; Entertainment', '12', 0),
('5790', '', 'Utilities', '12', 0),
('5795', '', 'Registrations', '12', 0),
('5800', '', 'Licenses', '12', 0),
('5810', '', 'Foreign Exchange Loss', '12', 0),
('9990', '', 'Year Profit/Loss', '12', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_chart_types`
--

CREATE TABLE IF NOT EXISTS `0_chart_types` (
  `id` varchar(10) NOT NULL,
  `name` varchar(60) NOT NULL DEFAULT '',
  `class_id` varchar(3) NOT NULL DEFAULT '',
  `parent` varchar(10) NOT NULL DEFAULT '-1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `class_id` (`class_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_chart_types`
--

INSERT INTO `0_chart_types` (`id`, `name`, `class_id`, `parent`, `inactive`) VALUES
('1', 'Current Assets', '1', '', 0),
('2', 'Inventory Assets', '1', '', 0),
('3', 'Capital Assets', '1', '', 0),
('4', 'Current Liabilities', '2', '', 0),
('5', 'Long Term Liabilities', '2', '', 0),
('6', 'Share Capital', '2', '', 0),
('7', 'Retained Earnings', '2', '', 0),
('8', 'Sales Revenue', '3', '', 0),
('9', 'Other Revenue', '3', '', 0),
('10', 'Cost of Goods Sold', '4', '', 0),
('11', 'Payroll Expenses', '4', '', 0),
('12', 'General &amp; Administrative expenses', '4', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_comments`
--

CREATE TABLE IF NOT EXISTS `0_comments` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date DEFAULT '0000-00-00',
  `memo_` tinytext,
  KEY `type_and_id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_credit_status`
--

CREATE TABLE IF NOT EXISTS `0_credit_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_description` char(100) NOT NULL DEFAULT '',
  `dissallow_invoices` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reason_description` (`reason_description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `0_credit_status`
--

INSERT INTO `0_credit_status` (`id`, `reason_description`, `dissallow_invoices`, `inactive`) VALUES
(1, 'Good History', 0, 0),
(3, 'No more work until payment received', 1, 0),
(4, 'In liquidation', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_crm_categories`
--

CREATE TABLE IF NOT EXISTS `0_crm_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pure technical key',
  `type` varchar(20) NOT NULL COMMENT 'contact type e.g. customer',
  `action` varchar(20) NOT NULL COMMENT 'detailed usage e.g. department',
  `name` varchar(30) NOT NULL COMMENT 'for category selector',
  `description` tinytext NOT NULL COMMENT 'usage description',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'nonzero for core system usage',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`action`),
  UNIQUE KEY `type_2` (`type`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `0_crm_categories`
--

INSERT INTO `0_crm_categories` (`id`, `type`, `action`, `name`, `description`, `system`, `inactive`) VALUES
(1, 'cust_branch', 'general', 'General', 'General contact data for customer branch (overrides company setting)', 1, 0),
(2, 'cust_branch', 'invoice', 'Invoices', 'Invoice posting (overrides company setting)', 1, 0),
(3, 'cust_branch', 'order', 'Orders', 'Order confirmation (overrides company setting)', 1, 0),
(4, 'cust_branch', 'delivery', 'Deliveries', 'Delivery coordination (overrides company setting)', 1, 0),
(5, 'customer', 'general', 'General', 'General contact data for customer', 1, 0),
(6, 'customer', 'order', 'Orders', 'Order confirmation', 1, 0),
(7, 'customer', 'delivery', 'Deliveries', 'Delivery coordination', 1, 0),
(8, 'customer', 'invoice', 'Invoices', 'Invoice posting', 1, 0),
(9, 'supplier', 'general', 'General', 'General contact data for supplier', 1, 0),
(10, 'supplier', 'order', 'Orders', 'Order confirmation', 1, 0),
(11, 'supplier', 'delivery', 'Deliveries', 'Delivery coordination', 1, 0),
(12, 'supplier', 'invoice', 'Invoices', 'Invoice posting', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_crm_contacts`
--

CREATE TABLE IF NOT EXISTS `0_crm_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0' COMMENT 'foreign key to crm_contacts',
  `type` varchar(20) NOT NULL COMMENT 'foreign key to crm_categories',
  `action` varchar(20) NOT NULL COMMENT 'foreign key to crm_categories',
  `entity_id` varchar(11) DEFAULT NULL COMMENT 'entity id in related class table',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_crm_persons`
--

CREATE TABLE IF NOT EXISTS `0_crm_persons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  `name2` varchar(60) DEFAULT NULL,
  `address` tinytext,
  `phone` varchar(30) DEFAULT NULL,
  `phone2` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `lang` char(5) DEFAULT NULL,
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ref` (`ref`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_currencies`
--

CREATE TABLE IF NOT EXISTS `0_currencies` (
  `currency` varchar(60) NOT NULL DEFAULT '',
  `curr_abrev` char(3) NOT NULL DEFAULT '',
  `curr_symbol` varchar(10) NOT NULL DEFAULT '',
  `country` varchar(100) NOT NULL DEFAULT '',
  `hundreds_name` varchar(15) NOT NULL DEFAULT '',
  `auto_update` tinyint(1) NOT NULL DEFAULT '1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`curr_abrev`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_currencies`
--

INSERT INTO `0_currencies` (`currency`, `curr_abrev`, `curr_symbol`, `country`, `hundreds_name`, `auto_update`, `inactive`) VALUES
('Indian Rupee', 'INR', '?', 'India', 'Rs', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_cust_allocations`
--

CREATE TABLE IF NOT EXISTS `0_cust_allocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` double unsigned DEFAULT NULL,
  `date_alloc` date NOT NULL DEFAULT '0000-00-00',
  `trans_no_from` int(11) DEFAULT NULL,
  `trans_type_from` int(11) DEFAULT NULL,
  `trans_no_to` int(11) DEFAULT NULL,
  `trans_type_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `From` (`trans_type_from`,`trans_no_from`),
  KEY `To` (`trans_type_to`,`trans_no_to`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_cust_branch`
--

CREATE TABLE IF NOT EXISTS `0_cust_branch` (
  `branch_code` int(11) NOT NULL AUTO_INCREMENT,
  `debtor_no` int(11) NOT NULL DEFAULT '0',
  `br_name` varchar(60) NOT NULL DEFAULT '',
  `branch_ref` varchar(30) NOT NULL DEFAULT '',
  `br_address` tinytext NOT NULL,
  `area` int(11) DEFAULT NULL,
  `salesman` int(11) NOT NULL DEFAULT '0',
  `contact_name` varchar(60) NOT NULL DEFAULT '',
  `default_location` varchar(5) NOT NULL DEFAULT '',
  `tax_group_id` int(11) DEFAULT NULL,
  `sales_account` varchar(15) NOT NULL DEFAULT '',
  `sales_discount_account` varchar(15) NOT NULL DEFAULT '',
  `receivables_account` varchar(15) NOT NULL DEFAULT '',
  `payment_discount_account` varchar(15) NOT NULL DEFAULT '',
  `default_ship_via` int(11) NOT NULL DEFAULT '1',
  `disable_trans` tinyint(4) NOT NULL DEFAULT '0',
  `br_post_address` tinytext NOT NULL,
  `group_no` int(11) NOT NULL DEFAULT '0',
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`branch_code`,`debtor_no`),
  KEY `branch_code` (`branch_code`),
  KEY `branch_ref` (`branch_ref`),
  KEY `group_no` (`group_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_debtors_master`
--

CREATE TABLE IF NOT EXISTS `0_debtors_master` (
  `debtor_no` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `debtor_ref` varchar(30) NOT NULL,
  `address` tinytext,
  `tax_id` varchar(55) NOT NULL DEFAULT '',
  `curr_code` char(3) NOT NULL DEFAULT '',
  `sales_type` int(11) NOT NULL DEFAULT '1',
  `dimension_id` int(11) NOT NULL DEFAULT '0',
  `dimension2_id` int(11) NOT NULL DEFAULT '0',
  `credit_status` int(11) NOT NULL DEFAULT '0',
  `payment_terms` int(11) DEFAULT NULL,
  `discount` double NOT NULL DEFAULT '0',
  `pymt_discount` double NOT NULL DEFAULT '0',
  `credit_limit` float NOT NULL DEFAULT '1000',
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`debtor_no`),
  UNIQUE KEY `debtor_ref` (`debtor_ref`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_debtor_trans`
--

CREATE TABLE IF NOT EXISTS `0_debtor_trans` (
  `trans_no` int(11) unsigned NOT NULL DEFAULT '0',
  `type` smallint(6) unsigned NOT NULL DEFAULT '0',
  `version` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `debtor_no` int(11) unsigned DEFAULT NULL,
  `branch_code` int(11) NOT NULL DEFAULT '-1',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `reference` varchar(60) NOT NULL DEFAULT '',
  `tpe` int(11) NOT NULL DEFAULT '0',
  `order_` int(11) NOT NULL DEFAULT '0',
  `ov_amount` double NOT NULL DEFAULT '0',
  `ov_gst` double NOT NULL DEFAULT '0',
  `ov_freight` double NOT NULL DEFAULT '0',
  `ov_freight_tax` double NOT NULL DEFAULT '0',
  `ov_discount` double NOT NULL DEFAULT '0',
  `alloc` double NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '1',
  `ship_via` int(11) DEFAULT NULL,
  `dimension_id` int(11) NOT NULL DEFAULT '0',
  `dimension2_id` int(11) NOT NULL DEFAULT '0',
  `payment_terms` int(11) DEFAULT NULL,
  `tax_group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`trans_no`),
  KEY `debtor_no` (`debtor_no`,`branch_code`),
  KEY `tran_date` (`tran_date`),
  KEY `order_` (`order_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_debtor_trans_details`
--

CREATE TABLE IF NOT EXISTS `0_debtor_trans_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debtor_trans_no` int(11) DEFAULT NULL,
  `debtor_trans_type` int(11) DEFAULT NULL,
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `unit_price` double NOT NULL DEFAULT '0',
  `unit_taxable_amount` double NOT NULL DEFAULT '0',
  `unit_tax` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discount_percent` double NOT NULL DEFAULT '0',
  `standard_cost` double NOT NULL DEFAULT '0',
  `qty_done` double NOT NULL DEFAULT '0',
  `src_id` int(11) NOT NULL,
  `trip_voucher` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Transaction` (`debtor_trans_type`,`debtor_trans_no`),
  KEY `src_id` (`src_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_dimensions`
--

CREATE TABLE IF NOT EXISTS `0_dimensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(60) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `type_` tinyint(1) NOT NULL DEFAULT '1',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `date_` (`date_`),
  KEY `due_date` (`due_date`),
  KEY `type_` (`type_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_exchange_rates`
--

CREATE TABLE IF NOT EXISTS `0_exchange_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curr_code` char(3) NOT NULL DEFAULT '',
  `rate_buy` double NOT NULL DEFAULT '0',
  `rate_sell` double NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `curr_code` (`curr_code`,`date_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_fiscal_year`
--

CREATE TABLE IF NOT EXISTS `0_fiscal_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT '0000-00-00',
  `end` date DEFAULT '0000-00-00',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `begin` (`begin`),
  UNIQUE KEY `end` (`end`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `0_fiscal_year`
--

INSERT INTO `0_fiscal_year` (`id`, `begin`, `end`, `closed`) VALUES
(1, '2014-04-01', '2015-03-31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_gl_trans`
--

CREATE TABLE IF NOT EXISTS `0_gl_trans` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `type_no` bigint(16) NOT NULL DEFAULT '1',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `account` varchar(15) NOT NULL DEFAULT '',
  `memo_` tinytext NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `dimension_id` int(11) NOT NULL DEFAULT '0',
  `dimension2_id` int(11) NOT NULL DEFAULT '0',
  `person_type_id` int(11) DEFAULT NULL,
  `person_id` tinyblob,
  PRIMARY KEY (`counter`),
  KEY `Type_and_Number` (`type`,`type_no`),
  KEY `dimension_id` (`dimension_id`),
  KEY `dimension2_id` (`dimension2_id`),
  KEY `tran_date` (`tran_date`),
  KEY `account_and_tran_date` (`account`,`tran_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_grn_batch`
--

CREATE TABLE IF NOT EXISTS `0_grn_batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL DEFAULT '0',
  `purch_order_no` int(11) DEFAULT NULL,
  `reference` varchar(60) NOT NULL DEFAULT '',
  `delivery_date` date NOT NULL DEFAULT '0000-00-00',
  `loc_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_date` (`delivery_date`),
  KEY `purch_order_no` (`purch_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_grn_items`
--

CREATE TABLE IF NOT EXISTS `0_grn_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grn_batch_id` int(11) DEFAULT NULL,
  `po_detail_item` int(11) NOT NULL DEFAULT '0',
  `item_code` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `qty_recd` double NOT NULL DEFAULT '0',
  `quantity_inv` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `grn_batch_id` (`grn_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_groups`
--

CREATE TABLE IF NOT EXISTS `0_groups` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `0_groups`
--

INSERT INTO `0_groups` (`id`, `description`, `inactive`) VALUES
(1, 'Small', 0),
(2, 'Medium', 0),
(3, 'Large', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_item_codes`
--

CREATE TABLE IF NOT EXISTS `0_item_codes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_code` varchar(20) NOT NULL,
  `stock_id` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  `category_id` smallint(6) unsigned NOT NULL,
  `quantity` double NOT NULL DEFAULT '1',
  `is_foreign` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stock_id` (`stock_id`,`item_code`),
  KEY `item_code` (`item_code`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_item_tax_types`
--

CREATE TABLE IF NOT EXISTS `0_item_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `exempt` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_item_tax_types`
--

INSERT INTO `0_item_tax_types` (`id`, `name`, `exempt`, `inactive`) VALUES
(1, 'Regular', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_item_tax_type_exemptions`
--

CREATE TABLE IF NOT EXISTS `0_item_tax_type_exemptions` (
  `item_tax_type_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_tax_type_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_item_units`
--

CREATE TABLE IF NOT EXISTS `0_item_units` (
  `abbr` varchar(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `decimals` tinyint(2) NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`abbr`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_item_units`
--

INSERT INTO `0_item_units` (`abbr`, `name`, `decimals`, `inactive`) VALUES
('km', 'Kilometer', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_locations`
--

CREATE TABLE IF NOT EXISTS `0_locations` (
  `loc_code` varchar(5) NOT NULL DEFAULT '',
  `location_name` varchar(60) NOT NULL DEFAULT '',
  `delivery_address` tinytext NOT NULL,
  `phone` varchar(30) NOT NULL DEFAULT '',
  `phone2` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loc_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_locations`
--

INSERT INTO `0_locations` (`loc_code`, `location_name`, `delivery_address`, `phone`, `phone2`, `fax`, `email`, `contact`, `inactive`) VALUES
('DEF', 'Default', 'N/A', '', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_loc_stock`
--

CREATE TABLE IF NOT EXISTS `0_loc_stock` (
  `loc_code` char(5) NOT NULL DEFAULT '',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `reorder_level` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loc_code`,`stock_id`),
  KEY `stock_id` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_movement_types`
--

CREATE TABLE IF NOT EXISTS `0_movement_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_movement_types`
--

INSERT INTO `0_movement_types` (`id`, `name`, `inactive`) VALUES
(1, 'Adjustment', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_payment_terms`
--

CREATE TABLE IF NOT EXISTS `0_payment_terms` (
  `terms_indicator` int(11) NOT NULL AUTO_INCREMENT,
  `terms` char(80) NOT NULL DEFAULT '',
  `days_before_due` smallint(6) NOT NULL DEFAULT '0',
  `day_in_following_month` smallint(6) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`terms_indicator`),
  UNIQUE KEY `terms` (`terms`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `0_payment_terms`
--

INSERT INTO `0_payment_terms` (`terms_indicator`, `terms`, `days_before_due`, `day_in_following_month`, `inactive`) VALUES
(1, 'Due 15th Of the Following Month', 0, 17, 0),
(2, 'Due By End Of The Following Month', 0, 30, 0),
(3, 'Payment due within 10 days', 10, 0, 0),
(4, 'Cash Only', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_prices`
--

CREATE TABLE IF NOT EXISTS `0_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `sales_type_id` int(11) NOT NULL DEFAULT '0',
  `curr_abrev` char(3) NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `price` (`stock_id`,`sales_type_id`,`curr_abrev`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_printers`
--

CREATE TABLE IF NOT EXISTS `0_printers` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(60) NOT NULL,
  `queue` varchar(20) NOT NULL,
  `host` varchar(40) NOT NULL,
  `port` smallint(11) unsigned NOT NULL,
  `timeout` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `0_printers`
--

INSERT INTO `0_printers` (`id`, `name`, `description`, `queue`, `host`, `port`, `timeout`) VALUES
(1, 'QL500', 'Label printer', 'QL500', 'server', 127, 20),
(2, 'Samsung', 'Main network printer', 'scx4521F', 'server', 515, 5),
(3, 'Local', 'Local print server at user IP', 'lp', '', 515, 10);

-- --------------------------------------------------------

--
-- Table structure for table `0_print_profiles`
--

CREATE TABLE IF NOT EXISTS `0_print_profiles` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `profile` varchar(30) NOT NULL,
  `report` varchar(5) DEFAULT NULL,
  `printer` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile` (`profile`,`report`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `0_print_profiles`
--

INSERT INTO `0_print_profiles` (`id`, `profile`, `report`, `printer`) VALUES
(1, 'Out of office', '', 0),
(2, 'Sales Department', '', 0),
(3, 'Central', '', 2),
(4, 'Sales Department', '104', 2),
(5, 'Sales Department', '105', 2),
(6, 'Sales Department', '107', 2),
(7, 'Sales Department', '109', 2),
(8, 'Sales Department', '110', 2),
(9, 'Sales Department', '201', 2);

-- --------------------------------------------------------

--
-- Table structure for table `0_purch_data`
--

CREATE TABLE IF NOT EXISTS `0_purch_data` (
  `supplier_id` int(11) NOT NULL DEFAULT '0',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `suppliers_uom` char(50) NOT NULL DEFAULT '',
  `conversion_factor` double NOT NULL DEFAULT '1',
  `supplier_description` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`supplier_id`,`stock_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_purch_orders`
--

CREATE TABLE IF NOT EXISTS `0_purch_orders` (
  `order_no` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL DEFAULT '0',
  `comments` tinytext,
  `ord_date` date NOT NULL DEFAULT '0000-00-00',
  `reference` tinytext NOT NULL,
  `requisition_no` tinytext,
  `into_stock_location` varchar(5) NOT NULL DEFAULT '',
  `delivery_address` tinytext NOT NULL,
  `total` double NOT NULL DEFAULT '0',
  `tax_included` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_no`),
  KEY `ord_date` (`ord_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_purch_order_details`
--

CREATE TABLE IF NOT EXISTS `0_purch_order_details` (
  `po_detail_item` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL DEFAULT '0',
  `item_code` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `delivery_date` date NOT NULL DEFAULT '0000-00-00',
  `qty_invoiced` double NOT NULL DEFAULT '0',
  `unit_price` double NOT NULL DEFAULT '0',
  `act_price` double NOT NULL DEFAULT '0',
  `std_cost_unit` double NOT NULL DEFAULT '0',
  `quantity_ordered` double NOT NULL DEFAULT '0',
  `quantity_received` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`po_detail_item`),
  KEY `order` (`order_no`,`po_detail_item`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_quick_entries`
--

CREATE TABLE IF NOT EXISTS `0_quick_entries` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(60) NOT NULL,
  `base_amount` double NOT NULL DEFAULT '0',
  `base_desc` varchar(60) DEFAULT NULL,
  `bal_type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `0_quick_entries`
--

INSERT INTO `0_quick_entries` (`id`, `type`, `description`, `base_amount`, `base_desc`, `bal_type`) VALUES
(1, 1, 'Maintenance', 0, 'Amount', 0),
(2, 4, 'Phone', 0, 'Amount', 0),
(3, 2, 'Cash Sales', 0, 'Amount', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_quick_entry_lines`
--

CREATE TABLE IF NOT EXISTS `0_quick_entry_lines` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `qid` smallint(6) unsigned NOT NULL,
  `amount` double DEFAULT '0',
  `action` varchar(2) NOT NULL,
  `dest_id` varchar(15) NOT NULL DEFAULT '',
  `dimension_id` smallint(6) unsigned DEFAULT NULL,
  `dimension2_id` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `qid` (`qid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `0_quick_entry_lines`
--

INSERT INTO `0_quick_entry_lines` (`id`, `qid`, `amount`, `action`, `dest_id`, `dimension_id`, `dimension2_id`) VALUES
(1, 1, 0, 't-', '1', 0, 0),
(2, 2, 0, 't-', '1', 0, 0),
(3, 3, 0, 't-', '1', 0, 0),
(4, 3, 0, '=', '4010', 0, 0),
(5, 1, 0, '=', '5765', 0, 0),
(6, 2, 0, '=', '5780', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_recurrent_invoices`
--

CREATE TABLE IF NOT EXISTS `0_recurrent_invoices` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `order_no` int(11) unsigned NOT NULL,
  `debtor_no` int(11) unsigned DEFAULT NULL,
  `group_no` smallint(6) unsigned DEFAULT NULL,
  `days` int(11) NOT NULL DEFAULT '0',
  `monthly` int(11) NOT NULL DEFAULT '0',
  `begin` date NOT NULL DEFAULT '0000-00-00',
  `end` date NOT NULL DEFAULT '0000-00-00',
  `last_sent` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_refs`
--

CREATE TABLE IF NOT EXISTS `0_refs` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`type`),
  KEY `Type_and_Reference` (`type`,`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_salesman`
--

CREATE TABLE IF NOT EXISTS `0_salesman` (
  `salesman_code` int(11) NOT NULL AUTO_INCREMENT,
  `salesman_name` char(60) NOT NULL DEFAULT '',
  `salesman_phone` char(30) NOT NULL DEFAULT '',
  `salesman_fax` char(30) NOT NULL DEFAULT '',
  `salesman_email` varchar(100) NOT NULL DEFAULT '',
  `provision` double NOT NULL DEFAULT '0',
  `break_pt` double NOT NULL DEFAULT '0',
  `provision2` double NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`salesman_code`),
  UNIQUE KEY `salesman_name` (`salesman_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_salesman`
--

INSERT INTO `0_salesman` (`salesman_code`, `salesman_name`, `salesman_phone`, `salesman_fax`, `salesman_email`, `provision`, `break_pt`, `provision2`, `inactive`) VALUES
(1, 'Sales Person', '', '', '', 5, 1000, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_sales_orders`
--

CREATE TABLE IF NOT EXISTS `0_sales_orders` (
  `order_no` int(11) NOT NULL,
  `trans_type` smallint(6) NOT NULL DEFAULT '30',
  `version` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `debtor_no` int(11) NOT NULL DEFAULT '0',
  `branch_code` int(11) NOT NULL DEFAULT '0',
  `reference` varchar(100) NOT NULL DEFAULT '',
  `customer_ref` tinytext NOT NULL,
  `comments` tinytext,
  `ord_date` date NOT NULL DEFAULT '0000-00-00',
  `order_type` int(11) NOT NULL DEFAULT '0',
  `ship_via` int(11) NOT NULL DEFAULT '0',
  `delivery_address` tinytext NOT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `deliver_to` tinytext NOT NULL,
  `freight_cost` double NOT NULL DEFAULT '0',
  `from_stk_loc` varchar(5) NOT NULL DEFAULT '',
  `delivery_date` date NOT NULL DEFAULT '0000-00-00',
  `payment_terms` int(11) DEFAULT NULL,
  `total` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`trans_type`,`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_sales_order_details`
--

CREATE TABLE IF NOT EXISTS `0_sales_order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL DEFAULT '0',
  `trans_type` smallint(6) NOT NULL DEFAULT '30',
  `stk_code` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `qty_sent` double NOT NULL DEFAULT '0',
  `unit_price` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discount_percent` double NOT NULL DEFAULT '0',
  `trip_voucher` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sorder` (`trans_type`,`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_sales_pos`
--

CREATE TABLE IF NOT EXISTS `0_sales_pos` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `pos_name` varchar(30) NOT NULL,
  `cash_sale` tinyint(1) NOT NULL,
  `credit_sale` tinyint(1) NOT NULL,
  `pos_location` varchar(5) NOT NULL,
  `pos_account` smallint(6) unsigned NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pos_name` (`pos_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_sales_pos`
--

INSERT INTO `0_sales_pos` (`id`, `pos_name`, `cash_sale`, `credit_sale`, `pos_location`, `pos_account`, `inactive`) VALUES
(1, 'Default', 1, 1, 'DEF', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_sales_types`
--

CREATE TABLE IF NOT EXISTS `0_sales_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sales_type` char(50) NOT NULL DEFAULT '',
  `tax_included` int(1) NOT NULL DEFAULT '0',
  `factor` double NOT NULL DEFAULT '1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sales_type` (`sales_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `0_sales_types`
--

INSERT INTO `0_sales_types` (`id`, `sales_type`, `tax_included`, `factor`, `inactive`) VALUES
(1, 'Retail', 1, 1, 0),
(2, 'Wholesale', 0, 0.7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_security_roles`
--

CREATE TABLE IF NOT EXISTS `0_security_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(30) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `sections` text,
  `areas` text,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `0_security_roles`
--

INSERT INTO `0_security_roles` (`id`, `role`, `description`, `sections`, `areas`, `inactive`) VALUES
(1, 'Inquiries', 'Inquiries', '768;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15872;16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;773;774;2822;3073;3075;3076;3077;3329;3330;3331;3332;3333;3334;3335;5377;5633;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8450;8451;10497;10753;11009;11010;11012;13313;13315;15617;15618;15619;15620;15621;15622;15623;15624;15625;15626;15873;15882;16129;16130;16131;16132', 1),
(2, 'System Administrator', 'System Administrator', '256;512;768;2816;3072;3328;5376;5632;5888;7936;8192;8448;10496;10752;11008;13056;13312;15616;15872;16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;526;769;770;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5641;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11011;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15628;15625;15626;15627;15873;15874;15875;15876;15877;15878;15879;15880;15883;15881;15882;16129;16130;16131;16132', 0),
(3, 'Salesman', 'Salesman', '768;3072;5632;8192;15872', '773;774;3073;3075;3081;5633;8194;15873', 0),
(4, 'Stock Manager', 'Stock Manager', '2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15872;16128', '2818;2822;3073;3076;3077;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5640;5889;5890;5891;8193;8194;8450;8451;10753;11009;11010;11012;13313;13315;15882;16129;16130;16131;16132', 1),
(5, 'Production Manager', 'Production Manager', '512;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;2818;2819;2820;2821;2822;2823;3073;3074;3076;3077;3078;3079;3080;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5640;5640;5889;5890;5891;8193;8194;8196;8197;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(6, 'Purchase Officer', 'Purchase Officer', '512;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;2818;2819;2820;2821;2822;2823;3073;3074;3076;3077;3078;3079;3080;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5377;5633;5635;5640;5640;5889;5890;5891;8193;8194;8196;8197;8449;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(7, 'AR Officer', 'AR Officer', '512;768;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;771;773;774;2818;2819;2820;2821;2822;2823;3073;3073;3074;3075;3076;3077;3078;3079;3080;3081;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5633;5634;5637;5638;5639;5640;5640;5889;5890;5891;8193;8194;8194;8196;8197;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15873;15876;15877;15878;15880;15882;16129;16130;16131;16132', 1),
(8, 'AP Officer', 'AP Officer', '512;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '257;258;259;260;521;523;524;769;770;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3082;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5635;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13057;13313;13315;15617;15619;15620;15621;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(9, 'Accountant', 'New Accountant', '512;768;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '257;258;259;260;521;523;524;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5637;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13313;13315;15617;15618;15619;15620;15621;15624;15873;15876;15877;15878;15880;15882;16129;16130;16131;16132', 1),
(10, 'Frontdesk', 'Frontdesk', '512;768;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '257;258;259;260;521;523;524;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5637;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13057;13313;13315;15617;15619;15620;15621;15624;15873;15874;15876;15877;15878;15879;15880;15882;16129;16130;16131;16132', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_shippers`
--

CREATE TABLE IF NOT EXISTS `0_shippers` (
  `shipper_id` int(11) NOT NULL AUTO_INCREMENT,
  `shipper_name` varchar(60) NOT NULL DEFAULT '',
  `phone` varchar(30) NOT NULL DEFAULT '',
  `phone2` varchar(30) NOT NULL DEFAULT '',
  `contact` tinytext NOT NULL,
  `address` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipper_id`),
  UNIQUE KEY `name` (`shipper_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_shippers`
--

INSERT INTO `0_shippers` (`shipper_id`, `shipper_name`, `phone`, `phone2`, `contact`, `address`, `inactive`) VALUES
(1, 'Default', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_sql_trail`
--

CREATE TABLE IF NOT EXISTS `0_sql_trail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sql` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_stock_category`
--

CREATE TABLE IF NOT EXISTS `0_stock_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `dflt_tax_type` int(11) NOT NULL DEFAULT '1',
  `dflt_units` varchar(20) NOT NULL DEFAULT 'each',
  `dflt_mb_flag` char(1) NOT NULL DEFAULT 'B',
  `dflt_sales_act` varchar(15) NOT NULL DEFAULT '',
  `dflt_cogs_act` varchar(15) NOT NULL DEFAULT '',
  `dflt_inventory_act` varchar(15) NOT NULL DEFAULT '',
  `dflt_adjustment_act` varchar(15) NOT NULL DEFAULT '',
  `dflt_assembly_act` varchar(15) NOT NULL DEFAULT '',
  `dflt_dim1` int(11) DEFAULT NULL,
  `dflt_dim2` int(11) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `dflt_no_sale` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_stock_category`
--

INSERT INTO `0_stock_category` (`category_id`, `description`, `dflt_tax_type`, `dflt_units`, `dflt_mb_flag`, `dflt_sales_act`, `dflt_cogs_act`, `dflt_inventory_act`, `dflt_adjustment_act`, `dflt_assembly_act`, `dflt_dim1`, `dflt_dim2`, `inactive`, `dflt_no_sale`) VALUES
(1, 'Services', 1, 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_stock_master`
--

CREATE TABLE IF NOT EXISTS `0_stock_master` (
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(200) NOT NULL DEFAULT '',
  `long_description` tinytext NOT NULL,
  `units` varchar(20) NOT NULL DEFAULT 'each',
  `mb_flag` char(1) NOT NULL DEFAULT 'B',
  `sales_account` varchar(15) NOT NULL DEFAULT '',
  `cogs_account` varchar(15) NOT NULL DEFAULT '',
  `inventory_account` varchar(15) NOT NULL DEFAULT '',
  `adjustment_account` varchar(15) NOT NULL DEFAULT '',
  `assembly_account` varchar(15) NOT NULL DEFAULT '',
  `dimension_id` int(11) DEFAULT NULL,
  `dimension2_id` int(11) DEFAULT NULL,
  `actual_cost` double NOT NULL DEFAULT '0',
  `last_cost` double NOT NULL DEFAULT '0',
  `material_cost` double NOT NULL DEFAULT '0',
  `labour_cost` double NOT NULL DEFAULT '0',
  `overhead_cost` double NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `no_sale` tinyint(1) NOT NULL DEFAULT '0',
  `editable` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_stock_moves`
--

CREATE TABLE IF NOT EXISTS `0_stock_moves` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_no` int(11) NOT NULL DEFAULT '0',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `loc_code` char(5) NOT NULL DEFAULT '',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `person_id` int(11) DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `reference` char(40) NOT NULL DEFAULT '',
  `qty` double NOT NULL DEFAULT '1',
  `discount_percent` double NOT NULL DEFAULT '0',
  `standard_cost` double NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`trans_id`),
  KEY `type` (`type`,`trans_no`),
  KEY `Move` (`stock_id`,`loc_code`,`tran_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_suppliers`
--

CREATE TABLE IF NOT EXISTS `0_suppliers` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `supp_name` varchar(60) NOT NULL DEFAULT '',
  `supp_ref` varchar(30) NOT NULL DEFAULT '',
  `address` tinytext NOT NULL,
  `supp_address` tinytext NOT NULL,
  `gst_no` varchar(25) NOT NULL DEFAULT '',
  `contact` varchar(60) NOT NULL DEFAULT '',
  `supp_account_no` varchar(40) NOT NULL DEFAULT '',
  `website` varchar(100) NOT NULL DEFAULT '',
  `bank_account` varchar(60) NOT NULL DEFAULT '',
  `curr_code` char(3) DEFAULT NULL,
  `payment_terms` int(11) DEFAULT NULL,
  `tax_included` tinyint(1) NOT NULL DEFAULT '0',
  `dimension_id` int(11) DEFAULT '0',
  `dimension2_id` int(11) DEFAULT '0',
  `tax_group_id` int(11) DEFAULT NULL,
  `credit_limit` double NOT NULL DEFAULT '0',
  `purchase_account` varchar(15) NOT NULL DEFAULT '',
  `payable_account` varchar(15) NOT NULL DEFAULT '',
  `payment_discount_account` varchar(15) NOT NULL DEFAULT '',
  `salary_account` varchar(15) NOT NULL DEFAULT '',
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`supplier_id`),
  KEY `supp_ref` (`supp_ref`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_supp_allocations`
--

CREATE TABLE IF NOT EXISTS `0_supp_allocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` double unsigned DEFAULT NULL,
  `date_alloc` date NOT NULL DEFAULT '0000-00-00',
  `trans_no_from` int(11) DEFAULT NULL,
  `trans_type_from` int(11) DEFAULT NULL,
  `trans_no_to` int(11) DEFAULT NULL,
  `trans_type_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `From` (`trans_type_from`,`trans_no_from`),
  KEY `To` (`trans_type_to`,`trans_no_to`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_supp_invoice_items`
--

CREATE TABLE IF NOT EXISTS `0_supp_invoice_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supp_trans_no` int(11) DEFAULT NULL,
  `supp_trans_type` int(11) DEFAULT NULL,
  `gl_code` varchar(15) NOT NULL DEFAULT '',
  `grn_item_id` int(11) DEFAULT NULL,
  `po_detail_item_id` int(11) DEFAULT NULL,
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `quantity` double NOT NULL DEFAULT '0',
  `unit_price` double NOT NULL DEFAULT '0',
  `unit_tax` double NOT NULL DEFAULT '0',
  `memo_` tinytext,
  PRIMARY KEY (`id`),
  KEY `Transaction` (`supp_trans_type`,`supp_trans_no`,`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_supp_trans`
--

CREATE TABLE IF NOT EXISTS `0_supp_trans` (
  `trans_no` int(11) unsigned NOT NULL DEFAULT '0',
  `type` smallint(6) unsigned NOT NULL DEFAULT '0',
  `supplier_id` int(11) unsigned DEFAULT NULL,
  `reference` tinytext NOT NULL,
  `supp_reference` varchar(60) NOT NULL DEFAULT '',
  `tran_date` date NOT NULL DEFAULT '0000-00-00',
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `ov_amount` double NOT NULL DEFAULT '0',
  `ov_discount` double NOT NULL DEFAULT '0',
  `ov_gst` double NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '1',
  `alloc` double NOT NULL DEFAULT '0',
  `tax_included` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`trans_no`),
  KEY `supplier_id` (`supplier_id`),
  KEY `SupplierID_2` (`supplier_id`,`supp_reference`),
  KEY `type` (`type`),
  KEY `tran_date` (`tran_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_sys_prefs`
--

CREATE TABLE IF NOT EXISTS `0_sys_prefs` (
  `name` varchar(35) NOT NULL DEFAULT '',
  `category` varchar(30) DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `length` smallint(6) DEFAULT NULL,
  `value` tinytext,
  PRIMARY KEY (`name`),
  KEY `category` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_sys_prefs`
--

INSERT INTO `0_sys_prefs` (`name`, `category`, `type`, `length`, `value`) VALUES
('coy_name', 'setup.company', 'varchar', 60, 'Company name'),
('gst_no', 'setup.company', 'varchar', 25, ''),
('coy_no', 'setup.company', 'varchar', 25, ''),
('tax_prd', 'setup.company', 'int', 11, '1'),
('tax_last', 'setup.company', 'int', 11, '1'),
('postal_address', 'setup.company', 'tinytext', 0, 'N/A'),
('phone', 'setup.company', 'varchar', 30, ''),
('fax', 'setup.company', 'varchar', 30, ''),
('email', 'setup.company', 'varchar', 100, ''),
('coy_logo', 'setup.company', 'varchar', 100, ''),
('domicile', 'setup.company', 'varchar', 55, ''),
('curr_default', 'setup.company', 'char', 3, 'INR'),
('use_dimension', 'setup.company', 'tinyint', 1, '1'),
('f_year', 'setup.company', 'int', 11, '6'),
('no_item_list', 'setup.company', 'tinyint', 1, '0'),
('no_customer_list', 'setup.company', 'tinyint', 1, '0'),
('no_supplier_list', 'setup.company', 'tinyint', 1, '0'),
('base_sales', 'setup.company', 'int', 11, '1'),
('time_zone', 'setup.company', 'tinyint', 1, '0'),
('add_pct', 'setup.company', 'int', 5, '-1'),
('round_to', 'setup.company', 'int', 5, '1'),
('login_tout', 'setup.company', 'smallint', 6, '7200'),
('past_due_days', 'glsetup.general', 'int', 11, '30'),
('profit_loss_year_act', 'glsetup.general', 'varchar', 15, '9990'),
('retained_earnings_act', 'glsetup.general', 'varchar', 15, '3590'),
('bank_charge_act', 'glsetup.general', 'varchar', 15, '5690'),
('exchange_diff_act', 'glsetup.general', 'varchar', 15, '4450'),
('default_credit_limit', 'glsetup.customer', 'int', 11, '1000'),
('accumulate_shipping', 'glsetup.customer', 'tinyint', 1, '0'),
('legal_text', 'glsetup.customer', 'tinytext', 0, ''),
('freight_act', 'glsetup.customer', 'varchar', 15, '4430'),
('debtors_act', 'glsetup.sales', 'varchar', 15, '1200'),
('default_sales_act', 'glsetup.sales', 'varchar', 15, '4010'),
('default_sales_discount_act', 'glsetup.sales', 'varchar', 15, '4510'),
('default_prompt_payment_act', 'glsetup.sales', 'varchar', 15, '4500'),
('default_delivery_required', 'glsetup.sales', 'smallint', 6, '1'),
('default_dim_required', 'glsetup.dims', 'int', 11, '20'),
('pyt_discount_act', 'glsetup.purchase', 'varchar', 15, '5060'),
('salary_act', 'glsetup.purchase', 'varchar', 15, '5410'),
('creditors_act', 'glsetup.purchase', 'varchar', 15, '2100'),
('po_over_receive', 'glsetup.purchase', 'int', 11, '10'),
('po_over_charge', 'glsetup.purchase', 'int', 11, '10'),
('allow_negative_stock', 'glsetup.inventory', 'tinyint', 1, '0'),
('default_inventory_act', 'glsetup.items', 'varchar', 15, '1510'),
('default_cogs_act', 'glsetup.items', 'varchar', 15, '5010'),
('default_driver_cogs_act', 'glsetup.items', 'varchar', 15, '5011'),
('default_vehicle_cogs_act', 'glsetup.items', 'varchar', 15, '5012'),
('default_adj_act', 'glsetup.items', 'varchar', 15, '5040'),
('default_inv_sales_act', 'glsetup.items', 'varchar', 15, '4010'),
('default_assembly_act', 'glsetup.items', 'varchar', 15, '1530'),
('default_workorder_required', 'glsetup.manuf', 'int', 11, '20'),
('version_id', 'system', 'varchar', 11, '2.3rc'),
('auto_curr_reval', 'setup.company', 'smallint', 6, '1'),
('grn_clearing_act', 'glsetup.purchase', 'varchar', 15, '1550'),
('bcc_email', 'setup.company', 'varchar', 100, ''),
('default_payment_terms', 'setup.company', 'int', 11, '4');

-- --------------------------------------------------------

--
-- Table structure for table `0_sys_types`
--

CREATE TABLE IF NOT EXISTS `0_sys_types` (
  `type_id` smallint(6) NOT NULL DEFAULT '0',
  `type_no` int(11) NOT NULL DEFAULT '1',
  `next_reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_sys_types`
--

INSERT INTO `0_sys_types` (`type_id`, `type_no`, `next_reference`) VALUES
(0, 17, '1'),
(1, 7, '1'),
(2, 4, '1'),
(4, 3, '1'),
(10, 16, '1'),
(11, 2, '1'),
(12, 6, '1'),
(13, 1, '1'),
(16, 2, '1'),
(17, 2, '1'),
(18, 1, '1'),
(20, 6, '1'),
(21, 1, '1'),
(22, 3, '1'),
(25, 1, '1'),
(26, 1, '1'),
(28, 1, '1'),
(29, 1, '1'),
(30, 0, '1'),
(32, 0, '1'),
(35, 1, '1'),
(40, 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `0_tags`
--

CREATE TABLE IF NOT EXISTS `0_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(60) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_tag_associations`
--

CREATE TABLE IF NOT EXISTS `0_tag_associations` (
  `record_id` varchar(15) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `record_id` (`record_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_tax_groups`
--

CREATE TABLE IF NOT EXISTS `0_tax_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `tax_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `0_tax_groups`
--

INSERT INTO `0_tax_groups` (`id`, `name`, `tax_shipping`, `inactive`) VALUES
(1, 'Tax', 0, 0),
(2, 'Tax Exempt', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_tax_group_items`
--

CREATE TABLE IF NOT EXISTS `0_tax_group_items` (
  `tax_group_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`tax_group_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `0_tax_group_items`
--

INSERT INTO `0_tax_group_items` (`tax_group_id`, `tax_type_id`, `rate`) VALUES
(1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `0_tax_types`
--

CREATE TABLE IF NOT EXISTS `0_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` double NOT NULL DEFAULT '0',
  `sales_gl_code` varchar(15) NOT NULL DEFAULT '',
  `purchasing_gl_code` varchar(15) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_tax_types`
--

INSERT INTO `0_tax_types` (`id`, `rate`, `sales_gl_code`, `purchasing_gl_code`, `name`, `inactive`) VALUES
(1, 5, '2150', '2150', 'Tax', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_trans_tax_details`
--

CREATE TABLE IF NOT EXISTS `0_trans_tax_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_type` smallint(6) DEFAULT NULL,
  `trans_no` int(11) DEFAULT NULL,
  `tran_date` date NOT NULL,
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `ex_rate` double NOT NULL DEFAULT '1',
  `included_in_price` tinyint(1) NOT NULL DEFAULT '0',
  `net_amount` double NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `memo` tinytext,
  PRIMARY KEY (`id`),
  KEY `Type_and_Number` (`trans_type`,`trans_no`),
  KEY `tran_date` (`tran_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_useronline`
--

CREATE TABLE IF NOT EXISTS `0_useronline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(15) NOT NULL DEFAULT '0',
  `ip` varchar(40) NOT NULL DEFAULT '',
  `file` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_users`
--

CREATE TABLE IF NOT EXISTS `0_users` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(60) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `real_name` varchar(100) NOT NULL DEFAULT '',
  `role_id` int(11) NOT NULL DEFAULT '1',
  `phone` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(100) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `date_format` tinyint(1) NOT NULL DEFAULT '0',
  `date_sep` tinyint(1) NOT NULL DEFAULT '0',
  `tho_sep` tinyint(1) NOT NULL DEFAULT '0',
  `dec_sep` tinyint(1) NOT NULL DEFAULT '0',
  `theme` varchar(20) NOT NULL DEFAULT 'default',
  `page_size` varchar(20) NOT NULL DEFAULT 'A4',
  `prices_dec` smallint(6) NOT NULL DEFAULT '2',
  `qty_dec` smallint(6) NOT NULL DEFAULT '2',
  `rates_dec` smallint(6) NOT NULL DEFAULT '4',
  `percent_dec` smallint(6) NOT NULL DEFAULT '1',
  `show_gl` tinyint(1) NOT NULL DEFAULT '1',
  `show_codes` tinyint(1) NOT NULL DEFAULT '0',
  `show_hints` tinyint(1) NOT NULL DEFAULT '0',
  `last_visit_date` datetime DEFAULT NULL,
  `query_size` tinyint(1) DEFAULT '10',
  `graphic_links` tinyint(1) DEFAULT '1',
  `pos` smallint(6) DEFAULT '1',
  `print_profile` varchar(30) NOT NULL DEFAULT '1',
  `rep_popup` tinyint(1) DEFAULT '1',
  `sticky_doc_date` tinyint(1) DEFAULT '0',
  `startup_tab` varchar(20) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `0_users`
--

INSERT INTO `0_users` (`id`, `user_id`, `password`, `real_name`, `role_id`, `phone`, `email`, `language`, `date_format`, `date_sep`, `tho_sep`, `dec_sep`, `theme`, `page_size`, `prices_dec`, `qty_dec`, `rates_dec`, `percent_dec`, `show_gl`, `show_codes`, `show_hints`, `last_visit_date`, `query_size`, `graphic_links`, `pos`, `print_profile`, `rep_popup`, `sticky_doc_date`, `startup_tab`, `inactive`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 2, '', 'adm@adm.com', 'en_US', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2008-04-04 12:34:29', 10, 1, 1, '1', 1, 0, 'orders', 0);

-- --------------------------------------------------------

--
-- Table structure for table `0_voided`
--

CREATE TABLE IF NOT EXISTS `0_voided` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  `memo_` tinytext NOT NULL,
  UNIQUE KEY `id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `0_workcentres`
--

CREATE TABLE IF NOT EXISTS `0_workcentres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `description` char(50) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_workorders`
--

CREATE TABLE IF NOT EXISTS `0_workorders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wo_ref` varchar(60) NOT NULL DEFAULT '',
  `loc_code` varchar(5) NOT NULL DEFAULT '',
  `units_reqd` double NOT NULL DEFAULT '1',
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `required_by` date NOT NULL DEFAULT '0000-00-00',
  `released_date` date NOT NULL DEFAULT '0000-00-00',
  `units_issued` double NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `released` tinyint(1) NOT NULL DEFAULT '0',
  `additional_costs` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wo_ref` (`wo_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_wo_issues`
--

CREATE TABLE IF NOT EXISTS `0_wo_issues` (
  `issue_no` int(11) NOT NULL AUTO_INCREMENT,
  `workorder_id` int(11) NOT NULL DEFAULT '0',
  `reference` varchar(100) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `loc_code` varchar(5) DEFAULT NULL,
  `workcentre_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`issue_no`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_wo_issue_items`
--

CREATE TABLE IF NOT EXISTS `0_wo_issue_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(40) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `qty_issued` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_wo_manufacture`
--

CREATE TABLE IF NOT EXISTS `0_wo_manufacture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(100) DEFAULT NULL,
  `workorder_id` int(11) NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `0_wo_requirements`
--

CREATE TABLE IF NOT EXISTS `0_wo_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workorder_id` int(11) NOT NULL DEFAULT '0',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `workcentre` int(11) NOT NULL DEFAULT '0',
  `units_req` double NOT NULL DEFAULT '1',
  `std_cost` double NOT NULL DEFAULT '0',
  `loc_code` char(5) NOT NULL DEFAULT '',
  `units_issued` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `workorder_id` (`workorder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_types`
--

CREATE TABLE IF NOT EXISTS `bank_account_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `value` int(11) DEFAULT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `bank_account_types`
--

INSERT INTO `bank_account_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Current', 'Current', NULL, 1, 5, '2014-09-09 06:32:49', '0000-00-00 00:00:00'),
(2, 'Savings', 'Savings', NULL, 1, 5, '2014-09-09 06:33:07', '0000-00-00 00:00:00'),
(3, 'NRI', 'NRI', NULL, 1, 5, '2014-09-09 06:33:16', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `booking_sources`
--

CREATE TABLE IF NOT EXISTS `booking_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `value` int(11) DEFAULT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `booking_sources`
--

INSERT INTO `booking_sources` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Call', 'Call', NULL, 1, 5, '2014-09-09 06:39:01', '0000-00-00 00:00:00'),
(2, 'References', 'References', NULL, 1, 5, '2014-09-09 06:39:19', '0000-00-00 00:00:00'),
(3, 'JustDial', 'JustDial', NULL, 1, 5, '2014-09-09 06:39:35', '0000-00-00 00:00:00'),
(4, 'App', 'App', NULL, 1, 5, '2014-09-09 06:39:47', '2014-09-09 06:39:54');

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(50) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `email` varchar(60) NOT NULL,
  `dob` date NOT NULL,
  `registration_type_id` int(11) NOT NULL,
  `app_id` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `imei` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `fa_customer_id` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `customer_type_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `login_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `user_id_2` (`user_id`),
  KEY `id` (`id`),
  KEY `registration_type_id` (`registration_type_id`),
  KEY `app_id` (`app_id`),
  KEY `fa_customer_id` (`fa_customer_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `customer_type_id` (`customer_type_id`),
  KEY `customer_group_id` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE IF NOT EXISTS `customer_groups` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_registration_types`
--

CREATE TABLE IF NOT EXISTS `customer_registration_types` (
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

--
-- Dumping data for table `customer_registration_types`
--

INSERT INTO `customer_registration_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'PhoneCall', 'PhoneCall', NULL, 1, 5, '2014-09-09 06:31:26', '0000-00-00 00:00:00'),
(2, 'App', 'App', NULL, 1, 5, '2014-09-09 06:31:40', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `customer_types`
--

CREATE TABLE IF NOT EXISTS `customer_types` (
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
  KEY `user_id` (`user_id`),
  KEY `organisation_id_2` (`organisation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `customer_types`
--

INSERT INTO `customer_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'WalkIn', 'WalkIn', NULL, 1, 5, '2014-09-09 06:29:57', '0000-00-00 00:00:00'),
(2, 'Cash', 'Cash', NULL, 1, 5, '2014-09-09 06:30:16', '0000-00-00 00:00:00'),
(3, 'Credit', 'Credit', NULL, 1, 5, '2014-09-09 06:30:27', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(50) NOT NULL,
  `sim_no` varchar(13) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE IF NOT EXISTS `drivers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `place_of_birth` varchar(30) NOT NULL,
  `dob` date NOT NULL,
  `blood_group` varchar(5) NOT NULL,
  `marital_status_id` int(11) NOT NULL,
  `children` varchar(5) NOT NULL,
  `present_address` text NOT NULL,
  `permanent_address` text NOT NULL,
  `district` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `pin_code` int(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `email` varchar(60) NOT NULL,
  `date_of_joining` date NOT NULL,
  `license_number` varchar(30) NOT NULL,
  `license_renewal_date` date NOT NULL,
  `badge` varchar(5) NOT NULL,
  `badge_renewal_date` date NOT NULL,
  `mother_tongue` text NOT NULL,
  `pan_number` varchar(40) NOT NULL,
  `bank_account_number` varchar(30) NOT NULL,
  `name_on_bank_pass_book` varchar(60) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `branch` varchar(50) NOT NULL,
  `bank_account_type_id` int(11) NOT NULL,
  `ifsc_code` varchar(50) NOT NULL,
  `id_proof_type_id` int(11) NOT NULL,
  `id_proof_document_number` varchar(50) NOT NULL,
  `name_on_id_proof` varchar(50) NOT NULL,
  `salary` double NOT NULL,
  `minimum_working_days` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `login_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_proof_type_id` (`id_proof_type_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `driver_languages`
--

CREATE TABLE IF NOT EXISTS `driver_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `languages_proficiency_id` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `driver_id` (`driver_id`),
  KEY `language_id` (`language_id`),
  KEY `languages_proficiency_id` (`languages_proficiency_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `driver_payment_percentages`
--

CREATE TABLE IF NOT EXISTS `driver_payment_percentages` (
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

-- --------------------------------------------------------

--
-- Table structure for table `driver_type`
--

CREATE TABLE IF NOT EXISTS `driver_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `value` int(11) DEFAULT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `driver_type`
--

INSERT INTO `driver_type` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Contract', 'Contract', NULL, 1, 5, '2014-09-09 06:28:26', '0000-00-00 00:00:00'),
(2, 'Permanent', 'Permanent', NULL, 1, 5, '2014-09-09 06:28:41', '0000-00-00 00:00:00'),
(3, 'PartTime', 'PartTime', NULL, 1, 5, '2014-09-09 06:29:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `id_proof_types`
--

CREATE TABLE IF NOT EXISTS `id_proof_types` (
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

--
-- Dumping data for table `id_proof_types`
--

INSERT INTO `id_proof_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'DrivinggLicense', 'DrivingLicense', NULL, 1, 5, '2014-09-09 06:33:50', '0000-00-00 00:00:00'),
(2, 'VotersID', 'VotersID', NULL, 1, 5, '2014-09-09 06:34:04', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'English', 'English', NULL, 1, 5, '2014-09-09 06:27:15', '0000-00-00 00:00:00'),
(2, 'Malayalam', 'Malayalam', NULL, 1, 5, '2014-09-09 06:27:25', '0000-00-00 00:00:00'),
(3, 'Hindi', 'Hindi', NULL, 1, 5, '2014-09-09 06:27:37', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `language_proficiency`
--

CREATE TABLE IF NOT EXISTS `language_proficiency` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `language_proficiency`
--

INSERT INTO `language_proficiency` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Read', 'Read', NULL, 1, 5, '2014-09-09 06:27:49', '0000-00-00 00:00:00'),
(2, 'Write', 'Write', NULL, 1, 5, '2014-09-09 06:27:59', '0000-00-00 00:00:00'),
(3, 'Speak', 'Speak', NULL, 1, 5, '2014-09-09 06:28:09', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `marital_statuses`
--

CREATE TABLE IF NOT EXISTS `marital_statuses` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `marital_statuses`
--

INSERT INTO `marital_statuses` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Married', 'Married', NULL, 1, 5, '2014-09-09 06:31:59', '0000-00-00 00:00:00'),
(2, 'Single', 'Single', NULL, 1, 5, '2014-09-09 06:32:10', '0000-00-00 00:00:00'),
(3, 'Divorcee', 'Divorcee', NULL, 1, 5, '2014-09-09 06:32:33', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `organisations`
--

CREATE TABLE IF NOT EXISTS `organisations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `status_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `fa_account` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1 for fa_account created else 0',
  `sms_gateway_url` text COLLATE utf8_unicode_ci NOT NULL,
  `system_email` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `status_id` (`status_id`),
  KEY `id` (`id`),
  KEY `status_id_2` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payment_type`
--

CREATE TABLE IF NOT EXISTS `payment_type` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `payment_type`
--

INSERT INTO `payment_type` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Cash', 'Cash', NULL, 1, 5, '2014-09-09 06:29:13', '0000-00-00 00:00:00'),
(2, 'Account', 'Account', NULL, 1, 5, '2014-09-09 06:29:25', '0000-00-00 00:00:00'),
(3, 'Credit', 'Credit', NULL, 1, 5, '2014-09-09 06:29:34', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `rough_estimate`
--

CREATE TABLE IF NOT EXISTS `rough_estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `time_of_journey` text NOT NULL,
  `distance` text NOT NULL,
  `min_charge` text NOT NULL,
  `additional_charge` text NOT NULL,
  `min_kilometers` text NOT NULL,
  `amount` text NOT NULL,
  `tax_payable` text NOT NULL,
  `total_amt` text NOT NULL,
  `additional_km` text NOT NULL,
  `organisation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_date` date NOT NULL,
  `service_km` text NOT NULL,
  `particulars` text NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`, `description`) VALUES
(1, 'Active', 'Active'),
(2, 'Inactive', 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `tariffs`
--

CREATE TABLE IF NOT EXISTS `tariffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tariff_master_id` int(11) NOT NULL,
  `vehicle_model_id` int(11) NOT NULL,
  `vehicle_ac_type_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `rate` float NOT NULL,
  `additional_kilometer_rate` float NOT NULL,
  `additional_hour_rate` float NOT NULL,
  `driver_bata` float NOT NULL,
  `night_halt` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `tariff_master_id` (`tariff_master_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`),
  KEY `vehicle_model_id` (`vehicle_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tariff_masters`
--

CREATE TABLE IF NOT EXISTS `tariff_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `minimum_kilometers` double NOT NULL,
  `minimum_hours` double NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE IF NOT EXISTS `trips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `guest_id` int(11) NOT NULL,
  `customer_type_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `trip_status_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `booking_source_id` int(11) NOT NULL,
  `source` varchar(120) NOT NULL,
  `pick_up_date` date NOT NULL,
  `pick_up_time` time NOT NULL,
  `drop_time` time NOT NULL,
  `drop_date` date NOT NULL,
  `pick_up_city` varchar(125) NOT NULL,
  `pick_up_area` varchar(125) NOT NULL,
  `pick_up_landmark` varchar(125) NOT NULL,
  `pick_up_lat` double NOT NULL,
  `pick_up_lng` double NOT NULL,
  `drop_city` varchar(125) NOT NULL,
  `drop_area` varchar(125) NOT NULL,
  `drop_landmark` varchar(125) NOT NULL,
  `drop_lat` double NOT NULL,
  `drop_lng` double NOT NULL,
  `via_city` varchar(125) NOT NULL,
  `via_area` varchar(125) NOT NULL,
  `via_landmark` varchar(125) NOT NULL,
  `via_lat` double NOT NULL,
  `via_lng` double NOT NULL,
  `no_of_passengers` int(3) NOT NULL,
  `kilometer_reading_start` double NOT NULL,
  `kilometer_reading_drop` double NOT NULL,
  `vehicle_type_id` int(11) NOT NULL,
  `vehicle_ac_type_id` int(11) NOT NULL,
  `vehicle_fuel_type_id` int(11) NOT NULL,
  `vehicle_seating_capacity_id` int(11) NOT NULL,
  `vehicle_beacon_light_option_id` int(11) NOT NULL,
  `vehicle_make_id` int(11) NOT NULL,
  `vehicle_model_id` int(11) NOT NULL,
  `driver_language_id` int(11) NOT NULL,
  `pluckcard` tinyint(1) NOT NULL,
  `uniform` tinyint(1) NOT NULL,
  `driver_language_proficiency_id` int(11) NOT NULL,
  `trip_model_id` int(11) NOT NULL,
  `tariff_id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `advance_amount` double NOT NULL,
  `driver_batta` double NOT NULL,
  `total_amount` double NOT NULL,
  `remarks` text NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `guest_id` (`guest_id`),
  KEY `customer_type_id` (`customer_type_id`),
  KEY `customer_group_id` (`customer_group_id`),
  KEY `trip_status_id` (`trip_status_id`),
  KEY `booking_source_id` (`booking_source_id`),
  KEY `vehicle_type_id` (`vehicle_type_id`),
  KEY `vehicle_ac_type_id` (`vehicle_ac_type_id`),
  KEY `vehicle_fuel_type_id` (`vehicle_fuel_type_id`),
  KEY `vehicle_seating_capacity_id` (`vehicle_seating_capacity_id`),
  KEY `vehicle_beacon_light_option_id` (`vehicle_beacon_light_option_id`),
  KEY `vehicle_make_id` (`vehicle_make_id`),
  KEY `driver_language_id` (`driver_language_id`),
  KEY `driver_language_proficiency_id` (`driver_language_proficiency_id`),
  KEY `trip_model_id` (`trip_model_id`),
  KEY `tariff_id` (`tariff_id`),
  KEY `payment_type_id` (`payment_type_id`),
  KEY `driver_id` (`driver_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`),
  KEY `vehicle_model_id` (`vehicle_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `trip_expense_log`
--

CREATE TABLE IF NOT EXISTS `trip_expense_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `trip_expense_type_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `trip_id` (`trip_id`),
  KEY `trip_expense_type_id` (`trip_expense_type_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `trip_expense_type`
--

CREATE TABLE IF NOT EXISTS `trip_expense_type` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `trip_expense_type`
--

INSERT INTO `trip_expense_type` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Toll', 'Toll', NULL, 1, 5, '2014-09-09 06:40:08', '0000-00-00 00:00:00'),
(2, 'StateTax', 'StateTax', NULL, 1, 5, '2014-09-09 06:40:23', '2014-09-09 06:40:39'),
(3, 'NightHalt', 'NightHalt', NULL, 1, 5, '2014-09-09 06:41:03', '0000-00-00 00:00:00'),
(4, 'ExtraPetrolOrDiesel', 'ExtraPetrolOrDiesel', NULL, 1, 5, '2014-09-09 06:41:44', '2014-09-09 06:41:56');

-- --------------------------------------------------------

--
-- Table structure for table `trip_models`
--

CREATE TABLE IF NOT EXISTS `trip_models` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `trip_models`
--

INSERT INTO `trip_models` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Local', 'Local', NULL, 1, 5, '2014-09-09 06:34:18', '0000-00-00 00:00:00'),
(2, 'OutStations', 'OutStations', NULL, 1, 5, '2014-09-09 06:34:32', '0000-00-00 00:00:00'),
(3, 'RentACar', 'RentACar', NULL, 1, 5, '2014-09-09 06:34:56', '0000-00-00 00:00:00'),
(4, 'TALCTaxi', 'TALCTaxi', NULL, 1, 5, '2014-09-09 06:35:27', '0000-00-00 00:00:00'),
(5, 'AirportPickup', 'AirportPickup', NULL, 1, 5, '2014-09-09 06:35:57', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `trip_statuses`
--

CREATE TABLE IF NOT EXISTS `trip_statuses` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `trip_statuses`
--

INSERT INTO `trip_statuses` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Pending', 'Pending', NULL, 1, 5, '2014-09-09 06:36:20', '2014-09-09 06:36:31'),
(2, 'Confirmed', 'Confirmed', NULL, 1, 5, '2014-09-09 06:36:51', '0000-00-00 00:00:00'),
(3, 'Canceled', 'Canceled', NULL, 1, 5, '2014-09-09 06:37:07', '0000-00-00 00:00:00'),
(4, 'CustomerCanceled', 'CustomerCanceled', NULL, 1, 5, '2014-09-09 06:37:25', '0000-00-00 00:00:00'),
(5, 'OnTrip', 'OnTrip', NULL, 1, 5, '2014-09-09 06:37:43', '0000-00-00 00:00:00'),
(6, 'TripCompleted', 'TripCompleted', NULL, 1, 5, '2014-09-09 06:37:59', '0000-00-00 00:00:00'),
(7, 'TripPayed', 'TripPayed', NULL, 1, 5, '2014-09-09 06:38:17', '2014-09-09 06:38:39'),
(8, 'BillGenerated', 'BillGenerated', NULL, 1, 5, '2014-09-29 07:37:59', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `trip_status_log`
--

CREATE TABLE IF NOT EXISTS `trip_status_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `trip_status_id` int(11) NOT NULL,
  `narration` text NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `trip_id` (`trip_id`),
  KEY `trip_status_id` (`trip_status_id`),
  KEY `user_id` (`user_id`),
  KEY `organisation_id` (`organisation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `trip_vouchers`
--

CREATE TABLE IF NOT EXISTS `trip_vouchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `start_km_reading` double NOT NULL,
  `end_km_reading` double NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `driver_bata` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `garage_closing_kilometer_reading` double NOT NULL,
  `garage_closing_time` time NOT NULL,
  `releasing_place` text NOT NULL,
  `parking_fees` double NOT NULL,
  `toll_fees` double NOT NULL,
  `state_tax` double NOT NULL,
  `night_halt_charges` double NOT NULL,
  `fuel_extra_charges` double NOT NULL,
  `no_of_days` int(11) NOT NULL,
  `trip_start_date` date NOT NULL,
  `trip_end_date` date NOT NULL,
  `trip_starting_time` time NOT NULL,
  `trip_ending_time` time NOT NULL,
  `total_trip_amount` double NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `voucher_no` int(11) NOT NULL,
  `base_kilometer_amount` double NOT NULL,
  `tariff_id` int(11) NOT NULL,
  `base_kilometers` double NOT NULL,
  `base_additional_kilometer_rate` double NOT NULL,
  `base_km_hr` char(1) NOT NULL,
  `base_hours` double NOT NULL,
  `base_hour_amount` double NOT NULL,
  `base_additional_hour_rate` double NOT NULL,
  `driver_base_kilometers` double NOT NULL,
  `driver_base_kilometer_amount` double NOT NULL,
  `driver_additional_kilometer_rate` double NOT NULL,
  `driver_km_hr` char(1) NOT NULL,
  `vehicle_base_kilometers` double NOT NULL,
  `vehicle_base_kilometer_amount` double NOT NULL,
  `vehicle_additional_kilometer_rate` double NOT NULL,
  `vehicle_km_hr` char(1) NOT NULL,
  `driver_base_hours` double NOT NULL,
  `driver_base_hours_amount` double NOT NULL,
  `driver_additional_hour_rate` double NOT NULL,
  `vehicle_base_hours` double NOT NULL,
  `vehicle_base_hours_amount` double NOT NULL,
  `vehicle_additional_hour_rate` double NOT NULL,
  `driver_payment_percentage` double NOT NULL,
  `vehicle_payment_percentage` double NOT NULL,
  `driver_payment_amount` double NOT NULL,
  `vehicle_payment_amount` double NOT NULL,
  `remarks` text NOT NULL,
  `driver_trip_amount` double NOT NULL,
  `vehicle_trip_amount` double NOT NULL,
  `trip_narration` text NOT NULL,
  `delivery_no` int(11) NOT NULL COMMENT 'fa delivery number',
  `invoice_no` int(11) NOT NULL COMMENT 'fa invoice no',
  `payment_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_id` (`trip_id`,`organisation_id`,`driver_id`,`user_id`),
  KEY `delivery_no` (`delivery_no`,`invoice_no`),
  KEY `tariff_id` (`tariff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `occupation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_status_id` int(11) DEFAULT NULL,
  `password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_type_id` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `organisation_admin_id` int(11) DEFAULT NULL,
  `fa_account` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `user_status_id` (`user_status_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `id` (`id`),
  KEY `user_status_id_2` (`user_status_id`),
  KEY `user_type_id` (`user_type_id`),
  KEY `organisation_id_2` (`organisation_id`),
  KEY `organisation_admin_id` (`organisation_admin_id`),
  KEY `fa_account` (`fa_account`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `address`, `occupation`, `user_status_id`, `password_token`, `user_type_id`, `organisation_id`, `organisation_admin_id`, `fa_account`, `created`, `updated`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'System', 'Administrator', 'admin@acube.local', NULL, NULL, NULL, 1, NULL, 1, -1, NULL, 0, '2014-08-10 18:30:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_login_attempts`
--

CREATE TABLE IF NOT EXISTS `user_login_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_statuses`
--

CREATE TABLE IF NOT EXISTS `user_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user_statuses`
--

INSERT INTO `user_statuses` (`id`, `name`, `description`) VALUES
(1, 'Active', 'Active'),
(2, 'Suspended', 'Suspended'),
(3, 'Disabled', 'Disabled');

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE IF NOT EXISTS `user_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`id`, `name`, `description`) VALUES
(1, 'System Administrator', 'System Administrator'),
(2, 'Organisation Administrator', 'Organisation Administrator'),
(3, 'Front Desk', 'Front Desk'),
(4, 'Customer', 'Customer'),
(5, 'Driver', 'Driver'),
(6, 'Vehicle Owner', 'Vehicle Owner');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registration_number` varchar(20) NOT NULL,
  `registration_date` date NOT NULL,
  `engine_number` varchar(60) NOT NULL,
  `chases_number` varchar(60) NOT NULL,
  `vehicles_insurance_id` int(11) NOT NULL,
  `vehicle_loan_id` int(11) NOT NULL,
  `vehicle_owner_id` int(11) NOT NULL,
  `vehicle_ownership_types_id` int(11) NOT NULL,
  `vehicle_type_id` int(11) NOT NULL,
  `vehicle_make_id` int(11) NOT NULL,
  `vehicle_model_id` int(11) NOT NULL,
  `vehicle_manufacturing_year` int(11) NOT NULL,
  `vehicle_ac_type_id` int(11) NOT NULL,
  `vehicle_fuel_type_id` int(11) NOT NULL,
  `vehicle_seating_capacity_id` int(11) NOT NULL,
  `vehicle_permit_type_id` int(11) NOT NULL,
  `vehicle_permit_renewal_date` date NOT NULL,
  `vehicle_permit_renewal_amount` double NOT NULL,
  `tax_renewal_amount` double NOT NULL,
  `tax_renewal_date` date NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicles_insurance_id` (`vehicles_insurance_id`),
  KEY `vehicle_loan_id` (`vehicle_loan_id`),
  KEY `vehicle_owner_id` (`vehicle_owner_id`),
  KEY `vehicle_ownership_types_id` (`vehicle_ownership_types_id`),
  KEY `vehicle_type_id` (`vehicle_type_id`),
  KEY `vehicle_make_id` (`vehicle_make_id`),
  KEY `vehicle_ac_type_id` (`vehicle_ac_type_id`),
  KEY `vehicle_fuel_type_id` (`vehicle_fuel_type_id`),
  KEY `vehicle_seating_capacity_id` (`vehicle_seating_capacity_id`),
  KEY `vehicle_permit_type_id` (`vehicle_permit_type_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`),
  KEY `vehicle_model_id` (`vehicle_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_insurance`
--

CREATE TABLE IF NOT EXISTS `vehicles_insurance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `insurance_number` varchar(60) NOT NULL,
  `insurance_date` date NOT NULL,
  `insurance_renewal_date` date NOT NULL,
  `insurance_premium_amount` double NOT NULL,
  `insurance_amount` double NOT NULL,
  `Insurance_agency` varchar(30) NOT NULL,
  `Insurance_agency_address` text NOT NULL,
  `Insurance_agency_phone` varchar(12) NOT NULL,
  `Insurance_agency_email` varchar(80) NOT NULL,
  `Insurance_agency_web` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_ac_types`
--

CREATE TABLE IF NOT EXISTS `vehicle_ac_types` (
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

--
-- Dumping data for table `vehicle_ac_types`
--

INSERT INTO `vehicle_ac_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'AC', 'AC', NULL, 1, 5, '2014-09-09 06:21:20', '0000-00-00 00:00:00'),
(2, 'NonAC', 'NonAc', NULL, 1, 5, '2014-09-09 06:21:32', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_beacon_light_options`
--

CREATE TABLE IF NOT EXISTS `vehicle_beacon_light_options` (
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

--
-- Dumping data for table `vehicle_beacon_light_options`
--

INSERT INTO `vehicle_beacon_light_options` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Red', 'Red', NULL, 1, 5, '2014-09-09 06:23:08', '0000-00-00 00:00:00'),
(2, 'Blue', 'Blue', NULL, 1, 5, '2014-09-09 06:23:16', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_devices`
--

CREATE TABLE IF NOT EXISTS `vehicle_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `device_id` (`device_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_drivers`
--

CREATE TABLE IF NOT EXISTS `vehicle_drivers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `driver_id` (`driver_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`),
  KEY `organisation_id_2` (`organisation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_driver_bata_percentages`
--

CREATE TABLE IF NOT EXISTS `vehicle_driver_bata_percentages` (
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

--
-- Dumping data for table `vehicle_driver_bata_percentages`
--

INSERT INTO `vehicle_driver_bata_percentages` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, '17percent', '17percent', NULL, 1, 5, '2014-09-09 06:24:25', '0000-00-00 00:00:00'),
(2, '20percent', '20percent', NULL, 1, 5, '2014-09-09 06:24:39', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_fuel_types`
--

CREATE TABLE IF NOT EXISTS `vehicle_fuel_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `value` int(11) DEFAULT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vehicle_fuel_types`
--

INSERT INTO `vehicle_fuel_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Petrol', 'Petrol', NULL, 1, 5, '2014-09-09 06:21:47', '0000-00-00 00:00:00'),
(2, 'Diesel', 'Diesel', NULL, 1, 5, '2014-09-09 06:21:59', '0000-00-00 00:00:00'),
(3, 'CNG', 'CNG', NULL, 1, 5, '2014-09-09 06:22:08', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_loans`
--

CREATE TABLE IF NOT EXISTS `vehicle_loans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `number_of_emi` int(11) NOT NULL,
  `emi_amount` double NOT NULL,
  `number_of_paid_emi` double NOT NULL,
  `emi_payment_date` date NOT NULL,
  `loan_agency` varchar(30) NOT NULL,
  `loan_agency_address` text NOT NULL,
  `loan_agency_phone` varchar(15) NOT NULL,
  `loan_agency_email` varchar(80) NOT NULL,
  `loan_agency_web` varchar(80) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_locations_log`
--

CREATE TABLE IF NOT EXISTS `vehicle_locations_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `imei` varchar(20) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `trip_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `device_id` (`imei`),
  KEY `trip_id` (`trip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_makes`
--

CREATE TABLE IF NOT EXISTS `vehicle_makes` (
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
  KEY `user_id` (`user_id`),
  KEY `organisation_id` (`organisation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `vehicle_makes`
--

INSERT INTO `vehicle_makes` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'TATAindica', 'TATA', NULL, 1, 5, '2014-09-09 06:23:33', '2014-09-25 06:05:48'),
(2, 'Toyota', 'Toyota', NULL, 1, 5, '2014-09-09 06:23:45', '0000-00-00 00:00:00'),
(3, 'Fiat', 'Fiat', NULL, 1, 5, '2014-09-09 06:23:56', '0000-00-00 00:00:00'),
(4, 'tatasumo', 'tatasumo', NULL, 1, 5, '2014-09-25 06:06:55', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_models`
--

CREATE TABLE IF NOT EXISTS `vehicle_models` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_owners`
--

CREATE TABLE IF NOT EXISTS `vehicle_owners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `dob` date NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_ownership_types`
--

CREATE TABLE IF NOT EXISTS `vehicle_ownership_types` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vehicle_ownership_types`
--

INSERT INTO `vehicle_ownership_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Owned', 'Owned', NULL, 1, 5, '2014-09-09 06:19:29', '0000-00-00 00:00:00'),
(2, 'Rented', 'Rented', NULL, 1, 5, '2014-09-09 06:19:45', '0000-00-00 00:00:00'),
(3, 'Attached', 'Attached', NULL, 1, 5, '2014-09-09 06:20:04', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_permit_types`
--

CREATE TABLE IF NOT EXISTS `vehicle_permit_types` (
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

--
-- Dumping data for table `vehicle_permit_types`
--

INSERT INTO `vehicle_permit_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'AllKerala', 'AllKerala', NULL, 1, 5, '2014-09-09 06:26:11', '0000-00-00 00:00:00'),
(2, 'AllIndia', 'AllIndia', NULL, 1, 5, '2014-09-09 06:26:25', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_seating_capacity`
--

CREATE TABLE IF NOT EXISTS `vehicle_seating_capacity` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vehicle_seating_capacity`
--

INSERT INTO `vehicle_seating_capacity` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, '4seated', '4seated', NULL, 1, 5, '2014-09-09 06:22:33', '0000-00-00 00:00:00'),
(2, '5seated', '5seated', NULL, 1, 5, '2014-09-09 06:22:44', '0000-00-00 00:00:00'),
(3, '6seated', '6seated', NULL, 1, 5, '2014-09-09 06:22:55', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_types`
--

CREATE TABLE IF NOT EXISTS `vehicle_types` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `vehicle_types`
--

INSERT INTO `vehicle_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Sedan', 'Sedan', NULL, 1, 5, '2014-09-09 06:20:26', '0000-00-00 00:00:00'),
(2, 'Hatchback', 'Hatchback', NULL, 1, 5, '2014-09-09 06:20:43', '0000-00-00 00:00:00'),
(3, 'SUV', 'SUV', NULL, 1, 5, '2014-09-09 06:20:55', '0000-00-00 00:00:00'),
(4, 'Traveler', 'Traveler', NULL, 1, 5, '2014-09-09 06:21:06', '0000-00-00 00:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
