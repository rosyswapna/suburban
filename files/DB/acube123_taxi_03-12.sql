-- phpMyAdmin SQL Dump
-- version 4.1.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 03, 2014 at 07:09 AM
-- Server version: 5.5.36-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `acube123_taxi`
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

--
-- Dumping data for table `0_bank_accounts`
--

INSERT INTO `0_bank_accounts` (`account_code`, `account_type`, `bank_account_name`, `bank_account_number`, `bank_name`, `bank_address`, `bank_curr_code`, `dflt_curr_act`, `id`, `last_reconciled_date`, `ending_reconcile_balance`, `inactive`) VALUES
('1060', 0, 'Current account', 'N/A', 'N/A', '', 'INR', 1, 1, '0000-00-00 00:00:00', 0, 0),
('1065', 3, 'Petty Cash account', 'N/A', 'N/A', '', 'INR', 0, 2, '0000-00-00 00:00:00', 0, 0);

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
  `unit_taxable_amount` double NOT NULL,
  `unit_tax` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discount_percent` double NOT NULL DEFAULT '0',
  `standard_cost` double NOT NULL DEFAULT '0',
  `qty_done` double NOT NULL DEFAULT '0',
  `src_id` int(11) NOT NULL,
  `trip_voucher` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Transaction` (`debtor_trans_type`,`debtor_trans_no`),
  KEY `src_id` (`src_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
(1, '2008-01-01', '2008-12-31', 0),
(2, '2009-01-01', '2009-12-31', 0),
(3, '2010-01-01', '2010-12-31', 0),
(4, '2011-01-01', '2011-12-31', 0),
(5, '2012-01-01', '2012-12-31', 0),
(6, '2013-01-01', '2013-12-31', 0);

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

--
-- Dumping data for table `0_item_codes`
--

INSERT INTO `0_item_codes` (`id`, `item_code`, `stock_id`, `description`, `category_id`, `quantity`, `is_foreign`, `inactive`) VALUES
(1, '101', '101', 'Trip', 1, 1, 0, 0);

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

--
-- Dumping data for table `0_loc_stock`
--

INSERT INTO `0_loc_stock` (`loc_code`, `stock_id`, `reorder_level`) VALUES
('DEF', '101', 0);

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
  `trip_voucher` int(11) NOT NULL DEFAULT '0',
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

--
-- Dumping data for table `0_stock_master`
--

INSERT INTO `0_stock_master` (`stock_id`, `category_id`, `tax_type_id`, `description`, `long_description`, `units`, `mb_flag`, `sales_account`, `cogs_account`, `inventory_account`, `adjustment_account`, `assembly_account`, `dimension_id`, `dimension2_id`, `actual_cost`, `last_cost`, `material_cost`, `labour_cost`, `overhead_cost`, `inactive`, `no_sale`, `editable`) VALUES
('101', 1, 1, 'Trip', '', 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
('creditors_act', 'glsetup.purchase', 'varchar', 15, '2100'),
('po_over_receive', 'glsetup.purchase', 'int', 11, '10'),
('po_over_charge', 'glsetup.purchase', 'int', 11, '10'),
('allow_negative_stock', 'glsetup.inventory', 'tinyint', 1, '0'),
('default_inventory_act', 'glsetup.items', 'varchar', 15, '1510'),
('default_cogs_act', 'glsetup.items', 'varchar', 15, '5010'),
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
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 2, '', 'adm@adm.com', 'en_US', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2014-11-25 07:12:04', 10, 1, 1, '1', 1, 0, 'orders', 0);

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
-- Table structure for table `2_areas`
--

CREATE TABLE IF NOT EXISTS `2_areas` (
  `area_code` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`area_code`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `2_areas`
--

INSERT INTO `2_areas` (`area_code`, `description`, `inactive`) VALUES
(1, 'Global', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_attachments`
--

CREATE TABLE IF NOT EXISTS `2_attachments` (
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
-- Table structure for table `2_audit_trail`
--

CREATE TABLE IF NOT EXISTS `2_audit_trail` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `2_audit_trail`
--

INSERT INTO `2_audit_trail` (`id`, `type`, `trans_no`, `user`, `stamp`, `description`, `fiscal_year`, `gl_date`, `gl_seq`) VALUES
(1, 30, 1, 3, '2014-11-18 08:22:38', '', 7, '2014-10-15', NULL),
(2, 13, 1, 3, '2014-11-18 08:22:38', '', 7, '2014-10-15', NULL),
(3, 30, 2, 3, '2014-11-18 08:36:52', '', 7, '2014-10-15', NULL),
(4, 13, 2, 3, '2014-11-18 08:36:52', '', 7, '2014-10-15', NULL),
(5, 30, 3, 3, '2014-11-24 07:09:21', '', 7, '2014-10-15', NULL),
(6, 13, 3, 3, '2014-11-24 07:09:21', '', 7, '2014-10-15', NULL),
(7, 30, 4, 3, '2014-10-15 13:21:26', '', 7, '2014-10-15', 0),
(8, 13, 4, 3, '2014-10-15 13:21:26', '', 7, '2014-10-15', 0),
(9, 22, 1, 2, '2014-10-16 07:34:15', '', 7, '2014-10-16', 0),
(10, 10, 1, 2, '2014-11-24 07:09:27', '', 7, '2014-10-16', NULL),
(11, 12, 1, 2, '2014-11-24 07:09:27', '', 7, '2014-10-16', NULL),
(12, 10, 2, 2, '2014-11-24 12:36:29', '', 7, '2014-10-16', NULL),
(13, 12, 2, 2, '2014-11-24 12:36:30', '', 7, '2014-10-16', NULL),
(14, 30, 5, 3, '2014-10-17 09:02:38', '', 7, '2014-10-17', 0),
(15, 13, 5, 3, '2014-10-17 09:02:38', '', 7, '2014-10-17', 0),
(16, 10, 3, 3, '2014-10-20 08:23:35', '', 7, '2014-10-20', 0),
(17, 12, 3, 3, '2014-10-20 08:23:35', '', 7, '2014-10-20', 0),
(18, 30, 6, 1, '2014-11-11 07:38:10', '', 7, '2014-11-11', 0),
(19, 13, 6, 1, '2014-11-11 08:06:48', '', 7, '2014-11-11', NULL),
(20, 13, 6, 1, '2014-11-11 08:06:48', 'Updated.', 7, '2014-11-11', 0),
(21, 10, 4, 1, '2014-11-11 09:08:19', '', 7, '2014-11-11', 0),
(22, 12, 4, 1, '2014-11-11 09:08:19', '', 7, '2014-11-11', 0),
(23, 30, 7, 3, '2014-11-18 06:28:13', '', 7, '2014-11-18', 0),
(24, 13, 7, 3, '2014-11-18 06:28:13', '', 7, '2014-11-18', 0),
(25, 30, 1, 3, '2014-11-18 08:22:38', '', 7, '2014-11-18', 0),
(26, 13, 1, 3, '2014-11-18 08:22:38', '', 7, '2014-11-18', 0),
(27, 30, 2, 3, '2014-11-18 08:36:52', '', 7, '2014-11-18', 0),
(28, 13, 2, 3, '2014-11-18 08:36:52', '', 7, '2014-11-18', 0),
(29, 30, 3, 2, '2014-11-24 07:09:21', '', 7, '2014-11-24', 0),
(30, 13, 3, 2, '2014-11-24 07:09:21', '', 7, '2014-11-24', 0),
(31, 10, 1, 2, '2014-11-24 07:09:27', '', 7, '2014-11-24', 0),
(32, 12, 1, 2, '2014-11-24 07:09:27', '', 7, '2014-11-24', 0),
(33, 10, 2, 3, '2014-11-24 12:36:29', '', 7, '2014-11-24', 0),
(34, 12, 2, 3, '2014-11-24 12:36:30', '', 7, '2014-11-24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_bank_accounts`
--

CREATE TABLE IF NOT EXISTS `2_bank_accounts` (
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

--
-- Dumping data for table `2_bank_accounts`
--

INSERT INTO `2_bank_accounts` (`account_code`, `account_type`, `bank_account_name`, `bank_account_number`, `bank_name`, `bank_address`, `bank_curr_code`, `dflt_curr_act`, `id`, `last_reconciled_date`, `ending_reconcile_balance`, `inactive`) VALUES
('1060', 0, 'Current account', 'N/A', 'N/A', '', 'INR', 1, 1, '0000-00-00 00:00:00', 0, 0),
('1065', 3, 'Petty Cash account', 'N/A', 'N/A', '', 'INR', 0, 2, '0000-00-00 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_bank_trans`
--

CREATE TABLE IF NOT EXISTS `2_bank_trans` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `2_bank_trans`
--

INSERT INTO `2_bank_trans` (`id`, `type`, `trans_no`, `bank_act`, `ref`, `trans_date`, `amount`, `dimension_id`, `dimension2_id`, `person_type_id`, `person_id`, `reconciled`) VALUES
(1, 12, 1, '2', '5', '2014-11-24', 3196.4, 0, 0, 2, 0x31, NULL),
(2, 12, 2, '2', '6', '2014-11-24', 2366.38, 0, 0, 2, 0x34, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `2_bom`
--

CREATE TABLE IF NOT EXISTS `2_bom` (
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
-- Table structure for table `2_budget_trans`
--

CREATE TABLE IF NOT EXISTS `2_budget_trans` (
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
-- Table structure for table `2_chart_class`
--

CREATE TABLE IF NOT EXISTS `2_chart_class` (
  `cid` varchar(3) NOT NULL,
  `class_name` varchar(60) NOT NULL DEFAULT '',
  `ctype` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_chart_class`
--

INSERT INTO `2_chart_class` (`cid`, `class_name`, `ctype`, `inactive`) VALUES
('1', 'Assets', 1, 0),
('2', 'Liabilities', 2, 0),
('3', 'Income', 4, 0),
('4', 'Costs', 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_chart_master`
--

CREATE TABLE IF NOT EXISTS `2_chart_master` (
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
-- Dumping data for table `2_chart_master`
--

INSERT INTO `2_chart_master` (`account_code`, `account_code2`, `account_name`, `account_type`, `inactive`) VALUES
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
('9990', '', 'Year Profit/Loss', '12', 0),
('2381', '', 'Service Tax', '4', 0),
('2382', '', 'Education Cess', '4', 0),
('2383', '', 'Higher Education Cess', '4', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_chart_types`
--

CREATE TABLE IF NOT EXISTS `2_chart_types` (
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
-- Dumping data for table `2_chart_types`
--

INSERT INTO `2_chart_types` (`id`, `name`, `class_id`, `parent`, `inactive`) VALUES
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
-- Table structure for table `2_comments`
--

CREATE TABLE IF NOT EXISTS `2_comments` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date DEFAULT '0000-00-00',
  `memo_` tinytext,
  KEY `type_and_id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_comments`
--

INSERT INTO `2_comments` (`type`, `id`, `date_`, `memo_`) VALUES
(13, 1, '2014-11-18', 'Minimum 80 KM@ Rs 1550 + Additional  31 KM@18/KM + Driver Batta 150'),
(13, 2, '2014-11-18', 'Minimum 130 KM@ Rs 2500 + Additional  118 KM@12/KM + Driver Batta 150'),
(13, 3, '2014-11-24', 'Minimum 120 KM@ Rs 2500 + Additional  30 KM@10/KM + Driver Batta 250'),
(10, 1, '2014-11-24', 'Minimum 120 KM@ Rs 2500 + Additional  30 KM@10/KM + Driver Batta 250'),
(12, 1, '2014-11-24', 'Cash invoice 1'),
(10, 2, '2014-11-24', 'Minimum 80 KM@ Rs 1550 + Additional  31 KM@18/KM + Driver Batta 150'),
(12, 2, '2014-11-24', 'Cash invoice 2');

-- --------------------------------------------------------

--
-- Table structure for table `2_credit_status`
--

CREATE TABLE IF NOT EXISTS `2_credit_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_description` char(100) NOT NULL DEFAULT '',
  `dissallow_invoices` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reason_description` (`reason_description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `2_credit_status`
--

INSERT INTO `2_credit_status` (`id`, `reason_description`, `dissallow_invoices`, `inactive`) VALUES
(1, 'Good History', 0, 0),
(3, 'No more work until payment received', 1, 0),
(4, 'In liquidation', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_crm_categories`
--

CREATE TABLE IF NOT EXISTS `2_crm_categories` (
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
-- Dumping data for table `2_crm_categories`
--

INSERT INTO `2_crm_categories` (`id`, `type`, `action`, `name`, `description`, `system`, `inactive`) VALUES
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
-- Table structure for table `2_crm_contacts`
--

CREATE TABLE IF NOT EXISTS `2_crm_contacts` (
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
-- Table structure for table `2_crm_persons`
--

CREATE TABLE IF NOT EXISTS `2_crm_persons` (
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
-- Table structure for table `2_currencies`
--

CREATE TABLE IF NOT EXISTS `2_currencies` (
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
-- Dumping data for table `2_currencies`
--

INSERT INTO `2_currencies` (`currency`, `curr_abrev`, `curr_symbol`, `country`, `hundreds_name`, `auto_update`, `inactive`) VALUES
('Indian Rupee', 'INR', '?', 'India', 'Rs', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_cust_allocations`
--

CREATE TABLE IF NOT EXISTS `2_cust_allocations` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `2_cust_allocations`
--

INSERT INTO `2_cust_allocations` (`id`, `amt`, `date_alloc`, `trans_no_from`, `trans_type_from`, `trans_no_to`, `trans_type_to`) VALUES
(1, 7787, '2014-10-16', 1, 12, 1, 10),
(2, 3959, '2014-10-16', 2, 12, 2, 10),
(3, 2169, '2014-10-20', 3, 12, 3, 10),
(4, 16872.8, '2014-11-11', 4, 12, 4, 10),
(5, 3196.4, '2014-11-24', 1, 12, 1, 10),
(6, 2366.38, '2014-11-24', 2, 12, 2, 10);

-- --------------------------------------------------------

--
-- Table structure for table `2_cust_branch`
--

CREATE TABLE IF NOT EXISTS `2_cust_branch` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `2_cust_branch`
--

INSERT INTO `2_cust_branch` (`branch_code`, `debtor_no`, `br_name`, `branch_ref`, `br_address`, `area`, `salesman`, `contact_name`, `default_location`, `tax_group_id`, `sales_account`, `sales_discount_account`, `receivables_account`, `payment_discount_account`, `default_ship_via`, `disable_trans`, `br_post_address`, `group_no`, `notes`, `inactive`) VALUES
(1, 1, 'AVT', 'CG1', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(2, 2, 'Harisson', 'CG2', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(3, 3, 'Manorama', 'CG3', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(4, 4, 'Acube', 'CG4', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(5, 5, 'OMS', 'CG5', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(6, 6, 'Ratheesh Vijayan', 'C1', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(7, 7, 'Rajesh T R', 'C2', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(8, 8, 'Mahesh', 'C3', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(9, 9, 'Renjith', 'C4', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(10, 10, 'Rajesh Vijayan', 'C5', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(11, 11, 'Divya', 'C6', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(12, 12, 'Manuel', 'C7', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(13, 13, 'Anil Kumar', 'C11', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(14, 14, 'Ratheesh Vijayan', 'C13', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_debtors_master`
--

CREATE TABLE IF NOT EXISTS `2_debtors_master` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `2_debtors_master`
--

INSERT INTO `2_debtors_master` (`debtor_no`, `name`, `debtor_ref`, `address`, `tax_id`, `curr_code`, `sales_type`, `dimension_id`, `dimension2_id`, `credit_status`, `payment_terms`, `discount`, `pymt_discount`, `credit_limit`, `notes`, `inactive`) VALUES
(1, 'AVT', 'CG1', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(2, 'Harisson', 'CG2', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(3, 'Manorama', 'CG3', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(4, 'Acube', 'CG4', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(5, 'OMS', 'CG5', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(6, 'Ratheesh Vijayan', 'C1', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(7, 'Rajesh T R', 'C2', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(8, 'Mahesh', 'C3', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(9, 'Renjith', 'C4', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(10, 'Rajesh Vijayan', 'C5', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(11, 'Divya', 'C6', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(12, 'Manuel', 'C7', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(13, 'Anil Kumar', 'C11', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(14, 'Ratheesh Vijayan', 'C13', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_debtor_trans`
--

CREATE TABLE IF NOT EXISTS `2_debtor_trans` (
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
  `tax_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`type`,`trans_no`),
  KEY `debtor_no` (`debtor_no`,`branch_code`),
  KEY `tran_date` (`tran_date`),
  KEY `order_` (`order_`),
  KEY `tax_group_id` (`tax_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_debtor_trans`
--

INSERT INTO `2_debtor_trans` (`trans_no`, `type`, `version`, `debtor_no`, `branch_code`, `tran_date`, `due_date`, `reference`, `tpe`, `order_`, `ov_amount`, `ov_gst`, `ov_freight`, `ov_freight_tax`, `ov_discount`, `alloc`, `rate`, `ship_via`, `dimension_id`, `dimension2_id`, `payment_terms`, `tax_group_id`) VALUES
(1, 10, 0, 1, 1, '2014-11-24', '2014-11-24', '5', 1, 3, 3050, 146.4, 0, 0, 0, 10983.4, 1, 1, 0, 0, 4, NULL),
(2, 10, 0, 4, 4, '2014-11-24', '2014-11-24', '6', 1, 1, 2258, 108.38, 0, 0, 0, 6325.38, 1, 1, 0, 0, 4, NULL),
(1, 12, 0, 1, 1, '2014-11-24', '0000-00-00', '5', 0, 0, 3196.4, 0, 0, 0, 0, 10983.4, 1, 0, 0, 0, NULL, NULL),
(2, 12, 0, 4, 4, '2014-11-24', '0000-00-00', '6', 0, 0, 2366.38, 0, 0, 0, 0, 6325.38, 1, 0, 0, 0, NULL, NULL),
(1, 13, 1, 4, 4, '2014-11-18', '2014-11-19', '1', 1, 1, 2258, 108.38, 0, 0, 0, 0, 1, 0, 0, 0, NULL, NULL),
(2, 13, 0, 10, 10, '2014-11-18', '2014-11-19', '3', 1, 2, 4066, 195.17, 0, 0, 0, 0, 1, 0, 0, 0, NULL, NULL),
(3, 13, 1, 1, 1, '2014-11-24', '2014-11-25', '10', 1, 3, 3050, 146.4, 0, 0, 0, 0, 1, 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `2_debtor_trans_details`
--

CREATE TABLE IF NOT EXISTS `2_debtor_trans_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debtor_trans_no` int(11) DEFAULT NULL,
  `debtor_trans_type` int(11) DEFAULT NULL,
  `stock_id` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `unit_price` double NOT NULL DEFAULT '0',
  `unit_taxable_amount` double NOT NULL,
  `unit_tax` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discount_percent` double NOT NULL DEFAULT '0',
  `standard_cost` double NOT NULL DEFAULT '0',
  `qty_done` double NOT NULL DEFAULT '0',
  `src_id` int(11) NOT NULL,
  `trip_voucher` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Transaction` (`debtor_trans_type`,`debtor_trans_no`),
  KEY `src_id` (`src_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `2_debtor_trans_details`
--

INSERT INTO `2_debtor_trans_details` (`id`, `debtor_trans_no`, `debtor_trans_type`, `stock_id`, `description`, `unit_price`, `unit_taxable_amount`, `unit_tax`, `quantity`, `discount_percent`, `standard_cost`, `qty_done`, `src_id`, `trip_voucher`) VALUES
(1, 1, 13, '101', 'Trip', 2258, 903.2, 108.38, 1, 0, 0, 1, 0, 1),
(2, 2, 13, '101', 'Trip', 4066, 1626.4, 195.17, 1, 0, 0, 0, 0, 2),
(3, 3, 13, '101', 'Trip', 3050, 1220, 146.4, 1, 0, 0, 1, 0, 5),
(4, 1, 10, '101', 'Trip', 3050, 1220, 146.4, 1, 0, 0, 0, 3, 5),
(5, 2, 10, '101', 'Trip', 2258, 903.2, 108.38, 1, 0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `2_dimensions`
--

CREATE TABLE IF NOT EXISTS `2_dimensions` (
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
-- Table structure for table `2_exchange_rates`
--

CREATE TABLE IF NOT EXISTS `2_exchange_rates` (
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
-- Table structure for table `2_fiscal_year`
--

CREATE TABLE IF NOT EXISTS `2_fiscal_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT '0000-00-00',
  `end` date DEFAULT '0000-00-00',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `begin` (`begin`),
  UNIQUE KEY `end` (`end`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `2_fiscal_year`
--

INSERT INTO `2_fiscal_year` (`id`, `begin`, `end`, `closed`) VALUES
(4, '2011-01-01', '2011-12-31', 1),
(5, '2012-01-01', '2012-12-31', 1),
(6, '2013-01-01', '2013-12-31', 1),
(7, '2014-01-01', '2014-12-31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_gl_trans`
--

CREATE TABLE IF NOT EXISTS `2_gl_trans` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `2_gl_trans`
--

INSERT INTO `2_gl_trans` (`counter`, `type`, `type_no`, `tran_date`, `account`, `memo_`, `amount`, `dimension_id`, `dimension2_id`, `person_type_id`, `person_id`) VALUES
(1, 10, 1, '2014-11-24', '4010', '', -3050, 0, 0, 2, 0x31),
(2, 10, 1, '2014-11-24', '', '', 3196.4, 0, 0, 2, 0x31),
(3, 10, 1, '2014-11-24', '2150', '', -146.4, 0, 0, 2, 0x31),
(4, 12, 1, '2014-11-24', '1065', '', 3196.4, 0, 0, 2, 0x31),
(5, 12, 1, '2014-11-24', '', '', -3196.4, 0, 0, 2, 0x31),
(6, 10, 2, '2014-11-24', '4010', '', -2258, 0, 0, 2, 0x34),
(7, 10, 2, '2014-11-24', '', '', 2366.38, 0, 0, 2, 0x34),
(8, 10, 2, '2014-11-24', '2150', '', -108.38, 0, 0, 2, 0x34),
(9, 12, 2, '2014-11-24', '1065', '', 2366.38, 0, 0, 2, 0x34),
(10, 12, 2, '2014-11-24', '', '', -2366.38, 0, 0, 2, 0x34);

-- --------------------------------------------------------

--
-- Table structure for table `2_grn_batch`
--

CREATE TABLE IF NOT EXISTS `2_grn_batch` (
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
-- Table structure for table `2_grn_items`
--

CREATE TABLE IF NOT EXISTS `2_grn_items` (
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
-- Table structure for table `2_groups`
--

CREATE TABLE IF NOT EXISTS `2_groups` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `2_groups`
--

INSERT INTO `2_groups` (`id`, `description`, `inactive`) VALUES
(1, 'Small', 0),
(2, 'Medium', 0),
(3, 'Large', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_item_codes`
--

CREATE TABLE IF NOT EXISTS `2_item_codes` (
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

--
-- Dumping data for table `2_item_codes`
--

INSERT INTO `2_item_codes` (`id`, `item_code`, `stock_id`, `description`, `category_id`, `quantity`, `is_foreign`, `inactive`) VALUES
(1, '101', '101', 'Trip', 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_item_tax_types`
--

CREATE TABLE IF NOT EXISTS `2_item_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `exempt` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `2_item_tax_types`
--

INSERT INTO `2_item_tax_types` (`id`, `name`, `exempt`, `inactive`) VALUES
(1, 'Regular', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_item_tax_type_exemptions`
--

CREATE TABLE IF NOT EXISTS `2_item_tax_type_exemptions` (
  `item_tax_type_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_tax_type_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `2_item_units`
--

CREATE TABLE IF NOT EXISTS `2_item_units` (
  `abbr` varchar(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `decimals` tinyint(2) NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`abbr`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_item_units`
--

INSERT INTO `2_item_units` (`abbr`, `name`, `decimals`, `inactive`) VALUES
('km', 'Kilometer', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_locations`
--

CREATE TABLE IF NOT EXISTS `2_locations` (
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
-- Dumping data for table `2_locations`
--

INSERT INTO `2_locations` (`loc_code`, `location_name`, `delivery_address`, `phone`, `phone2`, `fax`, `email`, `contact`, `inactive`) VALUES
('DEF', 'Default', 'N/A', '', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_loc_stock`
--

CREATE TABLE IF NOT EXISTS `2_loc_stock` (
  `loc_code` char(5) NOT NULL DEFAULT '',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `reorder_level` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loc_code`,`stock_id`),
  KEY `stock_id` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_loc_stock`
--

INSERT INTO `2_loc_stock` (`loc_code`, `stock_id`, `reorder_level`) VALUES
('DEF', '101', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_movement_types`
--

CREATE TABLE IF NOT EXISTS `2_movement_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `2_movement_types`
--

INSERT INTO `2_movement_types` (`id`, `name`, `inactive`) VALUES
(1, 'Adjustment', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_payment_terms`
--

CREATE TABLE IF NOT EXISTS `2_payment_terms` (
  `terms_indicator` int(11) NOT NULL AUTO_INCREMENT,
  `terms` char(80) NOT NULL DEFAULT '',
  `days_before_due` smallint(6) NOT NULL DEFAULT '0',
  `day_in_following_month` smallint(6) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`terms_indicator`),
  UNIQUE KEY `terms` (`terms`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `2_payment_terms`
--

INSERT INTO `2_payment_terms` (`terms_indicator`, `terms`, `days_before_due`, `day_in_following_month`, `inactive`) VALUES
(1, 'Due 15th Of the Following Month', 0, 17, 0),
(2, 'Due By End Of The Following Month', 0, 30, 0),
(3, 'Payment due within 10 days', 10, 0, 0),
(4, 'Cash Only', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_prices`
--

CREATE TABLE IF NOT EXISTS `2_prices` (
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
-- Table structure for table `2_printers`
--

CREATE TABLE IF NOT EXISTS `2_printers` (
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
-- Dumping data for table `2_printers`
--

INSERT INTO `2_printers` (`id`, `name`, `description`, `queue`, `host`, `port`, `timeout`) VALUES
(1, 'QL500', 'Label printer', 'QL500', 'server', 127, 20),
(2, 'Samsung', 'Main network printer', 'scx4521F', 'server', 515, 5),
(3, 'Local', 'Local print server at user IP', 'lp', '', 515, 10);

-- --------------------------------------------------------

--
-- Table structure for table `2_print_profiles`
--

CREATE TABLE IF NOT EXISTS `2_print_profiles` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `profile` varchar(30) NOT NULL,
  `report` varchar(5) DEFAULT NULL,
  `printer` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile` (`profile`,`report`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `2_print_profiles`
--

INSERT INTO `2_print_profiles` (`id`, `profile`, `report`, `printer`) VALUES
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
-- Table structure for table `2_purch_data`
--

CREATE TABLE IF NOT EXISTS `2_purch_data` (
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
-- Table structure for table `2_purch_orders`
--

CREATE TABLE IF NOT EXISTS `2_purch_orders` (
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
-- Table structure for table `2_purch_order_details`
--

CREATE TABLE IF NOT EXISTS `2_purch_order_details` (
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
-- Table structure for table `2_quick_entries`
--

CREATE TABLE IF NOT EXISTS `2_quick_entries` (
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
-- Dumping data for table `2_quick_entries`
--

INSERT INTO `2_quick_entries` (`id`, `type`, `description`, `base_amount`, `base_desc`, `bal_type`) VALUES
(1, 1, 'Maintenance', 0, 'Amount', 0),
(2, 4, 'Phone', 0, 'Amount', 0),
(3, 2, 'Cash Sales', 0, 'Amount', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_quick_entry_lines`
--

CREATE TABLE IF NOT EXISTS `2_quick_entry_lines` (
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
-- Dumping data for table `2_quick_entry_lines`
--

INSERT INTO `2_quick_entry_lines` (`id`, `qid`, `amount`, `action`, `dest_id`, `dimension_id`, `dimension2_id`) VALUES
(1, 1, 0, 't-', '1', 0, 0),
(2, 2, 0, 't-', '1', 0, 0),
(3, 3, 0, 't-', '1', 0, 0),
(4, 3, 0, '=', '4010', 0, 0),
(5, 1, 0, '=', '5765', 0, 0),
(6, 2, 0, '=', '5780', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_recurrent_invoices`
--

CREATE TABLE IF NOT EXISTS `2_recurrent_invoices` (
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
-- Table structure for table `2_refs`
--

CREATE TABLE IF NOT EXISTS `2_refs` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`type`),
  KEY `Type_and_Reference` (`type`,`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_refs`
--

INSERT INTO `2_refs` (`id`, `type`, `reference`) VALUES
(1, 10, '5'),
(2, 10, '6'),
(1, 12, '5'),
(2, 12, '6'),
(1, 13, '1'),
(3, 13, '10'),
(2, 13, '3'),
(1, 30, 'auto'),
(2, 30, 'auto'),
(3, 30, 'auto');

-- --------------------------------------------------------

--
-- Table structure for table `2_salesman`
--

CREATE TABLE IF NOT EXISTS `2_salesman` (
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
-- Dumping data for table `2_salesman`
--

INSERT INTO `2_salesman` (`salesman_code`, `salesman_name`, `salesman_phone`, `salesman_fax`, `salesman_email`, `provision`, `break_pt`, `provision2`, `inactive`) VALUES
(1, 'Sales Person', '', '', '', 5, 1000, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_sales_orders`
--

CREATE TABLE IF NOT EXISTS `2_sales_orders` (
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

--
-- Dumping data for table `2_sales_orders`
--

INSERT INTO `2_sales_orders` (`order_no`, `trans_type`, `version`, `type`, `debtor_no`, `branch_code`, `reference`, `customer_ref`, `comments`, `ord_date`, `order_type`, `ship_via`, `delivery_address`, `contact_phone`, `contact_email`, `deliver_to`, `freight_cost`, `from_stk_loc`, `delivery_date`, `payment_terms`, `total`) VALUES
(1, 30, 1, 0, 4, 4, 'auto', '', 'Minimum 80 KM@ Rs 1550 + Additional  31 KM@18/KM + Driver Batta 150', '2014-11-18', 1, 0, '', '', NULL, 'Acube', 0, 'DEF', '2014-11-19', 0, 2366.38),
(2, 30, 1, 0, 10, 10, 'auto', '', 'Minimum 130 KM@ Rs 2500 + Additional  118 KM@12/KM + Driver Batta 150', '2014-11-18', 1, 0, '', '', NULL, 'Rajesh Vijayan', 0, 'DEF', '2014-11-19', 0, 4261.17),
(3, 30, 1, 0, 1, 1, 'auto', '', 'Minimum 120 KM@ Rs 2500 + Additional  30 KM@10/KM + Driver Batta 250', '2014-11-24', 1, 0, '', '', NULL, 'AVT', 0, 'DEF', '2014-11-25', 0, 3196.4);

-- --------------------------------------------------------

--
-- Table structure for table `2_sales_order_details`
--

CREATE TABLE IF NOT EXISTS `2_sales_order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL DEFAULT '0',
  `trans_type` smallint(6) NOT NULL DEFAULT '30',
  `stk_code` varchar(20) NOT NULL DEFAULT '',
  `description` tinytext,
  `qty_sent` double NOT NULL DEFAULT '0',
  `unit_price` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discount_percent` double NOT NULL DEFAULT '0',
  `trip_voucher` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sorder` (`trans_type`,`order_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `2_sales_order_details`
--

INSERT INTO `2_sales_order_details` (`id`, `order_no`, `trans_type`, `stk_code`, `description`, `qty_sent`, `unit_price`, `quantity`, `discount_percent`, `trip_voucher`) VALUES
(1, 1, 30, '101', 'Trip', 0, 2258, 1, 0, 1),
(2, 2, 30, '101', 'Trip', 0, 4066, 1, 0, 2),
(3, 3, 30, '101', 'Trip', 0, 3050, 1, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `2_sales_pos`
--

CREATE TABLE IF NOT EXISTS `2_sales_pos` (
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
-- Dumping data for table `2_sales_pos`
--

INSERT INTO `2_sales_pos` (`id`, `pos_name`, `cash_sale`, `credit_sale`, `pos_location`, `pos_account`, `inactive`) VALUES
(1, 'Default', 1, 1, 'DEF', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_sales_types`
--

CREATE TABLE IF NOT EXISTS `2_sales_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sales_type` char(50) NOT NULL DEFAULT '',
  `tax_included` int(1) NOT NULL DEFAULT '0',
  `factor` double NOT NULL DEFAULT '1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sales_type` (`sales_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `2_sales_types`
--

INSERT INTO `2_sales_types` (`id`, `sales_type`, `tax_included`, `factor`, `inactive`) VALUES
(1, 'Retail', 0, 1, 0),
(2, 'Wholesale', 0, 0.7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_security_roles`
--

CREATE TABLE IF NOT EXISTS `2_security_roles` (
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
-- Dumping data for table `2_security_roles`
--

INSERT INTO `2_security_roles` (`id`, `role`, `description`, `sections`, `areas`, `inactive`) VALUES
(1, 'Inquiries', 'Inquiries', '768;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15872;16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;773;774;2822;3073;3075;3076;3077;3329;3330;3331;3332;3333;3334;3335;5377;5633;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8450;8451;10497;10753;11009;11010;11012;13313;13315;15617;15618;15619;15620;15621;15622;15623;15624;15625;15626;15873;15882;16129;16130;16131;16132', 1),
(2, 'System Administrator', 'System Administrator', '256;512;768;2816;3072;3328;5376;5632;5888;7936;8192;8448;10496;10752;11008;13056;13312;15616;15872;16128', '257;258;259;260;513;514;515;516;517;518;519;520;521;522;523;524;525;526;769;770;771;772;773;774;2817;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5636;5637;5641;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8195;8196;8197;8449;8450;8451;10497;10753;10754;10755;10756;10757;11009;11010;11011;11012;13057;13313;13314;13315;15617;15618;15619;15620;15621;15622;15623;15624;15628;15625;15626;15627;15873;15874;15875;15876;15877;15878;15879;15880;15883;15881;15882;16129;16130;16131;16132', 0),
(3, 'Salesman', 'Salesman', '768;3072;5632;8192;15872', '773;774;3073;3075;3081;5633;8194;15873', 0),
(4, 'Stock Manager', 'Stock Manager', '2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15872;16128', '2818;2822;3073;3076;3077;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5640;5889;5890;5891;8193;8194;8450;8451;10753;11009;11010;11012;13313;13315;15882;16129;16130;16131;16132', 1),
(5, 'Production Manager', 'Production Manager', '512;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;2818;2819;2820;2821;2822;2823;3073;3074;3076;3077;3078;3079;3080;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5640;5640;5889;5890;5891;8193;8194;8196;8197;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(6, 'Purchase Officer', 'Purchase Officer', '512;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;2818;2819;2820;2821;2822;2823;3073;3074;3076;3077;3078;3079;3080;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5377;5633;5635;5640;5640;5889;5890;5891;8193;8194;8196;8197;8449;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(7, 'AR Officer', 'AR Officer', '512;768;2816;3072;3328;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;771;773;774;2818;2819;2820;2821;2822;2823;3073;3073;3074;3075;3076;3077;3078;3079;3080;3081;3081;3329;3330;3330;3330;3331;3331;3332;3333;3334;3335;5633;5633;5634;5637;5638;5639;5640;5640;5889;5890;5891;8193;8194;8194;8196;8197;8450;8451;10753;10755;11009;11010;11012;13313;13315;15617;15619;15620;15621;15624;15624;15873;15876;15877;15878;15880;15882;16129;16130;16131;16132', 1),
(8, 'AP Officer', 'AP Officer', '512;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '257;258;259;260;521;523;524;769;770;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3082;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5635;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13057;13313;13315;15617;15619;15620;15621;15624;15876;15877;15880;15882;16129;16130;16131;16132', 1),
(9, 'Accountant', 'New Accountant', '512;768;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '257;258;259;260;521;523;524;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5637;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13313;13315;15617;15618;15619;15620;15621;15624;15873;15876;15877;15878;15880;15882;16129;16130;16131;16132', 1),
(10, 'Frontdesk', 'Frontdesk', '512;768;2816;3072;3328;5376;5632;5888;8192;8448;10752;11008;13312;15616;15872;16128', '521;523;524;771;772;773;774;2818;2819;2820;2821;2822;2823;3073;3074;3082;3075;3076;3077;3078;3079;3080;3081;3329;3330;3331;3332;3333;3334;3335;5377;5633;5634;5635;5637;5638;5639;5640;5889;5890;5891;7937;7938;7939;7940;8193;8194;8196;8197;8449;8450;8451;10497;10753;10755;11009;11010;11012;13057;13313;13315;15617;15618;15619;15620;15621;15623;15624;15873;15874;15876;15877;15878;15879;15880;15882;16129;16130;16131;16132', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_shippers`
--

CREATE TABLE IF NOT EXISTS `2_shippers` (
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
-- Dumping data for table `2_shippers`
--

INSERT INTO `2_shippers` (`shipper_id`, `shipper_name`, `phone`, `phone2`, `contact`, `address`, `inactive`) VALUES
(1, 'Default', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_sql_trail`
--

CREATE TABLE IF NOT EXISTS `2_sql_trail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sql` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `2_stock_category`
--

CREATE TABLE IF NOT EXISTS `2_stock_category` (
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
-- Dumping data for table `2_stock_category`
--

INSERT INTO `2_stock_category` (`category_id`, `description`, `dflt_tax_type`, `dflt_units`, `dflt_mb_flag`, `dflt_sales_act`, `dflt_cogs_act`, `dflt_inventory_act`, `dflt_adjustment_act`, `dflt_assembly_act`, `dflt_dim1`, `dflt_dim2`, `inactive`, `dflt_no_sale`) VALUES
(1, 'Services', 1, 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_stock_master`
--

CREATE TABLE IF NOT EXISTS `2_stock_master` (
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

--
-- Dumping data for table `2_stock_master`
--

INSERT INTO `2_stock_master` (`stock_id`, `category_id`, `tax_type_id`, `description`, `long_description`, `units`, `mb_flag`, `sales_account`, `cogs_account`, `inventory_account`, `adjustment_account`, `assembly_account`, `dimension_id`, `dimension2_id`, `actual_cost`, `last_cost`, `material_cost`, `labour_cost`, `overhead_cost`, `inactive`, `no_sale`, `editable`) VALUES
('101', 1, 1, 'Trip', '', 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_stock_moves`
--

CREATE TABLE IF NOT EXISTS `2_stock_moves` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `2_stock_moves`
--

INSERT INTO `2_stock_moves` (`trans_id`, `trans_no`, `stock_id`, `type`, `loc_code`, `tran_date`, `person_id`, `price`, `reference`, `qty`, `discount_percent`, `standard_cost`, `visible`) VALUES
(1, 1, '101', 13, 'DEF', '2014-11-18', 0, 2258, '1', -1, 0, 0, 1),
(2, 2, '101', 13, 'DEF', '2014-11-18', 0, 4066, '3', -1, 0, 0, 1),
(3, 3, '101', 13, 'DEF', '2014-11-24', 0, 3050, '10', -1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `2_suppliers`
--

CREATE TABLE IF NOT EXISTS `2_suppliers` (
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
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`supplier_id`),
  KEY `supp_ref` (`supp_ref`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `2_suppliers`
--

INSERT INTO `2_suppliers` (`supplier_id`, `supp_name`, `supp_ref`, `address`, `supp_address`, `gst_no`, `contact`, `supp_account_no`, `website`, `bank_account`, `curr_code`, `payment_terms`, `tax_included`, `dimension_id`, `dimension2_id`, `tax_group_id`, `credit_limit`, `purchase_account`, `payable_account`, `payment_discount_account`, `notes`, `inactive`) VALUES
(1, 'Rosy', 'DR1', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', '', '', '', '', '4E+11', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(2, 'Siva Kumar', 'DR2', 'House, Street, District.', 'House, Street, District.', '', '', '', '', '12345645656456', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(3, 'Swapna', 'DR3', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', '', '', '', '', '4E+11', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(4, 'Krishnan', 'DR4', 'Palarivattom', 'Palarivattom', '', '', '', '', '123456', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(5, 'Sunny Thomas', 'VW3', 'Sunny Thomas,\n House, Street,\n District.', 'Sunny Thomas,\n House, Street,\n District.', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(6, 'Nisith Ram', 'VW4', 'House, Street, District.', 'House, Street, District.', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(7, 'Mary Varghese', 'VW5', 'House no, Plot, District.', 'House no, Plot, District.', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(8, 'Jacob', 'DR8', 'House no 1\nstreet no 2\npost office p o\nErnakulam', 'House no 1\nstreet no 2\npost office p o\nErnakulam', '', '', '', '', '6523658569854', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(9, 'Arun Arun', 'DR10', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', '', '', '', '', '4E+11', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(10, 'haloop', 'DR56', 'ernakulam\nkerala', 'ernakulam\nkerala', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_supp_allocations`
--

CREATE TABLE IF NOT EXISTS `2_supp_allocations` (
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
-- Table structure for table `2_supp_invoice_items`
--

CREATE TABLE IF NOT EXISTS `2_supp_invoice_items` (
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
-- Table structure for table `2_supp_trans`
--

CREATE TABLE IF NOT EXISTS `2_supp_trans` (
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
-- Table structure for table `2_sys_prefs`
--

CREATE TABLE IF NOT EXISTS `2_sys_prefs` (
  `name` varchar(35) NOT NULL DEFAULT '',
  `category` varchar(30) DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `length` smallint(6) DEFAULT NULL,
  `value` tinytext,
  PRIMARY KEY (`name`),
  KEY `category` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_sys_prefs`
--

INSERT INTO `2_sys_prefs` (`name`, `category`, `type`, `length`, `value`) VALUES
('coy_name', 'setup.company', 'varchar', 60, 'CONNECTNCABS'),
('gst_no', 'setup.company', 'varchar', 25, ''),
('coy_no', 'setup.company', 'varchar', 25, ''),
('tax_prd', 'setup.company', 'int', 11, '1'),
('tax_last', 'setup.company', 'int', 11, '1'),
('postal_address', 'setup.company', 'tinytext', 0, 'Connect n cabs, Kaloor, Ernakulam, kerala'),
('phone', 'setup.company', 'varchar', 30, '9020964268'),
('fax', 'setup.company', 'varchar', 30, ''),
('email', 'setup.company', 'varchar', 100, 'connectncabs@connectncabs.com'),
('coy_logo', 'setup.company', 'varchar', 100, ''),
('domicile', 'setup.company', 'varchar', 55, ''),
('curr_default', 'setup.company', 'char', 3, 'INR'),
('use_dimension', 'setup.company', 'tinyint', 1, '1'),
('f_year', 'setup.company', 'int', 11, '7'),
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
('creditors_act', 'glsetup.purchase', 'varchar', 15, '2100'),
('po_over_receive', 'glsetup.purchase', 'int', 11, '10'),
('po_over_charge', 'glsetup.purchase', 'int', 11, '10'),
('allow_negative_stock', 'glsetup.inventory', 'tinyint', 1, '0'),
('default_inventory_act', 'glsetup.items', 'varchar', 15, '1510'),
('default_cogs_act', 'glsetup.items', 'varchar', 15, '5010'),
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
-- Table structure for table `2_sys_types`
--

CREATE TABLE IF NOT EXISTS `2_sys_types` (
  `type_id` smallint(6) NOT NULL DEFAULT '0',
  `type_no` int(11) NOT NULL DEFAULT '1',
  `next_reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_sys_types`
--

INSERT INTO `2_sys_types` (`type_id`, `type_no`, `next_reference`) VALUES
(0, 17, '1'),
(1, 7, '1'),
(2, 4, '1'),
(4, 3, '1'),
(10, 16, '7'),
(11, 2, '1'),
(12, 6, '7'),
(13, 1, '2'),
(16, 2, '1'),
(17, 2, '1'),
(18, 1, '1'),
(20, 6, '1'),
(21, 1, '1'),
(22, 3, '2'),
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
-- Table structure for table `2_tags`
--

CREATE TABLE IF NOT EXISTS `2_tags` (
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
-- Table structure for table `2_tag_associations`
--

CREATE TABLE IF NOT EXISTS `2_tag_associations` (
  `record_id` varchar(15) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `record_id` (`record_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `2_tax_groups`
--

CREATE TABLE IF NOT EXISTS `2_tax_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `tax_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `2_tax_groups`
--

INSERT INTO `2_tax_groups` (`id`, `name`, `tax_shipping`, `inactive`) VALUES
(1, 'Inclusive', 0, 0),
(2, 'Exclusive', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_tax_group_items`
--

CREATE TABLE IF NOT EXISTS `2_tax_group_items` (
  `tax_group_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`tax_group_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `2_tax_group_items`
--

INSERT INTO `2_tax_group_items` (`tax_group_id`, `tax_type_id`, `rate`) VALUES
(2, 1, 12),
(2, 2, 0.24),
(2, 3, 0.12);

-- --------------------------------------------------------

--
-- Table structure for table `2_tax_types`
--

CREATE TABLE IF NOT EXISTS `2_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` double NOT NULL DEFAULT '0',
  `sales_gl_code` varchar(15) NOT NULL DEFAULT '',
  `purchasing_gl_code` varchar(15) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `2_tax_types`
--

INSERT INTO `2_tax_types` (`id`, `rate`, `sales_gl_code`, `purchasing_gl_code`, `name`, `inactive`) VALUES
(1, 12, '2381', '2381', 'Service Tax', 0),
(2, 0.24, '2382', '2382', 'Education Cess', 0),
(3, 0.12, '2383', '2383', 'Higher Education Cess', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_trans_tax_details`
--

CREATE TABLE IF NOT EXISTS `2_trans_tax_details` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `2_trans_tax_details`
--

INSERT INTO `2_trans_tax_details` (`id`, `trans_type`, `trans_no`, `tran_date`, `tax_type_id`, `rate`, `ex_rate`, `included_in_price`, `net_amount`, `amount`, `memo`) VALUES
(1, 13, 1, '2014-11-18', 1, 12, 1, 0, 903.2, 108.384, '1'),
(2, 13, 2, '2014-11-18', 1, 12, 1, 0, 1626.4, 195.168, '3'),
(3, 13, 3, '2014-11-24', 1, 12, 1, 0, 1220, 146.4, '10'),
(4, 10, 1, '2014-11-24', 1, 12, 1, 0, 1220, 146.4, '5'),
(5, 10, 2, '2014-11-24', 1, 12, 1, 0, 903.2, 108.384, '6');

-- --------------------------------------------------------

--
-- Table structure for table `2_useronline`
--

CREATE TABLE IF NOT EXISTS `2_useronline` (
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
-- Table structure for table `2_users`
--

CREATE TABLE IF NOT EXISTS `2_users` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `2_users`
--

INSERT INTO `2_users` (`id`, `user_id`, `password`, `real_name`, `role_id`, `phone`, `email`, `language`, `date_format`, `date_sep`, `tho_sep`, `dec_sep`, `theme`, `page_size`, `prices_dec`, `qty_dec`, `rates_dec`, `percent_dec`, `show_gl`, `show_codes`, `show_hints`, `last_visit_date`, `query_size`, `graphic_links`, `pos`, `print_profile`, `rep_popup`, `sticky_doc_date`, `startup_tab`, `inactive`) VALUES
(1, 'connectncabs', '7e4da08906338586b3756c3fa0f5bb89', 'Administrator', 2, '', 'adm@adm.com', 'C', 0, 0, 0, 0, 'cnc', 'Letter', 2, 2, 4, 2, 1, 0, 0, '2014-11-28 10:50:02', 10, 1, 1, '', 1, 0, 'orders', 0),
(2, 'nijojoseph', 'bf8191475f55068537a0dc716078dddb', 'Nijo Joseph', 10, '9020964268', 'nijojoseph@acube.co', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2014-12-03 06:16:08', 10, 1, 1, '', 1, 0, 'orders', 0),
(3, 'ratheesh', 'e10adc3949ba59abbe56e057f20f883e', 'Ratheesh Vijayan', 10, '9946109570', 'ratheeshvijayan@acube.co', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2014-11-24 12:34:54', 10, 1, 1, '', 1, 0, 'orders', 0),
(4, 'rajeshtr', 'e10adc3949ba59abbe56e057f20f883e', 'Rajesh T R', 10, '9946999354', 'rajeshtr@acube.co', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, NULL, 10, 1, 1, '', 1, 0, 'orders', 0),
(5, 'rajkumar', 'e10adc3949ba59abbe56e057f20f883e', 'Rajkumar Rajkumar', 10, '9645689669', 'mail@connectncabs.com', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2014-10-17 09:07:16', 10, 1, 1, '', 1, 0, 'orders', 0),
(6, 'sajukumar', 'e10adc3949ba59abbe56e057f20f883e', 'Saju Kumar', 10, '9946109575', 'mail1@connectncabs.com', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, NULL, 10, 1, 1, '', 1, 0, 'orders', 0),
(7, 'valsa', 'e10adc3949ba59abbe56e057f20f883e', 'Valsa Sajukumar', 10, '9946109578', 'mail2@connectncabs.com', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, NULL, 10, 1, 1, '', 1, 0, 'orders', 0);

-- --------------------------------------------------------

--
-- Table structure for table `2_voided`
--

CREATE TABLE IF NOT EXISTS `2_voided` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  `memo_` tinytext NOT NULL,
  UNIQUE KEY `id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `2_workcentres`
--

CREATE TABLE IF NOT EXISTS `2_workcentres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `description` char(50) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `2_workorders`
--

CREATE TABLE IF NOT EXISTS `2_workorders` (
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
-- Table structure for table `2_wo_issues`
--

CREATE TABLE IF NOT EXISTS `2_wo_issues` (
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
-- Table structure for table `2_wo_issue_items`
--

CREATE TABLE IF NOT EXISTS `2_wo_issue_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(40) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `qty_issued` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `2_wo_manufacture`
--

CREATE TABLE IF NOT EXISTS `2_wo_manufacture` (
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
-- Table structure for table `2_wo_requirements`
--

CREATE TABLE IF NOT EXISTS `2_wo_requirements` (
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
-- Table structure for table `4_areas`
--

CREATE TABLE IF NOT EXISTS `4_areas` (
  `area_code` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`area_code`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_areas`
--

INSERT INTO `4_areas` (`area_code`, `description`, `inactive`) VALUES
(1, 'Global', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_attachments`
--

CREATE TABLE IF NOT EXISTS `4_attachments` (
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
-- Table structure for table `4_audit_trail`
--

CREATE TABLE IF NOT EXISTS `4_audit_trail` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `4_audit_trail`
--

INSERT INTO `4_audit_trail` (`id`, `type`, `trans_no`, `user`, `stamp`, `description`, `fiscal_year`, `gl_date`, `gl_seq`) VALUES
(1, 30, 1, 2, '2014-11-26 11:04:48', '', 7, '2014-11-26', 0),
(2, 13, 1, 2, '2014-11-26 11:04:48', '', 7, '2014-11-26', 0),
(3, 10, 1, 2, '2014-11-26 11:05:36', '', 7, '2014-11-26', 0),
(4, 12, 1, 2, '2014-11-26 11:05:36', '', 7, '2014-11-26', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_bank_accounts`
--

CREATE TABLE IF NOT EXISTS `4_bank_accounts` (
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

--
-- Dumping data for table `4_bank_accounts`
--

INSERT INTO `4_bank_accounts` (`account_code`, `account_type`, `bank_account_name`, `bank_account_number`, `bank_name`, `bank_address`, `bank_curr_code`, `dflt_curr_act`, `id`, `last_reconciled_date`, `ending_reconcile_balance`, `inactive`) VALUES
('1060', 0, 'Current account', 'N/A', 'N/A', '', 'INR', 1, 1, '0000-00-00 00:00:00', 0, 0),
('1065', 3, 'Petty Cash account', 'N/A', 'N/A', '', 'INR', 0, 2, '0000-00-00 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_bank_trans`
--

CREATE TABLE IF NOT EXISTS `4_bank_trans` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_bank_trans`
--

INSERT INTO `4_bank_trans` (`id`, `type`, `trans_no`, `bank_act`, `ref`, `trans_date`, `amount`, `dimension_id`, `dimension2_id`, `person_type_id`, `person_id`, `reconciled`) VALUES
(1, 12, 1, '2', '1', '2014-11-26', 2240, 0, 0, 2, 0x35, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `4_bom`
--

CREATE TABLE IF NOT EXISTS `4_bom` (
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
-- Table structure for table `4_budget_trans`
--

CREATE TABLE IF NOT EXISTS `4_budget_trans` (
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
-- Table structure for table `4_chart_class`
--

CREATE TABLE IF NOT EXISTS `4_chart_class` (
  `cid` varchar(3) NOT NULL,
  `class_name` varchar(60) NOT NULL DEFAULT '',
  `ctype` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_chart_class`
--

INSERT INTO `4_chart_class` (`cid`, `class_name`, `ctype`, `inactive`) VALUES
('1', 'Assets', 1, 0),
('2', 'Liabilities', 2, 0),
('3', 'Income', 4, 0),
('4', 'Costs', 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_chart_master`
--

CREATE TABLE IF NOT EXISTS `4_chart_master` (
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
-- Dumping data for table `4_chart_master`
--

INSERT INTO `4_chart_master` (`account_code`, `account_code2`, `account_name`, `account_type`, `inactive`) VALUES
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
-- Table structure for table `4_chart_types`
--

CREATE TABLE IF NOT EXISTS `4_chart_types` (
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
-- Dumping data for table `4_chart_types`
--

INSERT INTO `4_chart_types` (`id`, `name`, `class_id`, `parent`, `inactive`) VALUES
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
-- Table structure for table `4_comments`
--

CREATE TABLE IF NOT EXISTS `4_comments` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date DEFAULT '0000-00-00',
  `memo_` tinytext,
  KEY `type_and_id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_comments`
--

INSERT INTO `4_comments` (`type`, `id`, `date_`, `memo_`) VALUES
(13, 1, '2014-11-26', 'Minimum 80 KM@ Rs 1550 + Additional  46 KM@15/KM'),
(10, 1, '2014-11-26', 'Minimum 80 KM@ Rs 1550 + Additional  46 KM@15/KM'),
(12, 1, '2014-11-26', 'Cash invoice 1');

-- --------------------------------------------------------

--
-- Table structure for table `4_credit_status`
--

CREATE TABLE IF NOT EXISTS `4_credit_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_description` char(100) NOT NULL DEFAULT '',
  `dissallow_invoices` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reason_description` (`reason_description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `4_credit_status`
--

INSERT INTO `4_credit_status` (`id`, `reason_description`, `dissallow_invoices`, `inactive`) VALUES
(1, 'Good History', 0, 0),
(3, 'No more work until payment received', 1, 0),
(4, 'In liquidation', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_crm_categories`
--

CREATE TABLE IF NOT EXISTS `4_crm_categories` (
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
-- Dumping data for table `4_crm_categories`
--

INSERT INTO `4_crm_categories` (`id`, `type`, `action`, `name`, `description`, `system`, `inactive`) VALUES
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
-- Table structure for table `4_crm_contacts`
--

CREATE TABLE IF NOT EXISTS `4_crm_contacts` (
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
-- Table structure for table `4_crm_persons`
--

CREATE TABLE IF NOT EXISTS `4_crm_persons` (
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
-- Table structure for table `4_currencies`
--

CREATE TABLE IF NOT EXISTS `4_currencies` (
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
-- Dumping data for table `4_currencies`
--

INSERT INTO `4_currencies` (`currency`, `curr_abrev`, `curr_symbol`, `country`, `hundreds_name`, `auto_update`, `inactive`) VALUES
('Indian Rupee', 'INR', '?', 'India', 'Rs', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_cust_allocations`
--

CREATE TABLE IF NOT EXISTS `4_cust_allocations` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_cust_allocations`
--

INSERT INTO `4_cust_allocations` (`id`, `amt`, `date_alloc`, `trans_no_from`, `trans_type_from`, `trans_no_to`, `trans_type_to`) VALUES
(1, 2240, '2014-11-26', 1, 12, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `4_cust_branch`
--

CREATE TABLE IF NOT EXISTS `4_cust_branch` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `4_cust_branch`
--

INSERT INTO `4_cust_branch` (`branch_code`, `debtor_no`, `br_name`, `branch_ref`, `br_address`, `area`, `salesman`, `contact_name`, `default_location`, `tax_group_id`, `sales_account`, `sales_discount_account`, `receivables_account`, `payment_discount_account`, `default_ship_via`, `disable_trans`, `br_post_address`, `group_no`, `notes`, `inactive`) VALUES
(1, 1, 'Acube', 'CG6', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(2, 2, 'AVT', 'CG7', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(3, 3, 'OMS', 'CG8', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(4, 4, 'Nijo', 'C12', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(5, 5, 'Ratheesh Kumar', 'C14', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0),
(6, 6, 'Sarath', 'C15', '', NULL, 0, '', 'DEF', 1, '', '', '', '', 1, 0, '', 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_debtors_master`
--

CREATE TABLE IF NOT EXISTS `4_debtors_master` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `4_debtors_master`
--

INSERT INTO `4_debtors_master` (`debtor_no`, `name`, `debtor_ref`, `address`, `tax_id`, `curr_code`, `sales_type`, `dimension_id`, `dimension2_id`, `credit_status`, `payment_terms`, `discount`, `pymt_discount`, `credit_limit`, `notes`, `inactive`) VALUES
(1, 'Acube', 'CG6', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(2, 'AVT', 'CG7', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(3, 'OMS', 'CG8', NULL, '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(4, 'Nijo', 'C12', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(5, 'Ratheesh Kumar', 'C14', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0),
(6, 'Sarath', 'C15', '', '', 'INR', 1, 0, 0, 0, 4, 0, 0, 1000, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_debtor_trans`
--

CREATE TABLE IF NOT EXISTS `4_debtor_trans` (
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
  PRIMARY KEY (`type`,`trans_no`),
  KEY `debtor_no` (`debtor_no`,`branch_code`),
  KEY `tran_date` (`tran_date`),
  KEY `order_` (`order_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_debtor_trans`
--

INSERT INTO `4_debtor_trans` (`trans_no`, `type`, `version`, `debtor_no`, `branch_code`, `tran_date`, `due_date`, `reference`, `tpe`, `order_`, `ov_amount`, `ov_gst`, `ov_freight`, `ov_freight_tax`, `ov_discount`, `alloc`, `rate`, `ship_via`, `dimension_id`, `dimension2_id`, `payment_terms`) VALUES
(1, 10, 0, 5, 5, '2014-11-26', '2014-11-26', '1', 1, 1, 2240, 0, 0, 0, 0, 2240, 1, 1, 0, 0, 4),
(1, 12, 0, 5, 5, '2014-11-26', '0000-00-00', '1', 0, 0, 2240, 0, 0, 0, 0, 2240, 1, 0, 0, 0, NULL),
(1, 13, 1, 5, 5, '2014-11-26', '2014-11-27', '14', 1, 1, 2240, 44.8, 0, 0, 0, 0, 1, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `4_debtor_trans_details`
--

CREATE TABLE IF NOT EXISTS `4_debtor_trans_details` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `4_debtor_trans_details`
--

INSERT INTO `4_debtor_trans_details` (`id`, `debtor_trans_no`, `debtor_trans_type`, `stock_id`, `description`, `unit_price`, `unit_taxable_amount`, `unit_tax`, `quantity`, `discount_percent`, `standard_cost`, `qty_done`, `src_id`, `trip_voucher`) VALUES
(7, 1, 13, '101', 'Trip', 2240, 896, 44.8, 1, 0, 0, 1, 0, 7),
(8, 1, 10, '101', 'Trip', 2240, 896, 1344, 1, 0, 0, 0, 7, 7);

-- --------------------------------------------------------

--
-- Table structure for table `4_dimensions`
--

CREATE TABLE IF NOT EXISTS `4_dimensions` (
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
-- Table structure for table `4_exchange_rates`
--

CREATE TABLE IF NOT EXISTS `4_exchange_rates` (
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
-- Table structure for table `4_fiscal_year`
--

CREATE TABLE IF NOT EXISTS `4_fiscal_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT '0000-00-00',
  `end` date DEFAULT '0000-00-00',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `begin` (`begin`),
  UNIQUE KEY `end` (`end`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `4_fiscal_year`
--

INSERT INTO `4_fiscal_year` (`id`, `begin`, `end`, `closed`) VALUES
(1, '2008-01-01', '2008-12-31', 0),
(2, '2009-01-01', '2009-12-31', 0),
(3, '2010-01-01', '2010-12-31', 0),
(4, '2011-01-01', '2011-12-31', 0),
(5, '2012-01-01', '2012-12-31', 0),
(6, '2013-01-01', '2013-12-31', 0),
(7, '2014-01-01', '2014-12-31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_gl_trans`
--

CREATE TABLE IF NOT EXISTS `4_gl_trans` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `4_gl_trans`
--

INSERT INTO `4_gl_trans` (`counter`, `type`, `type_no`, `tran_date`, `account`, `memo_`, `amount`, `dimension_id`, `dimension2_id`, `person_type_id`, `person_id`) VALUES
(1, 10, 1, '2014-11-26', '4010', '', -2133.33, 0, 0, 2, 0x35),
(2, 10, 1, '2014-11-26', '', '', 2240, 0, 0, 2, 0x35),
(3, 10, 1, '2014-11-26', '2150', '', -42.67, 0, 0, 2, 0x35),
(4, 10, 1, '2014-11-26', '4450', '', -64, 0, 0, 2, 0x35),
(5, 12, 1, '2014-11-26', '1065', '', 2240, 0, 0, 2, 0x35),
(6, 12, 1, '2014-11-26', '', '', -2240, 0, 0, 2, 0x35);

-- --------------------------------------------------------

--
-- Table structure for table `4_grn_batch`
--

CREATE TABLE IF NOT EXISTS `4_grn_batch` (
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
-- Table structure for table `4_grn_items`
--

CREATE TABLE IF NOT EXISTS `4_grn_items` (
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
-- Table structure for table `4_groups`
--

CREATE TABLE IF NOT EXISTS `4_groups` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `4_groups`
--

INSERT INTO `4_groups` (`id`, `description`, `inactive`) VALUES
(1, 'Small', 0),
(2, 'Medium', 0),
(3, 'Large', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_item_codes`
--

CREATE TABLE IF NOT EXISTS `4_item_codes` (
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

--
-- Dumping data for table `4_item_codes`
--

INSERT INTO `4_item_codes` (`id`, `item_code`, `stock_id`, `description`, `category_id`, `quantity`, `is_foreign`, `inactive`) VALUES
(1, '101', '101', 'Trip', 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_item_tax_types`
--

CREATE TABLE IF NOT EXISTS `4_item_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `exempt` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_item_tax_types`
--

INSERT INTO `4_item_tax_types` (`id`, `name`, `exempt`, `inactive`) VALUES
(1, 'Regular', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_item_tax_type_exemptions`
--

CREATE TABLE IF NOT EXISTS `4_item_tax_type_exemptions` (
  `item_tax_type_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_tax_type_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `4_item_units`
--

CREATE TABLE IF NOT EXISTS `4_item_units` (
  `abbr` varchar(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `decimals` tinyint(2) NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`abbr`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_item_units`
--

INSERT INTO `4_item_units` (`abbr`, `name`, `decimals`, `inactive`) VALUES
('km', 'Kilometer', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_locations`
--

CREATE TABLE IF NOT EXISTS `4_locations` (
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
-- Dumping data for table `4_locations`
--

INSERT INTO `4_locations` (`loc_code`, `location_name`, `delivery_address`, `phone`, `phone2`, `fax`, `email`, `contact`, `inactive`) VALUES
('DEF', 'Default', 'N/A', '', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_loc_stock`
--

CREATE TABLE IF NOT EXISTS `4_loc_stock` (
  `loc_code` char(5) NOT NULL DEFAULT '',
  `stock_id` char(20) NOT NULL DEFAULT '',
  `reorder_level` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loc_code`,`stock_id`),
  KEY `stock_id` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_loc_stock`
--

INSERT INTO `4_loc_stock` (`loc_code`, `stock_id`, `reorder_level`) VALUES
('DEF', '101', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_movement_types`
--

CREATE TABLE IF NOT EXISTS `4_movement_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_movement_types`
--

INSERT INTO `4_movement_types` (`id`, `name`, `inactive`) VALUES
(1, 'Adjustment', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_payment_terms`
--

CREATE TABLE IF NOT EXISTS `4_payment_terms` (
  `terms_indicator` int(11) NOT NULL AUTO_INCREMENT,
  `terms` char(80) NOT NULL DEFAULT '',
  `days_before_due` smallint(6) NOT NULL DEFAULT '0',
  `day_in_following_month` smallint(6) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`terms_indicator`),
  UNIQUE KEY `terms` (`terms`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `4_payment_terms`
--

INSERT INTO `4_payment_terms` (`terms_indicator`, `terms`, `days_before_due`, `day_in_following_month`, `inactive`) VALUES
(1, 'Due 15th Of the Following Month', 0, 17, 0),
(2, 'Due By End Of The Following Month', 0, 30, 0),
(3, 'Payment due within 10 days', 10, 0, 0),
(4, 'Cash Only', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_prices`
--

CREATE TABLE IF NOT EXISTS `4_prices` (
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
-- Table structure for table `4_printers`
--

CREATE TABLE IF NOT EXISTS `4_printers` (
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
-- Dumping data for table `4_printers`
--

INSERT INTO `4_printers` (`id`, `name`, `description`, `queue`, `host`, `port`, `timeout`) VALUES
(1, 'QL500', 'Label printer', 'QL500', 'server', 127, 20),
(2, 'Samsung', 'Main network printer', 'scx4521F', 'server', 515, 5),
(3, 'Local', 'Local print server at user IP', 'lp', '', 515, 10);

-- --------------------------------------------------------

--
-- Table structure for table `4_print_profiles`
--

CREATE TABLE IF NOT EXISTS `4_print_profiles` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `profile` varchar(30) NOT NULL,
  `report` varchar(5) DEFAULT NULL,
  `printer` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile` (`profile`,`report`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `4_print_profiles`
--

INSERT INTO `4_print_profiles` (`id`, `profile`, `report`, `printer`) VALUES
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
-- Table structure for table `4_purch_data`
--

CREATE TABLE IF NOT EXISTS `4_purch_data` (
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
-- Table structure for table `4_purch_orders`
--

CREATE TABLE IF NOT EXISTS `4_purch_orders` (
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
-- Table structure for table `4_purch_order_details`
--

CREATE TABLE IF NOT EXISTS `4_purch_order_details` (
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
-- Table structure for table `4_quick_entries`
--

CREATE TABLE IF NOT EXISTS `4_quick_entries` (
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
-- Dumping data for table `4_quick_entries`
--

INSERT INTO `4_quick_entries` (`id`, `type`, `description`, `base_amount`, `base_desc`, `bal_type`) VALUES
(1, 1, 'Maintenance', 0, 'Amount', 0),
(2, 4, 'Phone', 0, 'Amount', 0),
(3, 2, 'Cash Sales', 0, 'Amount', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_quick_entry_lines`
--

CREATE TABLE IF NOT EXISTS `4_quick_entry_lines` (
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
-- Dumping data for table `4_quick_entry_lines`
--

INSERT INTO `4_quick_entry_lines` (`id`, `qid`, `amount`, `action`, `dest_id`, `dimension_id`, `dimension2_id`) VALUES
(1, 1, 0, 't-', '1', 0, 0),
(2, 2, 0, 't-', '1', 0, 0),
(3, 3, 0, 't-', '1', 0, 0),
(4, 3, 0, '=', '4010', 0, 0),
(5, 1, 0, '=', '5765', 0, 0),
(6, 2, 0, '=', '5780', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_recurrent_invoices`
--

CREATE TABLE IF NOT EXISTS `4_recurrent_invoices` (
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
-- Table structure for table `4_refs`
--

CREATE TABLE IF NOT EXISTS `4_refs` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`type`),
  KEY `Type_and_Reference` (`type`,`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_refs`
--

INSERT INTO `4_refs` (`id`, `type`, `reference`) VALUES
(1, 10, '1'),
(1, 12, '1'),
(1, 13, '14'),
(1, 30, 'auto');

-- --------------------------------------------------------

--
-- Table structure for table `4_salesman`
--

CREATE TABLE IF NOT EXISTS `4_salesman` (
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
-- Dumping data for table `4_salesman`
--

INSERT INTO `4_salesman` (`salesman_code`, `salesman_name`, `salesman_phone`, `salesman_fax`, `salesman_email`, `provision`, `break_pt`, `provision2`, `inactive`) VALUES
(1, 'Sales Person', '', '', '', 5, 1000, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_sales_orders`
--

CREATE TABLE IF NOT EXISTS `4_sales_orders` (
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

--
-- Dumping data for table `4_sales_orders`
--

INSERT INTO `4_sales_orders` (`order_no`, `trans_type`, `version`, `type`, `debtor_no`, `branch_code`, `reference`, `customer_ref`, `comments`, `ord_date`, `order_type`, `ship_via`, `delivery_address`, `contact_phone`, `contact_email`, `deliver_to`, `freight_cost`, `from_stk_loc`, `delivery_date`, `payment_terms`, `total`) VALUES
(1, 30, 1, 0, 5, 5, 'auto', '', 'Minimum 80 KM@ Rs 1550 + Additional  46 KM@15/KM', '2014-11-26', 1, 0, '', '', NULL, 'Ratheesh Kumar', 0, 'DEF', '2014-11-27', 0, 2284.8);

-- --------------------------------------------------------

--
-- Table structure for table `4_sales_order_details`
--

CREATE TABLE IF NOT EXISTS `4_sales_order_details` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `4_sales_order_details`
--

INSERT INTO `4_sales_order_details` (`id`, `order_no`, `trans_type`, `stk_code`, `description`, `qty_sent`, `unit_price`, `quantity`, `discount_percent`, `trip_voucher`) VALUES
(1, 1, 30, '101', 'Trip', 0, 2240, 1, 0, 7);

-- --------------------------------------------------------

--
-- Table structure for table `4_sales_pos`
--

CREATE TABLE IF NOT EXISTS `4_sales_pos` (
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
-- Dumping data for table `4_sales_pos`
--

INSERT INTO `4_sales_pos` (`id`, `pos_name`, `cash_sale`, `credit_sale`, `pos_location`, `pos_account`, `inactive`) VALUES
(1, 'Default', 1, 1, 'DEF', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_sales_types`
--

CREATE TABLE IF NOT EXISTS `4_sales_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sales_type` char(50) NOT NULL DEFAULT '',
  `tax_included` int(1) NOT NULL DEFAULT '0',
  `factor` double NOT NULL DEFAULT '1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sales_type` (`sales_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `4_sales_types`
--

INSERT INTO `4_sales_types` (`id`, `sales_type`, `tax_included`, `factor`, `inactive`) VALUES
(1, 'Retail', 1, 1, 0),
(2, 'Wholesale', 0, 0.7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_security_roles`
--

CREATE TABLE IF NOT EXISTS `4_security_roles` (
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
-- Dumping data for table `4_security_roles`
--

INSERT INTO `4_security_roles` (`id`, `role`, `description`, `sections`, `areas`, `inactive`) VALUES
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
-- Table structure for table `4_shippers`
--

CREATE TABLE IF NOT EXISTS `4_shippers` (
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
-- Dumping data for table `4_shippers`
--

INSERT INTO `4_shippers` (`shipper_id`, `shipper_name`, `phone`, `phone2`, `contact`, `address`, `inactive`) VALUES
(1, 'Default', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_sql_trail`
--

CREATE TABLE IF NOT EXISTS `4_sql_trail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sql` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `4_stock_category`
--

CREATE TABLE IF NOT EXISTS `4_stock_category` (
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
-- Dumping data for table `4_stock_category`
--

INSERT INTO `4_stock_category` (`category_id`, `description`, `dflt_tax_type`, `dflt_units`, `dflt_mb_flag`, `dflt_sales_act`, `dflt_cogs_act`, `dflt_inventory_act`, `dflt_adjustment_act`, `dflt_assembly_act`, `dflt_dim1`, `dflt_dim2`, `inactive`, `dflt_no_sale`) VALUES
(1, 'Services', 1, 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_stock_master`
--

CREATE TABLE IF NOT EXISTS `4_stock_master` (
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

--
-- Dumping data for table `4_stock_master`
--

INSERT INTO `4_stock_master` (`stock_id`, `category_id`, `tax_type_id`, `description`, `long_description`, `units`, `mb_flag`, `sales_account`, `cogs_account`, `inventory_account`, `adjustment_account`, `assembly_account`, `dimension_id`, `dimension2_id`, `actual_cost`, `last_cost`, `material_cost`, `labour_cost`, `overhead_cost`, `inactive`, `no_sale`, `editable`) VALUES
('101', 1, 1, 'Trip', '', 'km', 'D', '4010', '5010', '1510', '5040', '1530', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_stock_moves`
--

CREATE TABLE IF NOT EXISTS `4_stock_moves` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_stock_moves`
--

INSERT INTO `4_stock_moves` (`trans_id`, `trans_no`, `stock_id`, `type`, `loc_code`, `tran_date`, `person_id`, `price`, `reference`, `qty`, `discount_percent`, `standard_cost`, `visible`) VALUES
(1, 1, '101', 13, 'DEF', '2014-11-26', 0, 2240, '14', -1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `4_suppliers`
--

CREATE TABLE IF NOT EXISTS `4_suppliers` (
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
  `notes` tinytext NOT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`supplier_id`),
  KEY `supp_ref` (`supp_ref`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `4_suppliers`
--

INSERT INTO `4_suppliers` (`supplier_id`, `supp_name`, `supp_ref`, `address`, `supp_address`, `gst_no`, `contact`, `supp_account_no`, `website`, `bank_account`, `curr_code`, `payment_terms`, `tax_included`, `dimension_id`, `dimension2_id`, `tax_group_id`, `credit_limit`, `purchase_account`, `payable_account`, `payment_discount_account`, `notes`, `inactive`) VALUES
(1, 'Siby', 'DR55', 'asfasfsafasfsfasf\nsfasfa\nsfasfasfasfs', 'asfasfsafasfsfasf\nsfasfa\nsfasfasfasfs', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(2, 'Samson', 'DR57', 'ddasdsadasdasd', 'ddasdsadasdasd', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(3, 'Jim', 'DR58', 'dadasda\nKollam', 'dadasda\nKollam', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(4, 'Sajid', 'VW6', '', '', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(5, 'Hanish', 'DR59', 'a', 'a', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0),
(6, 'Rajeev', 'DR60', 'c', 'c', '', '', '', '', '', 'INR', 4, 0, 0, 0, 1, 1000, '', '2100', '5060', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_supp_allocations`
--

CREATE TABLE IF NOT EXISTS `4_supp_allocations` (
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
-- Table structure for table `4_supp_invoice_items`
--

CREATE TABLE IF NOT EXISTS `4_supp_invoice_items` (
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
-- Table structure for table `4_supp_trans`
--

CREATE TABLE IF NOT EXISTS `4_supp_trans` (
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
-- Table structure for table `4_sys_prefs`
--

CREATE TABLE IF NOT EXISTS `4_sys_prefs` (
  `name` varchar(35) NOT NULL DEFAULT '',
  `category` varchar(30) DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `length` smallint(6) DEFAULT NULL,
  `value` tinytext,
  PRIMARY KEY (`name`),
  KEY `category` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_sys_prefs`
--

INSERT INTO `4_sys_prefs` (`name`, `category`, `type`, `length`, `value`) VALUES
('coy_name', 'setup.company', 'varchar', 60, 'Galaxy Travel Club'),
('gst_no', 'setup.company', 'varchar', 25, ''),
('coy_no', 'setup.company', 'varchar', 25, ''),
('tax_prd', 'setup.company', 'int', 11, '1'),
('tax_last', 'setup.company', 'int', 11, '1'),
('postal_address', 'setup.company', 'tinytext', 0, 'Rasheed Towers, M.G Road, Pallimukku, Cochin 16'),
('phone', 'setup.company', 'varchar', 30, '9633211011'),
('fax', 'setup.company', 'varchar', 30, ''),
('email', 'setup.company', 'varchar', 100, 'anwar@galaxytravelclub.com'),
('coy_logo', 'setup.company', 'varchar', 100, ''),
('domicile', 'setup.company', 'varchar', 55, ''),
('curr_default', 'setup.company', 'char', 3, 'INR'),
('use_dimension', 'setup.company', 'tinyint', 1, '1'),
('f_year', 'setup.company', 'int', 11, '7'),
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
('creditors_act', 'glsetup.purchase', 'varchar', 15, '2100'),
('po_over_receive', 'glsetup.purchase', 'int', 11, '10'),
('po_over_charge', 'glsetup.purchase', 'int', 11, '10'),
('allow_negative_stock', 'glsetup.inventory', 'tinyint', 1, '0'),
('default_inventory_act', 'glsetup.items', 'varchar', 15, '1510'),
('default_cogs_act', 'glsetup.items', 'varchar', 15, '5010'),
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
-- Table structure for table `4_sys_types`
--

CREATE TABLE IF NOT EXISTS `4_sys_types` (
  `type_id` smallint(6) NOT NULL DEFAULT '0',
  `type_no` int(11) NOT NULL DEFAULT '1',
  `next_reference` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_sys_types`
--

INSERT INTO `4_sys_types` (`type_id`, `type_no`, `next_reference`) VALUES
(0, 17, '1'),
(1, 7, '1'),
(2, 4, '1'),
(4, 3, '1'),
(10, 16, '2'),
(11, 2, '1'),
(12, 6, '2'),
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
-- Table structure for table `4_tags`
--

CREATE TABLE IF NOT EXISTS `4_tags` (
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
-- Table structure for table `4_tag_associations`
--

CREATE TABLE IF NOT EXISTS `4_tag_associations` (
  `record_id` varchar(15) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `record_id` (`record_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `4_tax_groups`
--

CREATE TABLE IF NOT EXISTS `4_tax_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `tax_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `4_tax_groups`
--

INSERT INTO `4_tax_groups` (`id`, `name`, `tax_shipping`, `inactive`) VALUES
(1, 'Tax', 0, 0),
(2, 'Tax Exempt', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_tax_group_items`
--

CREATE TABLE IF NOT EXISTS `4_tax_group_items` (
  `tax_group_id` int(11) NOT NULL DEFAULT '0',
  `tax_type_id` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`tax_group_id`,`tax_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `4_tax_group_items`
--

INSERT INTO `4_tax_group_items` (`tax_group_id`, `tax_type_id`, `rate`) VALUES
(1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `4_tax_types`
--

CREATE TABLE IF NOT EXISTS `4_tax_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` double NOT NULL DEFAULT '0',
  `sales_gl_code` varchar(15) NOT NULL DEFAULT '',
  `purchasing_gl_code` varchar(15) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `4_tax_types`
--

INSERT INTO `4_tax_types` (`id`, `rate`, `sales_gl_code`, `purchasing_gl_code`, `name`, `inactive`) VALUES
(1, 5, '2150', '2150', 'Tax', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_trans_tax_details`
--

CREATE TABLE IF NOT EXISTS `4_trans_tax_details` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `4_trans_tax_details`
--

INSERT INTO `4_trans_tax_details` (`id`, `trans_type`, `trans_no`, `tran_date`, `tax_type_id`, `rate`, `ex_rate`, `included_in_price`, `net_amount`, `amount`, `memo`) VALUES
(1, 13, 1, '2014-11-26', 1, 5, 1, 0, 896, 44.8, '14'),
(2, 10, 1, '2014-11-26', 1, 5, 1, 1, 853.33, 42.67, '1');

-- --------------------------------------------------------

--
-- Table structure for table `4_useronline`
--

CREATE TABLE IF NOT EXISTS `4_useronline` (
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
-- Table structure for table `4_users`
--

CREATE TABLE IF NOT EXISTS `4_users` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `4_users`
--

INSERT INTO `4_users` (`id`, `user_id`, `password`, `real_name`, `role_id`, `phone`, `email`, `language`, `date_format`, `date_sep`, `tho_sep`, `dec_sep`, `theme`, `page_size`, `prices_dec`, `qty_dec`, `rates_dec`, `percent_dec`, `show_gl`, `show_codes`, `show_hints`, `last_visit_date`, `query_size`, `graphic_links`, `pos`, `print_profile`, `rep_popup`, `sticky_doc_date`, `startup_tab`, `inactive`) VALUES
(1, 'demo123', '62cc2d8b4bf2d8728120d052163a77df', 'Administrator', 2, '', 'adm@adm.com', 'C', 0, 0, 0, 0, 'cnc', 'Letter', 2, 2, 4, 2, 1, 0, 0, '2014-11-26 10:57:22', 25, 1, 1, '', 1, 0, 'orders', 0),
(2, 'demouser', '62cc2d8b4bf2d8728120d052163a77df', 'User demo', 10, '1234567890', 'userdemo@galaxy.com', 'C', 0, 0, 0, 0, 'default', 'Letter', 2, 2, 4, 1, 1, 0, 0, '2014-12-03 05:43:19', 10, 1, 1, '', 1, 0, 'orders', 0);

-- --------------------------------------------------------

--
-- Table structure for table `4_voided`
--

CREATE TABLE IF NOT EXISTS `4_voided` (
  `type` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `date_` date NOT NULL DEFAULT '0000-00-00',
  `memo_` tinytext NOT NULL,
  UNIQUE KEY `id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `4_workcentres`
--

CREATE TABLE IF NOT EXISTS `4_workcentres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `description` char(50) NOT NULL DEFAULT '',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `4_workorders`
--

CREATE TABLE IF NOT EXISTS `4_workorders` (
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
-- Table structure for table `4_wo_issues`
--

CREATE TABLE IF NOT EXISTS `4_wo_issues` (
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
-- Table structure for table `4_wo_issue_items`
--

CREATE TABLE IF NOT EXISTS `4_wo_issue_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(40) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `qty_issued` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `4_wo_manufacture`
--

CREATE TABLE IF NOT EXISTS `4_wo_manufacture` (
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
-- Table structure for table `4_wo_requirements`
--

CREATE TABLE IF NOT EXISTS `4_wo_requirements` (
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
-- Table structure for table `app_request_log`
--

CREATE TABLE IF NOT EXISTS `app_request_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_address` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `app_request_log`
--

INSERT INTO `app_request_log` (`id`, `ip_address`, `created`) VALUES
(1, '122.174.223.55', '2014-10-24 06:22:00'),
(2, '122.174.223.55', '2014-10-24 06:22:35'),
(3, '122.174.223.51', '2014-10-24 06:22:45'),
(4, '122.174.223.56', '2014-10-24 06:22:58'),
(5, '122.174.223.55', '2014-10-24 06:23:08'),
(6, '122.174.223.55', '2014-10-24 09:29:43'),
(7, '122.174.223.55', '2014-10-24 09:31:47'),
(8, '122.174.223.55', '2014-10-24 09:41:22'),
(9, '122.174.223.55', '2014-10-24 09:45:29'),
(10, '122.174.223.55', '2014-10-24 09:46:00'),
(11, '122.174.219.34', '2014-11-03 05:14:15'),
(12, '122.174.219.34', '2014-11-03 05:32:18'),
(13, '122.174.219.34', '2014-11-03 05:34:31'),
(14, '122.174.201.48', '2014-11-03 07:02:44'),
(15, '122.174.201.48', '2014-11-03 12:42:21'),
(16, '122.174.227.183', '2014-11-19 18:24:38'),
(17, '123.237.135.212', '2014-11-19 18:46:38'),
(18, '122.174.218.6', '2014-11-19 18:56:27');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `bank_account_types`
--

INSERT INTO `bank_account_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Current', 'Current', NULL, 4, 5, '2014-09-09 06:32:49', '0000-00-00 00:00:00'),
(2, 'Savings', 'Savings', NULL, 4, 5, '2014-09-09 06:33:07', '0000-00-00 00:00:00'),
(3, 'NRI', 'NRI', NULL, 4, 5, '2014-09-09 06:33:16', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `booking_sources`
--

INSERT INTO `booking_sources` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Call Centre', 'Call Centre', NULL, 4, 5, '2014-09-09 06:39:01', '0000-00-00 00:00:00'),
(2, 'Walk in', 'Walk in', NULL, 4, 5, '2014-09-09 06:39:19', '0000-00-00 00:00:00'),
(3, 'Email', 'Email', NULL, 4, 5, '2014-09-09 06:39:35', '0000-00-00 00:00:00'),
(4, 'Credit', 'Credit', NULL, 4, 5, '2014-09-09 06:39:47', '2014-10-15 07:36:57'),
(5, 'Mobile App', 'Mobile App', NULL, 4, 6, '2014-10-23 05:13:53', '0000-00-00 00:00:00');

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

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('002d7d284929e52669eccc9e8e2b125d', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417062070, ''),
('0061e00dadbadbc122ed5d5d364c8c44', '122.174.201.38', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1414730676, ''),
('006759d0101ce8ebf7f1522d3793ee96', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416814351, ''),
('00d14ea39cf97075e322fae3e632745d', '122.174.225.172', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko', 1416821061, ''),
('0100cfdee8c61e21751b39f0215be783', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414150091, ''),
('028ec305671f3a4c4564b26399075599', '123.237.128.26', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415188099, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"1";}'),
('037e87e8a6c3c8457e0533740b987c9f', '122.174.218.70', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415853775, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('05eb668b18e7c749e4c6d042f14b222b', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416309987, ''),
('07c29260542b053abbf21c4307ab339c', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416309991, ''),
('0a61576a96098d3b8defbb1a20adf305', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414150092, ''),
('0aa1e526d3e5a2cefa9ea968c7c4ed05', '122.174.206.147', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1416918124, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('0d730cd912fa2b533671336e24ad7d23', '122.174.214.196', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1413628630, ''),
('0f3a44e6efb77589d870a0e608a0547d', '122.174.211.51', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417493206, 'a:20:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:17:"select_trip_model";s:0:"";s:20:"select_vehicle_makes";s:0:"";s:14:"select_ac_type";s:0:"";s:19:"select_vehicle_type";s:0:"";s:4:"post";s:0:"";s:11:"customer_id";s:1:"8";s:13:"customer_name";s:10:"Saju Kumar";s:14:"customer_email";s:21:"saju@connectncabs.com";s:15:"customer_mobile";s:10:"9846189669";s:9:"driver_id";s:1:"0";}'),
('0f6370147357f304037dd432b73b2fea', '122.174.228.31', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1414569995, ''),
('0fd83ae6fb130d3ad551ba2df5785281', '122.174.203.126', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414050251, 'a:11:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:9:"condition";s:0:"";}'),
('10525e37f307fb206a19cfc992813c4c', '122.174.206.239', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417001484, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:1;s:17:"loginAttemptcount";i:3;s:12:"captcha_code";s:6:"wnd4xv";s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('10726c1749a830c43124789c0d14d86e', '122.174.213.66', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1414383929, 'a:11:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";}'),
('111b5ff7c88d332ab3705388b9f0d556', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1414129312, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('130c764c07be4724e8c088160bcb3eac', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040108, ''),
('13381fb0f8f623bce752282d955052b7', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416385321, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('134bdd124f7aa569f649a5212cb82c41', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('13fa206c6f197eeb0c48a52e28c61f86', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040062, ''),
('144a76b416151dcdb1280b9f0bdb7e44', '122.174.208.182', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415076356, ''),
('1552ee66065b591056a499eafba697de', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416814351, ''),
('15a3cbf8b1b75c5d72eada9a5ccf0f9c', '122.174.214.187', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416974342, ''),
('15df10339b0ec22e512df7177ab97744', '122.174.218.6', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1416382284, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('17fea05a67f10fabc72bb2f4c5239db8', '122.174.213.66', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414402522, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('1a2c1ec71e224c68c96bf4175129330d', '122.174.213.210', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1413879142, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"2";}'),
('1a48a69930953d271c82dcbde08a46c1', '122.174.201.63', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1413535363, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"9";s:4:"name";s:9:"Raj Kumar";s:5:"email";s:21:"mail@connectncabs.com";s:8:"username";s:8:"rajkumar";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('1a9a26e51038eb3b0fe4bb91b59b678a', '122.174.225.33', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417410341, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('1ac0433526e686488de67c74bdf6b291', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416912750, ''),
('1bb71a3d205f70a642a15421827b7c31', '122.174.192.170', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415710785, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('1d08895ecbce3eff1f4517019d9f4f74', '122.174.216.56', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416561545, ''),
('1f6dcf19637311848d2e6c77be65f3d3', '122.174.203.126', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049492, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";s:9:"driver_id";s:1:"0";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('212963f0cdc656727f91615c786f51bc', '122.174.220.32', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1413541138, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"4";s:13:"customer_name";s:11:"Nijo Joseph";s:14:"customer_email";s:23:"nijojoseph225@gmail.com";s:15:"customer_mobile";s:10:"9020964268";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:8:"Err_m_dt";s:25:"Invalid Date for Tariff !";}'),
('21c96660e10347bcda2cf6e3472580a9', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049200, ''),
('21cf00dce3551470faef11ad798fe3b0', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416891209, ''),
('21cf6e2c226b935b7281b1d4d21d9c51', '122.174.219.34', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:31.0) Gec', 1414992567, 'a:11:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:9:"dbSuccess";s:0:"";}'),
('245d70f3c2906b6d7198715659ebbc12', '122.174.192.170', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415696176, 'a:14:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:2:"56";s:13:"customer_name";s:4:"nijo";s:14:"customer_email";s:13:"nijo@acube.co";s:15:"customer_mobile";s:10:"9020964268";}'),
('24631d05c403b3f641515d3b38d0b4d2', '122.174.215.141', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1417071859, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('24a03d5c220320df4f839c58ac916be3', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('25c5d80fb0a506a2802803e6df3cdf0c', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('25d22cbd4ad43fdaecd4865b89f4e633', '122.174.194.20', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414643343, 'a:11:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";}'),
('261a7c76fb704fef526912858756571b', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('267c99b7ea77405535f7009d2006cccb', '123.237.135.212', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416989855, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('26d0b58f1b99f7ffd404bcb77a8c833f', '122.174.214.187', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416974341, ''),
('27a9a19d3096e60359f1ebdce0a2793b', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416892695, ''),
('2859c626ee21e9a43f6723c4e1cdc837', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414038802, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('28b0aecfcf34416a480305321940796b', '122.174.216.56', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416561544, ''),
('297c0734411b7156e1bd681dcef659f2', '117.245.191.106', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413605989, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('2a34831c3b9b9982a44432eb4677d915', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416915065, ''),
('2a821756183dbd61cb684f85943eb0d2', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416892685, ''),
('2b859ce04df8ece2f30851de79a064ce', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049198, ''),
('2bb2174ac5ef36d8a8a9ada64a14d50b', '123.237.135.212', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416289941, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"1";}'),
('2dba0f4967e09586ed63a5264437620f', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('2e47c3a42fb635d0d09e1c5c2508d450', '122.174.220.32', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413540178, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('2f97da113843d825b982c947347b847c', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('302e1226eb80e8920f877363595fe4e5', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416373360, ''),
('306a72041359b183c28d44943d1cc40d', '122.174.228.99', 'Mozilla/5.0 (Windows NT 5.1; rv:32.0) Gecko/201001', 1413792705, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"11";s:4:"name";s:15:"Valsa Sajukumar";s:5:"email";s:22:"mail2@connectncabs.com";s:8:"username";s:5:"valsa";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('313307f4f3fe77d7b35f13ffd1bc3d8a', '122.174.212.252', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417151322, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('316c4246fb1fe0b68a69cdbbf3e02afd', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1416920121, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('31a575a781847539037e03f6e65370f3', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('31ee39a5d142eaaba6c0595c0c867342', '122.174.226.98', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1414040549, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"9";s:4:"name";s:9:"Raj Kumar";s:5:"email";s:21:"mail@connectncabs.com";s:8:"username";s:8:"rajkumar";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('350520eee93a83276511dabf0dab0894', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416890653, ''),
('379c87bba02c3851a52c49f16a79898a', '122.174.213.66', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414391359, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('3b7d2d0c63cce3545caedcd0719574a8', '122.174.214.187', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416980035, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('3c868a3c29b8a3772fd064151da97798', '122.174.198.254', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414398275, 'a:12:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('3d10bf3914a93cb76be43137bf84891d', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416813706, ''),
('4034950fcae79df8b5ce57dc1176ae14', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('45287c13109f2b801ee5ef0d67ea20a4', '122.174.218.70', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415854899, ''),
('47b2d685597a7cd412551d2d248e5636', '122.174.220.32', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413537846, 'a:14:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:26:"ratheeshvijayan@gmail.com ";s:15:"customer_mobile";s:10:"9946109570";}'),
('48721821728dc9428823728a3397ea82', '123.237.135.212', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1417410435, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('4b16466589590e52763f0f8f35a1817b', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382711, ''),
('4b1ff8592b753874363a3be75aeadf8f', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416890656, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('4cf38cc993408d6a06c182899312c5d0', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049198, ''),
('4de25fc694d53fdc328b77318cc471d0', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049200, ''),
('4ea88cae35b2b9681cf25b9928fbcd59', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('4f123a83591a88d9e863e8021c1a1256', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413865586, 'a:20:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"dbSuccess";s:0:"";s:9:"condition";s:0:"";s:8:"Err_m_dt";s:25:"Invalid Date for Tariff !";s:9:"Err_m_vid";s:25:"Vehicle Model Required..!";s:7:"dbError";s:0:"";s:6:"Err_dt";s:0:"";s:4:"post";s:0:"";s:8:"Err_date";s:13:"Invalid Date!";s:8:"Date_err";s:18:"Not a valid search";s:11:"Err_add_hrs";s:34:"Invalid Characters on Hours field!";}'),
('509c15329af436bd30db545000ad6203', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416892686, ''),
('5150b9207102393607899289e4f0d17b', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('53a987ab3c22743ac55ce5237f37d583', '122.174.229.85', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1417419795, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('53f1adcebf5cd42d4f2a530a31b9104f', '123.237.128.26', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415340313, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('54bfe0780c554c04aedaed2d88649c05', '122.174.228.31', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414580259, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"0";s:9:"condition";s:0:"";}'),
('54d5ac0a65e24ef654b621aed0c9e9b3', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('5513e1d077e0a530edc5b3371b4440bd', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416388714, ''),
('55ade2d3063239cb3630b4af35fb045c', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416897504, ''),
('564455277a6ce732bc84254020b224c8', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('5677f70aee202299711d9b58759e630b', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416891205, ''),
('56dd521c06e6158447c713015a2aca0a', '123.237.135.212', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416633634, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('574a2113fde52a4a0ee3be4a60bfbf44', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416897504, ''),
('5aea01dad598809e5eb1aaa81a068dfa', '122.174.218.128', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414037375, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"0";s:9:"condition";s:0:"";}'),
('5ccacde7ab9813be3bda25ab07edcffd', '122.174.209.244', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415949386, ''),
('5cf7fd700fd5a038cd3663f1f460b8e4', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416380599, ''),
('5ddf56c344c2ca1992809dd55f2bc8a7', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('626149776191c2e72a22b3fd3a0a1ca2', '122.174.228.99', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413793882, ''),
('63cef32535f76d46fbb87c4ab29da8b2', '122.174.233.145', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/53', 1417002333, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('65148f539e1ef516d2b84d95b1c4fb4b', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('660bec983bb6fcde0956341279a2535f', '122.174.228.31', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1414580263, ''),
('66e59d1ea6ead8b93683d5640c5bbbff', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('674d224844069353c4c971b0a636e598', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416912748, ''),
('6841745e1b9adfa56e244a7083265f69', '122.174.206.239', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1416985790, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('6a5f487e02f23baee17b5572ca4611c4', '122.174.213.66', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1414399414, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('6af550800aeb8390edd995ee9378f9c3', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048970, ''),
('6c0fbf6c68fc0bb1a37925e3ede44d70', '117.233.230.177', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1415190490, 'a:14:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";}'),
('6c23ee8b76ed1c98ed23941ced0c2790', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382280, ''),
('6c5418ba70c6a45ba5ae5f7e5bc0e3cb', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414128888, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:20:"bank_account_type_id";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";}'),
('6d161631e3390859731ee6e97bdeff68', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('6d2c70c0d37a84e4f7932deee030efd7', '122.174.212.252', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (', 1417167265, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"3";s:4:"name";s:13:"connectn cabs";s:5:"email";s:29:"connectncabs@connectncabs.com";s:8:"username";s:12:"connectncabs";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"2";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"7e4da08906338586b3756c3fa0f5bb89";}'),
('6d7deaec7e7b8328a0b10403f3197b4d', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416897508, ''),
('6ea091c8e166c2559be9a6b9154520ca', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416890658, ''),
('70330cd95dae54681793f0523d316a8d', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('71167b119a01cc3b4f450f267fa8127d', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417587259, ''),
('71676bc4a5083b070f63138368b7e960', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382712, ''),
('71f030c527b98c41f655649ac9125005', '122.174.201.38', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1414730676, ''),
('72bacf43f16fa919e321e09ba469d756', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1414129451, 'a:12:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";s:8:"Date_err";s:18:"Not a valid search";}'),
('73047b7aa919ea1773df65204a39b123', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('7470c4b6eaf71804a3ca538fcc387570', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416917774, ''),
('74e44cdc1b5dcea21e4e0a725046993e', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040385, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('754ee16c462b0845518a98a59138793c', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('759396990dfb0bc8d5b6fcb69ef1c5f8', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('76ff83943aa7b38d80aaba1de62de158', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416814355, ''),
('7ac30d78107ec0f6eb0260a10db42952', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416823194, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('7ad692ed4973a75a83d3699cc9a324b0', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416912749, ''),
('7b4b30e86f0cac9e66a83e3cf1cb4e83', '180.215.85.145', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414086503, 'a:12:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:20:"bank_account_type_id";s:0:"";s:16:"id_proof_type_id";s:0:"";}'),
('7d8e57e4b70b754074be5c9d25449dd8', '122.174.225.33', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1417410895, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('7da82eb5f1058520484e54b89e766662', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886657, ''),
('7e08a2bd471d57eb067da28c9966d88d', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417062069, ''),
('7f1e7d2e4493eb80f7bac7ab9b610c3e', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('7f6b2e84ab8a0461bb80f61402c8308b', '123.237.135.212', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1416980820, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:11:"customer_id";s:2:"12";s:13:"customer_name";s:4:"Nijo";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:10:"9020964268";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:2:"-1";}'),
('7f8e7f5e75d53bd48b0b014d42b0a6f8', '122.174.201.38', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1414740918, 'a:13:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('80d26bc4d6d96e3b7d99e102f29be705', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886653, ''),
('816fb29ef2239f9d2208f043ccde9774', '122.174.217.175', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1416822570, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('82f7c4057f7ad7c28c9bb0ee61622a9d', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040129, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('84020b5aea4bfdddb1d568cc71e2ec99', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040065, ''),
('8435a5c47a14c9a014672b3b9d196464', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416380599, ''),
('8481794bd9cf8784d98c76a722f0b025', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('84e4d2541f633b3f99902de59dd27698', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049198, ''),
('8669ff194fe184eb6eaf63b6d15eca26', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886657, ''),
('878444c7b13f2706844088a5e97f1a8f', '122.174.209.244', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415965705, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('87ba3c00d39cd8b323c5f2387555d505', '122.174.197.15', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415260403, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('891042377dae8171c1a3af0343a5891a', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049198, ''),
('8a8e31aab116c1665582081affc8b17a', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049199, ''),
('8b66120c263953994fe665332574eaa7', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416380600, ''),
('8c56d2a4675e528d670b56bda587e6ae', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416309986, ''),
('8d17d6ec0bb00a26d645b07286fb54f2', '122.174.201.38', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1414730677, ''),
('8e302fcbe0f68dd620864bef11b551c4', '122.174.197.137', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1415596279, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('8f69c0e5ad6dfbd5e7874bfce30ae771', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414128439, ''),
('90173fabbce5411a1b27c3032e5365c2', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414128439, ''),
('91375fe6879ebdf2c4394ea64fd211c6', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382716, ''),
('948d67765d351eb2ff1331e03e40a37c', '122.174.192.170', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1415693333, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:2:"10";}'),
('976f8f97409e952b9180da81714766a0', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886652, ''),
('9797ec4b7d9d579011b55107d1243488', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('98a37ca2cfbcbf22164a8a81ad425f85', '163.47.13.97', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416437587, ''),
('99222713d02c6d7b888267f9ff060852', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416309988, ''),
('9a4a9c872f320dc3ad48da9e03bb95a4', '122.174.194.20', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1414643235, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('9bb2b09cfc4e897cf452b9f61796a6c3', '122.174.192.170', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1415682094, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('9c23b0423b0e49c54ec6352b11393431', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('9f752b114c580c60e6592df50b0788cc', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382278, ''),
('9f9ec00ab63278289744dd30243bcae4', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (K', 1416911940, ''),
('9fb42ae8a33685df9cde36c81b64b6fa', '122.174.217.175', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416814350, ''),
('9fc03e4cd48a36916a1bd10a419228fb', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416915065, ''),
('a17ec937fd94b122d0193955c94b89c1', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040065, ''),
('a3ad4050141a70fa59e94eadfff58014', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('a5fab98cd82921904d14ae1addd45b5a', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416288436, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('a6be79d1ecfdc7a649d1dedec67c361a', '122.174.232.59', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1413953233, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"4";s:13:"customer_name";s:11:"Nijo Joseph";s:14:"customer_email";s:23:"nijojoseph225@gmail.com";s:15:"customer_mobile";s:10:"9020964268";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"1";}'),
('a72549543b496a292e654fff8ebcdd95', '122.174.194.20', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414643480, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:9:"condition";s:0:"";s:11:"customer_id";s:2:"44";s:13:"customer_name";s:3:"www";s:14:"customer_email";s:24:"ajithprakashan@gmail.com";s:15:"customer_mobile";s:10:"9539372063";s:9:"driver_id";s:1:"0";}'),
('a75ae0f990476a03e7185f4890a0cf8a', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040069, ''),
('a84701583d763ee242c0256400fa35b1', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040070, ''),
('a8487f068c350f266740b9429f2f9909', '122.174.228.31', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (K', 1414580271, ''),
('a8d381c46f1d0fa8c5dec9b5c112d46f', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417588816, ''),
('a8fcbf17b770e9eb3c9d1597766fd8a9', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('aac71579153cf62f62dabad16f879c6a', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414128438, ''),
('ac72040fb28d256fe0b88375fabde829', '122.174.216.56', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416561543, ''),
('ace9a33704bb8d177390b55ab65848fe', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382712, ''),
('ad1ed73bb9b654aa1e9277c15f7f0db4', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1417079684, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('aea2660abe42a60010356e00f39e6c73', '122.174.214.196', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413605978, 'a:25:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";s:8:"Required";s:0:"";s:17:"select_trip_model";s:0:"";s:20:"select_vehicle_makes";s:0:"";s:14:"select_ac_type";s:0:"";s:19:"select_vehicle_type";s:0:"";s:4:"post";s:0:"";s:7:"Err_hrs";s:0:"";s:8:"Err_kilo";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:12:"m_trip_model";s:17:"Choose Trip Model";s:8:"Err_m_dt";s:25:"Invalid Date for Tariff !";s:9:"Err_m_vid";s:25:"Vehicle Model Required..!";s:12:"Err_m_tarrif";s:26:"Tariff Master  Required..!";}'),
('aea6e31dc88b877bda82af91a33ec33e', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416912754, ''),
('aeeb0e0878600b535519fa9fb10360a5', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416292506, ''),
('afcb9db4f56395bb10b53f0eb9fcabb1', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416891205, ''),
('b0cc14a8f38a7264487ddda9e6f0e051', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417587259, ''),
('b10c2b404434b1291249b106facd13c6', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040069, ''),
('b122cadeab6ba087da0fb7a6beed727d', '122.174.223.55', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1414150635, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('b3085271dc4c1fdb446b404ec19ea178', '122.174.201.48', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415000675, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:1:"4";}');
INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('b5331ef22459049778337e7ac7cb0a09', '122.174.211.51', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417496966, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";}'),
('b57646967f6fea810399eca8d7f5e5c8', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049200, ''),
('b5f6fae2440bba3461ef8c771ba88e4b', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416373361, ''),
('b6bf80a2042fd8564074dcc5e1979825', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416373362, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('b8a29c420120096445a29cfa46197dbe', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048970, ''),
('b9df10c32ea0c45e5f02d15b00a10ad5', '122.174.217.175', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1416812846, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"driver_id";s:2:"-1";}'),
('bb0f7a03dba705805f999dc10b76c5a9', '122.174.250.170', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416898474, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('bddcf5f36739dbed1da527a21c2bdf99', '122.174.237.97', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413795185, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('bf07ed166332b0b8c18d7c380005e6ba', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382283, ''),
('bface55fbc24fa6da3eef7795788ba72', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886653, ''),
('c011ed52a5f9658898f955ab81b5d077', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('c102d4d8fc6bac48e4b450052f4ee876', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416380604, ''),
('c1920029854cc54dc574e2cc665dab16', '122.174.216.56', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416554782, 'a:15:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:11:"customer_id";s:1:"4";s:13:"customer_name";s:7:"Renjith";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:10:"9946999356";s:9:"driver_id";s:2:"42";}'),
('c212a95a7aba50504b4e4d32a1596f3a', '122.174.206.147', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416915064, ''),
('c29a7ca5de25e3bd69c00a27babdcdd5', '122.174.206.239', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1416987602, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('c33358710e280eaa3207be0a146251fb', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416382279, ''),
('c50f01fb25bdbee01877c89a8dd87f51', '122.174.212.252', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1417172239, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('c7d2021b3047a3e638e735fac486b469', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417062069, ''),
('c8aafd86fae043809876a64a275fb3db', '122.174.213.66', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414388018, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('c8ac879519d4593da93e51473bbc2650', '122.174.225.150', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416201895, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('c943bda2154f0efcd6a3cfe2117e72cf', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416890654, ''),
('cb09c82e6f1d28bbf28eb82bb675c5f9', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413875033, 'a:21:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:9:"dbSuccess";s:0:"";s:11:"customer_id";s:0:"";s:13:"customer_name";s:0:"";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:0:"";s:9:"condition";s:0:"";s:7:"dbError";s:0:"";s:19:"select_vehicle_type";s:0:"";s:4:"post";s:0:"";s:6:"Err_dt";s:0:"";s:8:"Err_date";s:13:"Invalid Date!";}'),
('cc10a2d01d50b32242e88aace934ed24', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417086343, ''),
('cc65e128b3c556b03d47c278fd3e0736', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417587430, ''),
('ccbdde4e124d2e02dae334907330f8f8', '122.174.237.23', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049200, ''),
('ce38a06175ee5f915cc00df6dd50154b', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('d02459622f8efa6b4a805b6ad823250a', '122.174.212.252', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (K', 1417156768, ''),
('d0b5d57d0d77db13638756f45493c8c9', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416897503, ''),
('d141c56625e565070e6a8333a978948d', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('d15345b327c0e404f87851e9a625a2e6', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('d369d32df675b1b1b4935e8e1a7b802c', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('d444bca629354546ea281bc0c455819d', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417587352, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('d5d75b9feb141cebacd1779dd1250820', '122.174.192.170', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1415692933, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('d5e370cd48d05011612cdd7d31b106a2', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416373364, ''),
('d63b65fa1e76645626265ffb869640b6', '122.174.229.85', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417419590, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('d652b6179bfb77a91ae92f960a25bcb8', '122.174.201.48', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1415001939, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"3";s:4:"name";s:13:"connectn cabs";s:5:"email";s:29:"connectncabs@connectncabs.com";s:8:"username";s:12:"connectncabs";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"2";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"7e4da08906338586b3756c3fa0f5bb89";}'),
('d7597c4cc90dad12fbb844fe618d9e7e', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414150093, ''),
('d7b3f8e74adf4a68d7bede327b512624', '122.174.234.68', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/201001', 1416832263, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('d89440ab82edd548cb8f0d8e94ac7f56', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416892685, ''),
('da5c1bbd544deb8f4a1c669187d63adb', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048971, ''),
('db20fdf9ce7c2c620107bea7c849b353', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049331, ''),
('dbf4696d0acbbca764f350027e07f3b6', '122.174.206.239', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1416987602, ''),
('df1fb42bb71ac70de8d27b27b2a89a52', '122.174.206.239', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416985974, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('df619b45840471bef6496f1ed8dbe0a3', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040113, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('df6e61a9278117fde2a4d78d1b83314e', '122.174.220.32', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413553529, ''),
('e12f2816911e87425f5b5f462c9fad60', '122.174.225.33', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417411876, ''),
('e1b100803db1665398c746deec94b430', '123.237.134.144', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:31.0) Gec', 1414585922, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:2:"44";s:13:"customer_name";s:5:"Ajith";s:14:"customer_email";s:24:"ajithprakashan@gmail.com";s:15:"customer_mobile";s:10:"9539372064";s:9:"driver_id";s:1:"0";s:9:"dbSuccess";s:0:"";}'),
('e1f5f6143dd978fa0c94a883d13dd371', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416891205, ''),
('e2c0e512fe00bd4c935e0b389b1e5028', '122.174.215.141', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1417064093, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:16:"Ratheesh Vijayan";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:10:"9946109570";}'),
('e3f08bd559fe50204efb715d03c3b2fa', '122.174.203.126', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049492, ''),
('e5067fbf3dcce3455a51da5b32763e83', '122.174.222.83', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (K', 1416302493, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";}'),
('e979d03f286ce5c64cbd364df4a27262', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040618, 'a:18:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";s:11:"customer_id";s:1:"4";s:13:"customer_name";s:11:"Nijo Joseph";s:14:"customer_email";s:23:"nijojoseph225@gmail.com";s:15:"customer_mobile";s:10:"9020964268";s:9:"driver_id";s:1:"4";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:9:"condition";s:0:"";}'),
('ec0eb420ea489f09c2d3bfbfb2998d51', '122.174.225.76', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414048972, ''),
('ed6657d074b0c215bb109d42501695d1', '122.174.206.239', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1416988382, 'a:17:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:11:"customer_id";s:2:"15";s:13:"customer_name";s:6:"Sarath";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:10:"4564564564";s:9:"driver_id";s:2:"57";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('ed7fbc699608c9d1a051bb7042788ab3', '122.174.230.38', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414049330, ''),
('eebd96e781f6e38bff69d090d8bd01cc', '122.174.214.187', 'Mozilla/5.0 (Windows NT 6.3; rv:33.0) Gecko/201001', 1416979677, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"14";s:4:"name";s:9:"User demo";s:5:"email";s:19:"userdemo@galaxy.com";s:8:"username";s:8:"demouser";s:15:"organisation_id";s:1:"4";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"62cc2d8b4bf2d8728120d052163a77df";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:11:"customer_id";s:2:"14";s:13:"customer_name";s:14:"Ratheesh Kumar";s:14:"customer_email";s:0:"";s:15:"customer_mobile";s:10:"9999999999";}'),
('eeebed6fc1bf8054a175e6cded38c632', '122.174.228.99', 'Mozilla/5.0 (Windows NT 5.1; rv:32.0) Gecko/201001', 1413793462, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:2:"10";s:4:"name";s:10:"Saju Kumar";s:5:"email";s:22:"mail1@connectncabs.com";s:8:"username";s:9:"sajukumar";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('f038b1e68de95caf0ce0727326977913', '122.174.213.210', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1413886657, ''),
('f37b44822ab56adf3e59ce67a1f6d1c9', '122.174.240.69', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416555286, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('f3964f166d2fe3b02d0873090002a8d1', '122.174.213.66', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414403165, 'a:13:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('f3dfe837740e68f7d4884fbd06514e13', '122.174.214.187', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1416982423, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('f4314091826d796c5bd41f32585df296', '122.174.206.147', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:23.0) Gec', 1416915361, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('f8f3a53ebf5bedfe50397727a4b435d9', '122.174.221.240', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416890654, ''),
('f9305720570d39b66be436611256026b', '122.174.223.55', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414125796, 'a:27:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"5";s:4:"name";s:11:"Divya Manoj";s:5:"email";s:14:"divya@acube.co";s:8:"username";s:5:"divya";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"6a670fed44634a9e6967bc5cec37840b";s:11:"customer_id";s:1:"1";s:13:"customer_name";s:8:"Ratheesh";s:14:"customer_email";s:24:"ratheeshvijayan@live.com";s:15:"customer_mobile";s:10:"9946109570";s:9:"driver_id";s:1:"0";s:9:"condition";s:0:"";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";s:20:"select_vehicle_makes";s:0:"";s:14:"select_ac_type";s:0:"";s:4:"post";s:0:"";s:10:"Err_m_kilo";s:39:"Invalid Characters on Kilometers field!";s:12:"m_trip_model";s:17:"Choose Trip Model";s:9:"Err_m_vid";s:25:"Vehicle Model Required..!";s:8:"Err_m_dt";s:25:"Invalid Date for Tariff !";s:6:"Err_dt";s:0:"";s:8:"Err_date";s:13:"Invalid Date!";}'),
('f9f352ad5d6f1882052cb273b74a98de', '122.174.223.45', 'Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/201001', 1417587258, ''),
('fb7a5fe67eba68f6b6706bb2f7dad3e4', '122.174.223.55', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1414124371, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";}'),
('fd53f2833fb3040e2c3f0b699f11a3b5', '122.174.214.187', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416974342, ''),
('fdeeb2a03b8cbe09d669056690fdb60c', '122.174.218.128', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414040225, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('fec8231d55c460ca57ea615f3345d52f', '122.174.213.147', 'Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/201001', 1414400397, 'a:10:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"6";s:4:"name";s:16:"Ratheesh Vijayan";s:5:"email";s:24:"ratheeshvijayan@acube.co";s:8:"username";s:8:"ratheesh";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"e10adc3949ba59abbe56e057f20f883e";}'),
('fecd206dbba96fe6e7a1f68943961824', '123.237.128.26', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1415940728, 'a:16:{s:9:"user_data";s:0:"";s:22:"isloginAttemptexceeded";b:0;s:2:"id";s:1:"4";s:4:"name";s:11:"Nijo Joseph";s:5:"email";s:19:"nijojoseph@acube.co";s:8:"username";s:10:"nijojoseph";s:15:"organisation_id";s:1:"2";s:4:"type";s:1:"3";s:10:"isLoggedIn";b:1;s:10:"token_pass";s:32:"bf8191475f55068537a0dc716078dddb";s:11:"customer_id";s:2:"56";s:13:"customer_name";s:4:"nijo";s:14:"customer_email";s:13:"nijo@acube.co";s:15:"customer_mobile";s:10:"9020964268";s:9:"dbSuccess";s:0:"";s:7:"dbError";s:0:"";}'),
('ff6f9a312c32f3eefeb3c3f13dc5fc22', '122.174.218.6', 'Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/201001', 1416373359, '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `address`, `mobile`, `email`, `dob`, `registration_type_id`, `app_id`, `token`, `imei`, `password`, `fa_customer_id`, `organisation_id`, `customer_type_id`, `customer_group_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Ratheesh Vijayan', '', '9946109570', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, 4, 6, '2014-11-18 07:23:07', '0000-00-00 00:00:00'),
(2, 'Rajesh', '', '99469993540', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, 4, 6, '2014-11-18 07:59:20', '0000-00-00 00:00:00'),
(3, 'Mahesh', '', '9946999355', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, 4, 6, '2014-11-18 08:16:24', '0000-00-00 00:00:00'),
(4, 'Renjith', '', '9946999356', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, 4, 6, '2014-11-18 08:18:48', '0000-00-00 00:00:00'),
(5, 'Rajesh Vijayan', '', '9946109571', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, -1, 6, '2014-11-18 08:34:29', '0000-00-00 00:00:00'),
(6, 'Divya', '', '8089765434', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, -1, 5, '2014-11-19 07:26:09', '0000-00-00 00:00:00'),
(7, 'Manuel', '', '8086939019', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, -1, 6, '2014-11-19 07:32:30', '0000-00-00 00:00:00'),
(8, 'Saju Kumar', '', '9846189669', 'saju@connectncabs.com', '0000-00-00', 2, '5A70BC203732DC9108CB922A4FDAAF74', '4ec643d56f8abf843712af6618972488', '356521047172189', 'e10adc3949ba59abbe56e057f20f883e', 0, 2, 1, 0, 0, '2014-11-19 18:24:38', '0000-00-00 00:00:00'),
(9, 'ajay', '', '9746798917', 'ajayvgl01@gmail.com', '0000-00-00', 2, '5A70BC203732DC9108CB922A4FDAAF74', '7957b38b4a23d946a149a0c344a92676', '352996068474207', '2ed86cfcd46fe048c8a92999c3cd437a', 0, 2, 1, 0, 0, '2014-11-19 18:46:38', '0000-00-00 00:00:00'),
(10, 'rajesh t r', '', '9946999354', 'rajeshtr@acube.co', '0000-00-00', 2, '5A70BC203732DC9108CB922A4FDAAF74', 'b36fd50c8dfba213ebc977b92c83d230', '359090041118025', 'e10adc3949ba59abbe56e057f20f883e', 0, 2, 1, 0, 0, '2014-11-19 18:56:27', '0000-00-00 00:00:00'),
(11, 'Anil Kumar', '', '9876543432', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, -1, 5, '2014-11-24 06:46:53', '0000-00-00 00:00:00'),
(12, 'Nijo', '', '9020964268', '', '0000-00-00', 1, '', '', '', NULL, 0, 4, -1, -1, 14, '2014-11-26 05:50:48', '0000-00-00 00:00:00'),
(13, 'Ratheesh Vijayan', '', '9946109575', '', '0000-00-00', 1, '', '', '', NULL, 0, 2, -1, -1, 6, '2014-11-26 05:55:08', '0000-00-00 00:00:00'),
(14, 'Ratheesh Kumar', '', '9999999999', '', '0000-00-00', 1, '', '', '', NULL, 0, 4, -1, -1, 14, '2014-11-26 06:18:54', '0000-00-00 00:00:00'),
(15, 'Sarath', '', '4564564564', '', '0000-00-00', 1, '', '', '', NULL, 0, 4, -1, -1, 14, '2014-11-26 09:50:57', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'AVT', 'AVT', NULL, 4, 6, '2014-11-18 07:20:53', '0000-00-00 00:00:00'),
(2, 'Harisson', 'Harisson', NULL, 4, 6, '2014-11-18 07:21:05', '0000-00-00 00:00:00'),
(3, 'Manorama', 'Manorama', NULL, 4, 6, '2014-11-18 07:21:18', '0000-00-00 00:00:00'),
(5, 'OMS', 'OMS', NULL, 4, 6, '2014-11-18 07:21:37', '0000-00-00 00:00:00'),
(6, 'Acube', 'Acube', NULL, 4, 14, '2014-11-25 08:30:48', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `customer_registration_types`
--

INSERT INTO `customer_registration_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Phone Call', 'Phone Call', NULL, 4, 5, '2014-09-09 06:31:26', '2014-10-15 06:25:13'),
(2, 'Mobile App', 'Mobile App', NULL, 4, 5, '2014-09-09 06:31:40', '2014-10-15 06:25:37');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `customer_types`
--

INSERT INTO `customer_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(4, 'Cash', 'Cash', NULL, 4, 14, '2014-11-25 08:25:59', '0000-00-00 00:00:00'),
(5, 'Credit', 'Credit', NULL, 4, 14, '2014-11-25 08:26:16', '0000-00-00 00:00:00'),
(6, 'Walkin', 'Walkin', NULL, 4, 14, '2014-11-25 08:26:28', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `imei`, `sim_no`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, '100002000300010000', '9123456789', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, '200002000300020000', '9123456790', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, '300002000300030000', '9123456791', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, '400002000300040000', '9123456792', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, '500002000300050000', '9123456793', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, '600002000300060000', '9123456794', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, '700002000300070000', '9123443295', 2, 5, '0000-00-00 00:00:00', '2014-10-31 07:39:10'),
(8, '800002000300080000', '9123456796', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, '900002000300090000', '9123456797', 2, 5, '0000-00-00 00:00:00', '2014-10-31 07:38:57'),
(10, '1000002000300100000', '9123456798', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, '1100002000300110000', '9123456799', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, '1200002000300120000', '9123456800', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, '1300002000300130000', '9123456801', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, '1400002000300140000', '9123456802', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, '1500002000300150000', '9123456803', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, '1600002000300160000', '9123456804', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, '1700002000300170000', '9123456805', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, '1800002000300180000', '9123456806', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, '1900002000300190000', '9123456807', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, '2000002000300200000', '9123456808', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, '2100002000300210000', '9123456809', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, '2200002000300220000', '9123456810', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, '2300002000300230000', '9123456811', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, '2400002000300240000', '9123456812', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, '2500002000300250000', '9123456813', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, '2600002000300260000', '9123456814', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, '2700002000300270000', '9123456815', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, '2800002000300280000', '9123456816', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(29, '2900002000300290000', '9123456817', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(30, '3000002000300300000', '9123456818', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(31, '3100002000300310000', '9123456819', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, '3200002000300320000', '9123456820', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, '3300002000300330000', '9123456821', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(34, '3400002000300340000', '9123456822', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(35, '3500002000300350000', '9123456823', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(36, '3600002000300360000', '9123456824', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(37, '3700002000300370000', '9123456825', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(38, '3800002000300380000', '9123456826', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(39, '3900002000300390000', '9123456827', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(40, '4000002000300400000', '9123456828', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(41, '4100002000300410000', '9123456829', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(42, '4200002000300420000', '9123456830', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(43, '4300002000300430000', '9123456831', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(44, '4400002000300440000', '9123456832', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(45, '4500002000300450000', '9123456833', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(46, '4600002000300460000', '9123456834', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(47, '4700002000300470000', '9123456835', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(48, '4800002000300480000', '9123456836', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(49, '4900002000300490000', '9123456837', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(50, '5000002000300500000', '9123456838', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(51, '5100002000300510000', '9123456839', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(52, '5200002000300520000', '9123456840', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(53, '5300002000300530000', '9123456841', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(54, '5400002000300540000', '9123456842', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(55, '5500002000300550000', '9123456843', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(56, '5600002000300560000', '9123456844', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(57, '5700002000300570000', '9123456845', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(58, '5800002000300580000', '9123456846', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(59, '5900002000300590000', '9123456847', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(60, '6000002000300600000', '9123456848', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(61, '6100002000300610000', '9123456849', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(62, '6200002000300620000', '9123456850', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(63, '6300002000300630000', '9123456851', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(64, '6400002000300640000', '9123456852', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(65, '6500002000300650000', '9123456853', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(66, '6600002000300660000', '9123456854', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(67, '6700002000300670000', '9123456855', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(68, '6800002000300680000', '9123456856', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(69, '6900002000300690000', '9123456857', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(70, '7000002000300700000', '9123456858', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(71, '7100002000300710000', '9123456859', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(72, '7200002000300720000', '9123456860', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(73, '7300002000300730000', '9123456861', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(74, '7400002000300740000', '9123456862', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(75, '7500002000300750000', '9123456863', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(76, '7600002000300760000', '9123456864', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(77, '7700002000300770000', '9123456865', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(78, '7800002000300780000', '9123456866', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(79, '7900002000300790000', '9123456867', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(80, '8000002000300800000', '9123456868', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(81, '8100002000300810000', '9123456869', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, '8200002000300820000', '9123456870', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(83, '8300002000300830000', '9123456871', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(84, '8400002000300840000', '9123456872', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(85, '8500002000300850000', '9123456873', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, '8600002000300860000', '9123456874', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(87, '8700002000300870000', '9123456875', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(88, '8800002000300880000', '9123456876', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(89, '8900002000300890000', '9123456877', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(90, '9000002000300900000', '9123456878', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(91, '9100002000300910000', '9123456879', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(92, '9200002000300920000', '9123456880', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(93, '9300002000300930000', '9123456881', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(94, '9400002000300940000', '9123456882', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(95, '9500002000300950000', '9123456883', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(96, '9600002000300960000', '9123456884', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(97, '9700002000300970000', '9123456885', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(98, '9800002000300980000', '9123456886', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(99, '9900002000300990000', '9123456887', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(100, '1200000200030100000', '9123456888', 2, 6, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

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
  PRIMARY KEY (`id`),
  KEY `id_proof_type_id` (`id_proof_type_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `place_of_birth`, `dob`, `blood_group`, `marital_status_id`, `children`, `present_address`, `permanent_address`, `district`, `state`, `pin_code`, `phone`, `mobile`, `email`, `date_of_joining`, `license_number`, `license_renewal_date`, `badge`, `badge_renewal_date`, `mother_tongue`, `pan_number`, `bank_account_number`, `name_on_bank_pass_book`, `bank_name`, `branch`, `bank_account_type_id`, `ifsc_code`, `id_proof_type_id`, `id_proof_document_number`, `name_on_id_proof`, `salary`, `minimum_working_days`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Rosy', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9048663717', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 5, '2014-10-01 00:00:00', '2014-11-11 11:33:01'),
(2, 'Sunny', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9048271533', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(3, 'Swapna', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9497659304', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 5, '2014-10-01 00:00:00', '2014-11-11 11:45:45'),
(4, 'Shibu L&T', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9497687454', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(5, 'Sasi Kumar', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9847256728', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(6, 'Ratheesh', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9544716916', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(7, 'Jinson', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9645071046', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(8, 'Prakash', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9946663875', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(9, 'Ajayan', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9946141906', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(10, 'Arun Arun', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9633532262', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 5, '2014-10-01 00:00:00', '2014-11-11 11:52:30'),
(11, 'Maijo', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9446210531', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(12, 'Smithesh', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9526230332', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(13, 'Fahad', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '8606626622', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(14, 'Rahim', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895102981', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(15, 'Ajith Kumar', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895086574', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(16, 'Ratheesh', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '8089546113', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(17, 'Ruby', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9447788183', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(18, 'Aneesh Kumar', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9526782027', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(19, 'Jaison', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9526141710', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(20, 'Sivakumar', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9656941302', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(21, 'Anu', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9961244456', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(22, 'Ambi', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9947995119', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(23, 'Biju', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9847547543', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(24, 'Hanish', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9809470656', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(25, 'Melton', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9946072729', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(26, 'Binu', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9746082862', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(27, 'Tomy', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9747061942', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(28, 'Sony', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9633435427', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(29, 'Benny', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9745328019', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(30, 'Rajesh', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9387692905', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(31, 'Binu', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9747048633', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(32, 'Mani', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9846942674', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(33, 'Irshad', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895666171', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(34, 'Sreelal', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9605175639', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(35, 'Vimal', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895271793', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(36, 'Nibin', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895147760', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(37, 'Santosh', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9495034204', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(38, 'Abhishek', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9747739579', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(39, 'Sajeev', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9446163404', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(40, 'Xavier', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9847885352', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(41, 'Sreekumar', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9747723181', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(42, 'Hashim', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9497665434', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(43, 'Saji', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9495267128', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(44, 'Sajith', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895731786', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(45, 'Shiji', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9447666135', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(46, 'Shiju', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9447909371', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(47, 'Shibu', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9447576239', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(48, 'Selben', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9847984658', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(49, 'Sahid', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9895489772', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(50, 'Arun', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9526811997', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(51, 'Vinod', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9446250703', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(52, 'Jerry', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9388688772', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(53, 'Aby', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9744409332', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(54, 'Sujith', 'Cochin', '1980-01-01', '-1', -1, '', 'B-1012, JNI Stadium, Kaloor', 'B-1012, JNI Stadium, Kaloor', 'Ernakulam', 'Kerala', 682017, '4843240293', '9562920227', 'mail@connectncabs.com', '2014-10-01', '1000000000', '2020-01-01', '20000', '2020-01-01', 'Malayalam', '3E+11', '4E+11', 'Your Name', 'Your Bank', 'Your Branch', 1, 'Bank IFSC', 1, '5000000000', 'Your Name', 2500, 25, 2, 6, '2014-10-01 00:00:00', '2014-10-01 00:00:00'),
(55, 'Siby', '30-4-1980', '0000-00-00', '-1', -1, '', 'asfasfsafasfsfasf\nsfasfa\nsfasfasfasfs', '', 'Idukki', 'Kerala', 0, '1234567891', '1234567891', '', '2014-11-18', '', '0000-00-00', '', '0000-00-00', 'Malayalam', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 4, 14, '2014-11-25 07:51:20', '0000-00-00 00:00:00'),
(56, 'haloop', 'ernakulam', '0000-00-00', '-1', -1, '', 'ernakulam\nkerala', '', 'Ernakulam', '', 0, '04842345678', '9876543212', '', '2014-11-20', '', '0000-00-00', '', '0000-00-00', '', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 2, 5, '2014-11-25 08:18:14', '0000-00-00 00:00:00'),
(57, 'Samson', '30-4-1980', '0000-00-00', '-1', -1, '', 'ddasdsadasdasd', 'ddsasdadasdasd', 'Kochi', '', 0, '1231231231', '1231231231', '', '2014-11-18', '', '0000-00-00', '', '0000-00-00', 'English', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 4, 14, '2014-11-25 08:19:44', '0000-00-00 00:00:00'),
(58, 'Jim', 'Kollam', '0000-00-00', '2', 1, '1', 'dadasda\nKollam', 'sdsdas\nKollam', 'Kollam', 'Kerala', 682010, '1212121212', '1212121212', '', '0000-00-00', 'adasd', '0000-00-00', '', '0000-00-00', '', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 4, 14, '2014-11-26 06:05:36', '0000-00-00 00:00:00'),
(59, 'Hanish', 'Kannur', '1992-11-01', '0', 1, '1', 'a', 'a', 'a', '', 0, '2000051454', '9496430109', '', '2014-11-27', '', '0000-00-00', '', '0000-00-00', '', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 4, 14, '2014-11-27 05:03:01', '0000-00-00 00:00:00'),
(60, 'Rajeev', 'idukki', '2014-11-01', '6', 1, '', 'c', 'c', 'c', 'c', 0, '04712491260', '9496430100', '', '2014-11-01', '', '0000-00-00', '', '0000-00-00', '', '', '', '', '', '', -1, '', -1, '', '', 2500, 25, 4, 14, '2014-11-27 05:18:38', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `driver_type`
--

INSERT INTO `driver_type` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Contract', 'Contract', NULL, 4, 5, '2014-09-09 06:28:26', '0000-00-00 00:00:00'),
(3, 'Part Time', 'Part Time', NULL, 4, 5, '2014-09-09 06:29:00', '2014-10-15 06:17:48'),
(6, 'Permanent', 'Permanent', NULL, 4, 14, '2014-11-25 08:25:39', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `id_proof_types`
--

INSERT INTO `id_proof_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Driving License', 'Driving License', NULL, 4, 5, '2014-09-09 06:33:50', '2014-10-15 06:26:06'),
(2, 'Voters ID', 'Voters ID', NULL, 4, 5, '2014-09-09 06:34:04', '2014-10-15 07:33:53');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'English', 'English', NULL, 4, 5, '2014-09-09 06:27:15', '0000-00-00 00:00:00'),
(2, 'Malayalam', 'Malayalam', NULL, 4, 5, '2014-09-09 06:27:25', '0000-00-00 00:00:00'),
(3, 'Hindi', 'Hindi', NULL, 4, 5, '2014-09-09 06:27:37', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `language_proficiency`
--

INSERT INTO `language_proficiency` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Read', 'Read', NULL, 4, 5, '2014-09-09 06:27:49', '0000-00-00 00:00:00'),
(2, 'Write', 'Write', NULL, 4, 5, '2014-09-09 06:27:59', '0000-00-00 00:00:00'),
(3, 'Speak', 'Speak', NULL, 4, 5, '2014-09-09 06:28:09', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `marital_statuses`
--

INSERT INTO `marital_statuses` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Married', 'Married', NULL, 4, 5, '2014-09-09 06:31:59', '0000-00-00 00:00:00'),
(2, 'Single', 'Single', NULL, 4, 5, '2014-09-09 06:32:10', '0000-00-00 00:00:00'),
(3, 'Divorcee', 'Divorcee', NULL, 4, 5, '2014-09-09 06:32:33', '0000-00-00 00:00:00');

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `status_id` (`status_id`),
  KEY `id` (`id`),
  KEY `status_id_2` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `organisations`
--

INSERT INTO `organisations` (`id`, `name`, `address`, `status_id`, `created`, `updated`, `fa_account`) VALUES
(1, 'TALC', 'TALC Taxi, Vytilla, Ernakulam, Kerala', 2, '2014-08-28 05:10:37', '2014-10-11 08:58:42', 0),
(2, 'CONNECTNCABS', 'Connect n cabs, Kaloor, Ernakulam, kerala', 1, '2014-08-28 05:19:14', '2014-10-11 09:07:16', 1),
(3, 'ACUBEINNOVATIONS', 'No 120, Infopark TBC, Kochi.', 1, '2014-10-11 09:14:10', NULL, 0),
(4, 'Galaxy', 'Galaxy\nKochi', 1, '2014-11-25 07:11:44', '0000-00-00 00:00:00', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `payment_type`
--

INSERT INTO `payment_type` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(4, 'Account', 'Account', NULL, 4, 14, '2014-11-25 08:29:33', '0000-00-00 00:00:00'),
(5, 'Cash', 'Cash', NULL, 4, 14, '2014-11-25 08:29:44', '0000-00-00 00:00:00'),
(6, 'Credit', 'Credit', NULL, 4, 14, '2014-11-25 08:30:11', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `tariffs`
--

INSERT INTO `tariffs` (`id`, `tariff_master_id`, `vehicle_model_id`, `from_date`, `to_date`, `rate`, `additional_kilometer_rate`, `additional_hour_rate`, `driver_bata`, `night_halt`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 1, 1, '2014-10-23', '9999-12-30', 16.25, 9.9, 150, 45, 200, 4, 6, '2014-10-23 10:40:53', '2014-10-24 09:10:20'),
(3, 3, 1, '2014-10-23', '9999-12-30', 15, 9.9, 150, 45, 200, 4, 6, '2014-10-23 10:40:53', '2014-10-24 09:10:43'),
(4, 4, 1, '2014-10-23', '9999-12-30', 14, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(5, 5, 1, '2014-10-23', '9999-12-30', 7.19, 9.9, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(6, 6, 1, '2014-10-23', '9999-12-30', 6.56, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(7, 7, 1, '2014-10-23', '9999-12-30', 9.04, 9.9, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(8, 8, 1, '2014-10-23', '9999-12-30', 8.08, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(9, 15, 1, '2014-10-24', '9999-12-30', 10, 9.9, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '2014-10-24 09:09:03'),
(10, 10, 1, '2014-10-23', '9999-12-30', 8.33, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(11, 11, 1, '2014-10-23', '9999-12-30', 8.75, 9.9, 150, 0, 300, 4, 6, '2014-10-23 10:40:53', '2014-10-24 09:11:06'),
(12, 12, 1, '2014-10-23', '9999-12-30', 8, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(13, 13, 1, '2014-10-23', '9999-12-30', 30.77, 9.9, 150, 0, 400, 4, 6, '2014-10-23 10:40:53', '2014-10-24 09:11:36'),
(14, 14, 1, '2014-10-23', '9999-12-30', 27.69, 9.25, 130, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(15, 15, 2, '2014-10-23', '9999-12-30', 16.88, 13.5, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(16, 16, 2, '2014-10-23', '9999-12-30', 15.38, 13.5, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(17, 17, 2, '2014-10-23', '9999-12-30', 15, 13.5, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(18, 18, 3, '2014-10-23', '9999-12-30', 17.5, 14, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(19, 19, 3, '2014-10-23', '9999-12-30', 15.96, 14, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(20, 20, 3, '2014-10-23', '9999-12-30', 15.87, 14, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(21, 21, 4, '2014-10-23', '9999-12-30', 20, 16, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(22, 22, 4, '2014-10-23', '9999-12-30', 16.92, 16, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(23, 23, 4, '2014-10-23', '9999-12-30', 18, 16, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(24, 24, 5, '2014-10-23', '9999-12-30', 21.25, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(25, 25, 5, '2014-10-23', '9999-12-30', 18.08, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(26, 26, 5, '2014-10-23', '9999-12-30', 19, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(27, 27, 6, '2014-10-23', '9999-12-30', 21.25, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(28, 28, 6, '2014-10-23', '9999-12-30', 18.08, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(29, 29, 6, '2014-10-23', '9999-12-30', 19, 17, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(30, 30, 7, '2014-10-23', '9999-12-30', 26.25, 22, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(31, 31, 7, '2014-10-23', '9999-12-30', 23.85, 22, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(32, 32, 7, '2014-10-23', '9999-12-30', 23.33, 22, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(33, 33, 8, '2014-10-23', '9999-12-30', 31.25, 25, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(34, 34, 8, '2014-10-23', '9999-12-30', 28.08, 25, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(35, 35, 8, '2014-10-23', '9999-12-30', 28, 25, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(36, 36, 9, '2014-10-23', '9999-12-30', 37.5, 30, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(37, 37, 9, '2014-10-23', '9999-12-30', 34.62, 30, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(38, 38, 9, '2014-10-23', '9999-12-30', 34, 30, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(39, 39, 10, '2014-10-23', '9999-12-30', 56.25, 38, 350, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(40, 40, 10, '2014-10-23', '9999-12-30', 48.46, 38, 350, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(41, 41, 10, '2014-10-23', '9999-12-30', 47.67, 38, 350, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(42, 42, 11, '2014-10-23', '9999-12-30', 125, 50, 500, 0, 300, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(43, 43, 11, '2014-10-23', '9999-12-30', 92.31, 50, 500, 0, 300, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(44, 44, 12, '2014-10-23', '9999-12-30', 17.5, 13, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(45, 45, 12, '2014-10-23', '9999-12-30', 15.77, 13, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(46, 46, 12, '2014-10-23', '9999-12-30', 15.33, 13, 150, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(47, 47, 13, '2014-10-23', '9999-12-30', 17.5, 13, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(48, 48, 13, '2014-10-23', '9999-12-30', 15.77, 13, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(49, 49, 13, '2014-10-23', '9999-12-30', 15.33, 13, 175, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(50, 50, 14, '2014-10-23', '9999-12-30', 17.5, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(51, 51, 14, '2014-10-23', '9999-12-30', 15.77, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(52, 52, 14, '2014-10-23', '9999-12-30', 15.33, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(53, 53, 15, '2014-10-23', '9999-12-30', 20, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(54, 54, 15, '2014-10-23', '9999-12-30', 18.27, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(55, 55, 15, '2014-10-23', '9999-12-30', 18, 16, 200, 0, 200, 4, 6, '2014-10-23 10:40:53', '0000-00-00 00:00:00'),
(56, 9, 8, '2014-10-25', '9999-12-30', 34, 45, 40, 34, 200, 4, 5, '2014-10-24 09:12:42', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tariff_masters`
--

CREATE TABLE IF NOT EXISTS `tariff_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `trip_model_id` int(11) NOT NULL,
  `vehicle_make_id` int(11) NOT NULL,
  `vehicle_model_id` int(11) NOT NULL,
  `vehicle_type_id` int(11) NOT NULL,
  `vehicle_ac_type_id` int(11) NOT NULL,
  `minimum_kilometers` double NOT NULL,
  `minimum_hours` double NOT NULL,
  `organisation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `vehicle_make_id` (`vehicle_make_id`),
  KEY `vehicle_type_id` (`vehicle_type_id`),
  KEY `trip_model_id` (`trip_model_id`),
  KEY `vehicle_make_id_2` (`vehicle_make_id`),
  KEY `vehicle_type_id_2` (`vehicle_type_id`),
  KEY `vehicle_ac_type_id` (`vehicle_ac_type_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`),
  KEY `vehicle_model_id` (`vehicle_model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `tariff_masters`
--

INSERT INTO `tariff_masters` (`id`, `title`, `trip_model_id`, `vehicle_make_id`, `vehicle_model_id`, `vehicle_type_id`, `vehicle_ac_type_id`, `minimum_kilometers`, `minimum_hours`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, '8hr / 20km AC', 5, 1, 0, 2, 1, 20, 2, 4, 6, '2014-11-26 06:23:56', '2014-10-24 09:07:38'),
(2, '2hr / 20km NON', 1, 1, 0, 2, 2, 20, 2, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(3, '4hr / 50km AC', 1, 1, 0, 2, 1, 50, 4, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(4, '4hr / 50km NON', 1, 1, 0, 2, 2, 80, 4, 4, 6, '2014-11-26 06:24:10', '2014-10-24 06:13:48'),
(5, '8hr / 80 Km AC', 1, 1, 0, 2, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(6, '8hr / 80 Km NON', 1, 1, 0, 2, 2, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(7, '10hr / 130 Km AC', 1, 1, 0, 2, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(8, '10hr / 130 Km NON', 1, 1, 0, 2, 2, 400, 10, 4, 6, '2014-11-26 06:24:10', '2014-10-24 06:14:06'),
(9, '12hr / 150 Km AC', 1, 1, 0, 2, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(10, '12hr / 150 Km NON', 1, 1, 0, 2, 2, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(11, '14hr / 200 Km AC', 1, 1, 0, 2, 1, 200, 14, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(12, '14hr / 200 Km NON', 1, 1, 0, 2, 2, 200, 14, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(13, 'Airport AC', 1, 1, 0, 2, 1, 65, 6, 4, 6, '2014-11-26 06:24:10', '2014-10-23 10:28:05'),
(14, 'Airport NON', 1, 1, 0, 2, 2, 65, 6, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(15, '8hr / 80 Km AC', 1, 1, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(16, '10hr / 130 Km AC', 1, 1, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(17, '12hr / 150 Km AC', 1, 1, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(18, '8hr / 80 Km AC', 1, 5, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(19, '10hr / 130 Km AC', 1, 5, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(20, '12hr / 150 Km AC', 1, 5, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(21, '8hr / 80 Km AC', 1, 4, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(22, '10hr / 130 Km AC', 1, 4, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(23, '12hr / 150 Km AC', 1, 4, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(24, '8hr / 80 Km AC', 1, 7, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(25, '10hr / 130 Km AC', 1, 7, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(26, '12hr / 150 Km AC', 1, 7, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(27, '8hr / 80 Km AC', 1, 4, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(28, '10hr / 130 Km AC', 1, 4, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(29, '12hr / 150 Km AC', 1, 4, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(30, '8hr / 80 Km AC', 1, 6, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(31, '10hr / 130 Km AC', 1, 6, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(32, '12hr / 150 Km AC', 1, 6, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(33, '8hr / 80 Km AC', 1, 2, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(34, '10hr / 130 Km AC', 1, 2, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(35, '12hr / 150 Km AC', 1, 2, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(36, '8hr / 80 Km AC', 1, 2, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(37, '10hr / 130 Km AC', 1, 2, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(38, '12hr / 150 Km AC', 1, 2, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(39, '8hr / 80 Km AC', 1, 8, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(40, '10hr / 130 Km AC', 1, 8, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(41, '12hr / 150 Km AC', 1, 8, 0, 1, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(42, '8hr / 80 Km AC', 1, 9, 0, 1, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(43, '10hr / 130 Km AC', 1, 9, 0, 1, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(44, '8hr / 80 Km AC', 1, 10, 0, 3, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(45, '10hr / 130 Km AC', 1, 10, 0, 3, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(46, '12hr / 150 Km AC', 1, 10, 0, 3, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(47, '8hr / 80 Km AC', 1, 5, 0, 3, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(48, '10hr / 130 Km AC', 1, 5, 0, 3, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(49, '12hr / 150 Km AC', 1, 5, 0, 3, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(50, '8hr / 80 Km AC', 1, 2, 0, 3, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(51, '10hr / 130 Km AC', 1, 2, 0, 3, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(52, '12hr / 150 Km AC', 1, 2, 0, 3, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(53, '8hr / 80 Km AC', 1, 1, 0, 3, 1, 80, 8, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(54, '10hr / 130 Km AC', 1, 1, 0, 3, 1, 130, 10, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(55, '12hr / 150 Km AC', 1, 1, 0, 3, 1, 150, 12, 4, 6, '2014-11-26 06:24:10', '0000-00-00 00:00:00'),
(56, '5hr / 20km AC', 3, 5, 0, 2, 2, 45, 3, 4, 5, '2014-11-26 06:24:10', '0000-00-00 00:00:00');

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
  `priority` varchar(50) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `customer_id`, `guest_id`, `customer_type_id`, `customer_group_id`, `trip_status_id`, `booking_date`, `booking_time`, `booking_source_id`, `source`, `pick_up_date`, `pick_up_time`, `drop_time`, `drop_date`, `pick_up_city`, `pick_up_area`, `pick_up_landmark`, `pick_up_lat`, `pick_up_lng`, `drop_city`, `drop_area`, `drop_landmark`, `drop_lat`, `drop_lng`, `via_city`, `via_area`, `via_landmark`, `via_lat`, `via_lng`, `no_of_passengers`, `kilometer_reading_start`, `kilometer_reading_drop`, `vehicle_type_id`, `vehicle_ac_type_id`, `vehicle_fuel_type_id`, `vehicle_seating_capacity_id`, `vehicle_beacon_light_option_id`, `vehicle_make_id`, `vehicle_model_id`, `driver_language_id`, `pluckcard`, `uniform`, `driver_language_proficiency_id`, `trip_model_id`, `tariff_id`, `payment_type_id`, `driver_id`, `vehicle_id`, `advance_amount`, `driver_batta`, `total_amount`, `remarks`, `organisation_id`, `user_id`, `created`, `updated`, `priority`) VALUES
(1, 1, -1, 0, 4, 8, '2014-11-18', '13:12:00', 1, '0', '2014-11-18', '01:00:00', '10:30:00', '2014-11-18', 'kaloor', '', '', 0, 0, 'kalamassery', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, 1, 1, 0, -1, 0, 1, 2, -1, 0, 0, 0, -1, -1, 0, 1, 1, 0, 0, 0, '', 2, 6, '2014-11-18 07:33:22', '2014-11-18 08:21:30', ''),
(2, 4, -1, 0, 4, 2, '2014-11-18', '13:49:00', 1, '0', '2014-11-18', '07:30:00', '09:30:00', '2014-11-18', 'Alwaye', '', '', 0, 0, 'Aroor', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, 1, -1, 0, 0, 0, -1, -1, 0, 42, 2, 0, 0, 0, '', 2, 6, '2014-11-18 08:19:42', '0000-00-00 00:00:00', ''),
(3, 5, -1, 0, 0, 8, '2014-11-18', '14:05:00', 1, '0', '2014-11-18', '02:00:00', '20:00:00', '2014-11-18', 'Angamaly', '', '', 0, 0, 'Vadakara', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, 1, -1, 0, 0, 0, -1, -1, 0, 1, 1, 0, 0, 0, '', 2, 6, '2014-11-18 08:35:21', '2014-11-18 08:36:30', ''),
(4, 6, -1, 0, -1, 8, '2014-11-19', '12:57:00', 1, '0', '2014-11-19', '09:00:00', '10:30:00', '2014-11-21', 'Ernakulam', '', '', 0, 0, 'Mysore', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, 7, -1, 0, 0, 0, -1, 30, 0, 13, 1, 0, 0, 0, '', 2, 5, '2014-11-19 07:27:26', '2014-11-19 07:29:44', ''),
(5, 7, -1, 0, -1, 8, '2014-11-19', '13:03:00', -1, '0', '2014-11-20', '10:00:00', '21:00:00', '2014-11-22', 'Goa', '', '', 0, 0, 'Ernakulam', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, 4, -1, 0, 0, 0, -1, -1, 0, 1, 1, 0, 0, 0, '', 2, 6, '2014-11-19 07:33:34', '2014-11-22 05:23:30', ''),
(6, 8, 0, 0, 0, 1, '2014-11-19', '18:46:04', 4, '', '2014-11-19', '18:46:00', '00:00:00', '0000-00-00', 'aluva', 'Stadium Round\nKaloor\nErnakulam, Kerala 682017\n', 'aluva', 9.996421991238577, 76.30177214741707, 'aluva', 'City', '', 76345662, 76345662, '', '', '', 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 2, 0, '2014-11-19 13:16:04', '0000-00-00 00:00:00', 'now'),
(7, 8, 0, 0, 0, 1, '2014-11-19', '19:05:40', 4, '', '2014-11-21', '19:00:00', '00:00:00', '0000-00-00', 'cichin', 'Welfare Rd\nKaloor\nErnakulam, Kerala\n', 'cichin,airport', 9.99838197040003, 76.30235485732555, 'Kalamassery Vallarpadam Road, Cheranalloor, Ernakulam, Kerala, India', 'cochin', '\n\n', 76286408, 76286408, '', '', '', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 2, 0, '2014-11-19 13:35:40', '0000-00-00 00:00:00', 'later'),
(8, 0, -1, 0, 4, 1, '2014-11-24', '12:15:00', -1, '0', '2014-11-22', '04:00:00', '06:00:00', '2014-11-23', 'Goa', '', '', 0, 0, '', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, -1, -1, 0, 0, 0, -1, -1, 0, -1, -1, 0, 0, 0, '', 2, 5, '2014-11-24 06:45:10', '0000-00-00 00:00:00', ''),
(9, 11, -1, 0, -1, 1, '2014-11-24', '12:16:00', -1, '0', '2014-11-23', '06:00:00', '07:00:00', '2014-11-25', 'Ernakulam', '', '', 0, 0, '', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, -1, -1, 0, 0, 0, -1, -1, 0, -1, -1, 0, 0, 0, '', 2, 5, '2014-11-24 06:46:56', '0000-00-00 00:00:00', ''),
(10, 0, -1, 0, 1, 8, '2014-11-24', '12:38:00', -1, '0', '2014-11-25', '09:00:00', '11:20:00', '2014-11-25', 'sdf', '', '', 0, 0, '', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, 4, 1, 0, -1, 0, 3, 8, -1, 0, 0, 0, 1, -1, 0, 13, 2, 0, 0, 0, 'sdfds', 2, 4, '2014-11-24 07:08:06', '2014-11-24 12:34:51', ''),
(11, 1, -1, 0, 4, 8, '2014-11-24', '14:52:00', 1, '0', '2014-11-24', '16:00:00', '18:20:00', '2014-11-24', 'medical', '', '', 0, 0, 'tvm', '', '', 0, 0, 'kottayam', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, 11, -1, 0, 0, 0, 2, -1, 0, 53, 1, 0, 0, 0, 'sdf', 2, 6, '2014-11-24 09:22:25', '2014-11-28 11:51:18', ''),
(12, 0, -1, 0, 4, 1, '2014-11-24', '17:09:00', -1, '0', '2014-11-11', '04:00:00', '08:00:00', '2014-11-12', 'Goa', '', '', 0, 0, '', '', '', 0, 0, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, -1, -1, -1, 0, 0, 0, -1, -1, 0, -1, -1, 0, 0, 0, '', 2, 5, '2014-11-24 11:39:49', '0000-00-00 00:00:00', ''),
(13, 12, -1, -1, -1, 8, '2014-11-26', '12:49:00', 1, '', '2014-11-27', '12:30:00', '06:30:00', '2014-11-28', 'Alappuzha', '', '', 9.4980667, 76.3388484, 'Trivandrum', '', '', 8.5241391, 76.9366376, '', '', '', 0, 0, 0, 0, 0, 2, 1, 0, -1, 0, -1, 1, -1, 0, 0, 0, -1, 3, 0, 55, 8, 0, 0, 0, '', 4, 14, '2014-11-26 07:15:13', '2014-11-26 10:59:43', ''),
(14, 14, -1, -1, -1, 8, '2014-11-26', '15:14:00', 1, '', '2014-11-26', '16:00:00', '20:00:00', '2014-11-26', 'Kochi', '', '', 9.9312328, 76.2673041, 'Nedumbassery', '', '', 10.1656696, 76.3938161, '', '', '', 0, 0, 0, 0, 0, 2, 1, 0, -1, 0, -1, 1, -1, 0, 0, 0, 5, 1, 0, 55, 8, 0, 0, 0, '', 4, 14, '2014-11-26 09:44:28', '2014-11-26 11:04:06', ''),
(15, 15, -1, -1, -1, 6, '2014-11-26', '15:22:00', -1, '', '2014-11-26', '15:30:00', '18:00:00', '2014-11-26', 'Kochi', '', '', 9.9312328, 76.2673041, 'Cherthala', '', '', 9.6836368, 76.3365377, '', '', '', 0, 0, 3, 0, 0, 2, 1, 0, -1, 0, -1, 4, -1, 0, 0, 0, 1, 21, 0, 57, 10, 0, 0, 0, '', 4, 14, '2014-11-26 09:52:09', '2014-12-03 06:39:27', ''),
(16, 12, -1, -1, -1, 8, '2014-11-26', '15:25:00', -1, '', '2014-11-26', '15:30:00', '18:30:00', '2014-11-26', 'Alappuzha', '', '', 9.4980667, 76.3388484, 'Kochi', '', '', 9.9312328, 76.2673041, '', '', '', 0, 0, 0, 0, 0, 1, 1, 0, -1, 0, -1, 3, -1, 0, 0, 0, -1, 18, 0, 58, 12, 0, 0, 0, '', 4, 14, '2014-11-26 09:54:08', '2014-12-03 06:38:20', ''),
(17, 1, -1, -1, -1, 8, '2014-11-26', '17:23:00', 1, '', '2014-11-26', '14:00:00', '20:30:00', '2014-11-26', 'Kochi', '', '', 9.9312328, 76.2673041, 'Kannur', '', '', 11.8744775, 75.3703662, '', '', '', 0, 0, 0, 0, 0, 2, 1, 0, -1, 0, 1, 1, -1, 0, 0, 0, -1, 5, 0, 55, 8, 0, 0, 0, '', 4, 14, '2014-11-26 11:53:09', '2014-11-26 11:56:21', ''),
(18, 1, -1, -1, -1, 8, '2014-11-27', '10:51:00', -1, '', '2014-11-27', '00:00:00', '05:30:00', '2014-11-27', 'Kochi', '', '', 9.9312328, 76.2673041, 'Thrissur', '', '', 10.5276416, 76.2144349, '', '', '', 0, 0, 0, 0, 0, -1, 1, 0, -1, 0, 1, 1, -1, 0, 0, 0, -1, -1, 0, 60, 11, 0, 0, 0, '', 4, 14, '2014-11-27 05:21:39', '2014-12-03 06:36:38', ''),
(19, 8, 0, 0, 0, 1, '2014-12-01', '05:50:07', 4, '', '2014-12-01', '05:50:00', '00:00:00', '0000-00-00', 'ernakulam', 'Stadium Round\nKaloor\nErnakulam, Kerala 682017\n', 'ernakulam,provident fund office', 9.9964801039983, 76.30135506391525, 'Aluva, Kerala, India', 'ERNAKULAM', 'federal tower', 76345662, 76345662, '', '', '', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 2, 0, '2014-12-01 00:20:07', '0000-00-00 00:00:00', 'now');

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
(1, 'Toll', 'Toll', NULL, 4, 5, '2014-09-09 06:40:08', '0000-00-00 00:00:00'),
(2, 'State Tax', 'StateTax', NULL, 4, 5, '2014-09-09 06:40:23', '2014-10-15 07:37:08'),
(3, 'Night Halt', 'NightHalt', NULL, 4, 5, '2014-09-09 06:41:03', '2014-10-15 07:37:16'),
(4, 'Extra Petrol or Diesel', 'ExtraPetrolOrDiesel', NULL, 4, 5, '2014-09-09 06:41:44', '2014-10-15 07:37:32');

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
(1, 'Local', 'Local', NULL, 4, 5, '2014-09-09 06:34:18', '0000-00-00 00:00:00'),
(2, 'Out Station', 'Out Station', NULL, 4, 5, '2014-09-09 06:34:32', '2014-10-15 07:34:12'),
(3, 'Rent a Car', 'Rent a Car', NULL, 4, 5, '2014-09-09 06:34:56', '2014-10-15 07:34:27'),
(5, 'Airport Pickup Drop', 'Airport Pickup Drop', NULL, 4, 5, '2014-09-09 06:35:57', '2014-10-15 07:34:56');

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
(1, 'Pending', 'Pending', NULL, 4, 5, '2014-09-09 06:36:20', '2014-09-09 06:36:31'),
(2, 'Confirmed', 'Confirmed', NULL, 4, 5, '2014-09-09 06:36:51', '0000-00-00 00:00:00'),
(3, 'Canceled', 'Canceled', NULL, 4, 5, '2014-09-09 06:37:07', '0000-00-00 00:00:00'),
(4, 'Customer Canceled', 'Customer Canceled', NULL, 4, 5, '2014-09-09 06:37:25', '2014-10-15 07:35:17'),
(5, 'OnTrip', 'OnTrip', NULL, 4, 5, '2014-09-09 06:37:43', '0000-00-00 00:00:00'),
(6, 'Trip Completed', 'TripCompleted', NULL, 4, 5, '2014-09-09 06:37:59', '2014-10-15 07:35:29'),
(7, 'Trip Payed', 'TripPayed', NULL, 4, 5, '2014-09-09 06:38:17', '2014-10-15 07:35:37'),
(8, 'Bill Generated', 'BillGenerated', NULL, 4, 5, '2014-09-29 07:37:59', '2014-10-15 07:35:45');

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
  `trip_starting_time` time NOT NULL,
  `trip_ending_time` time NOT NULL,
  `total_trip_amount` double NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `voucher_no` int(11) NOT NULL,
  `km_hr` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 -km tarif,2 hourly tarif',
  `base_tarif` varchar(50) NOT NULL,
  `base_amount` double NOT NULL,
  `adt_tarif` varchar(50) NOT NULL,
  `adt_tarif_rate` double NOT NULL,
  `vehicle_tarif` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_id` (`trip_id`,`organisation_id`,`driver_id`,`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `trip_vouchers`
--

INSERT INTO `trip_vouchers` (`id`, `trip_id`, `start_km_reading`, `end_km_reading`, `organisation_id`, `driver_id`, `driver_bata`, `user_id`, `garage_closing_kilometer_reading`, `garage_closing_time`, `releasing_place`, `parking_fees`, `toll_fees`, `state_tax`, `night_halt_charges`, `fuel_extra_charges`, `no_of_days`, `trip_starting_time`, `trip_ending_time`, `total_trip_amount`, `created`, `updated`, `voucher_no`, `km_hr`, `base_tarif`, `base_amount`, `adt_tarif`, `adt_tarif_rate`, `vehicle_tarif`) VALUES
(1, 1, 11258, 11369, 2, 1, 150, 6, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '01:00:00', '10:30:00', 2258, '2014-11-18 08:21:30', '0000-00-00 00:00:00', 15500, 1, '80', 1550, '31', 18, 1850),
(2, 3, 1002, 1250, 2, 1, 150, 6, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '02:00:00', '20:00:00', 4066, '2014-11-18 08:36:30', '0000-00-00 00:00:00', 11551, 1, '130', 2500, '118', 12, 2500),
(3, 4, 1115, 1326, 2, 13, 250, 5, 0, '00:00:00', '', 100, 100, 100, 100, 0, 63, '09:00:00', '10:30:00', 2050, '2014-11-19 07:29:44', '0000-00-00 00:00:00', 89876, 1, '200', 300, '11', 100, 4000),
(4, 5, 11258, 11727, 2, 1, 0, 6, 0, '00:00:00', '', 0, 0, 0, 0, 0, 3, '10:00:00', '21:00:00', 0, '2014-11-22 05:23:19', '2014-11-22 05:23:30', 11245, 1, '', 0, '', 0, 0),
(5, 10, 1500, 1650, 2, 13, 250, 6, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '09:00:00', '11:20:00', 3050, '2014-11-24 07:09:15', '2014-11-24 12:34:51', 245, 1, '120', 2500, '30', 10, 1200),
(6, 13, 4545, 4646, 4, 55, 0, 14, 0, '00:00:00', '', 0, 0, 0, 0, 0, 31, '12:30:00', '06:30:00', 3010, '2014-11-26 10:25:00', '2014-11-26 10:59:43', 3423, 1, '100', 3000, '1', 10, 0),
(7, 14, 1121, 1247, 4, 55, 0, 14, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '16:00:00', '20:00:00', 2240, '2014-11-26 11:04:06', '0000-00-00 00:00:00', 12345, 1, '80', 1550, '46', 15, 0),
(8, 17, 11478, 11757, 4, 55, 0, 14, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '14:00:00', '20:30:00', 4686.5, '2014-11-26 11:55:37', '2014-11-26 11:56:21', 1235, 1, '80', 2000, '199', 13.5, 0),
(9, 11, 14220, 14420, 2, 53, 250, 4, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '16:00:00', '18:20:00', 4710, '2014-11-28 10:55:19', '2014-11-28 11:51:18', 142, 1, '120', 3500, '80', 12, 1500),
(10, 18, 11247, 11369, 4, 60, 250, 14, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '00:00:00', '05:30:00', 3080, '2014-12-03 05:43:16', '2014-12-03 06:36:38', 11254, 1, '100', 2500, '22', 15, 0),
(11, 16, 112, 245, 4, 58, 250, 14, 0, '00:00:00', '', 0, 0, 0, 0, 0, 1, '15:30:00', '18:30:00', 2745, '2014-12-03 06:38:20', '0000-00-00 00:00:00', 4534, 1, '100', 2000, '33', 15, 0);

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
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fa_account` int(11) NOT NULL DEFAULT '0' COMMENT 'fa user id',
  PRIMARY KEY (`id`),
  KEY `user_status_id` (`user_status_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `id` (`id`),
  KEY `user_status_id_2` (`user_status_id`),
  KEY `user_type_id` (`user_type_id`),
  KEY `organisation_id_2` (`organisation_id`),
  KEY `organisation_admin_id` (`organisation_admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `address`, `occupation`, `user_status_id`, `password_token`, `user_type_id`, `organisation_id`, `organisation_admin_id`, `created`, `updated`, `fa_account`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'System', 'Administrator', 'admin@connectncabs.local', NULL, NULL, NULL, 1, NULL, 1, -1, NULL, '2014-08-11 00:00:00', '0000-00-00 00:00:00', 0),
(2, 'talc123', '1402c1b89ebcf3cd9d713aec00513a93', 'TALC', 'TALC', 'talc@talc.com', '9020964268', 'TALC Taxi, Vytilla, Ernakulam, Kerala', NULL, 2, NULL, 2, 1, NULL, '2014-08-28 05:10:37', '0000-00-00 00:00:00', 0),
(3, 'connectncabs', '7e4da08906338586b3756c3fa0f5bb89', 'connectn', 'cabs', 'connectncabs@connectncabs.com', '9020964268', 'Connect n cabs, Kaloor, Ernakulam, kerala', NULL, 1, NULL, 2, 2, NULL, '2014-08-28 05:19:14', '0000-00-00 00:00:00', 1),
(4, 'nijojoseph', 'bf8191475f55068537a0dc716078dddb', 'Nijo', 'Joseph', 'nijojoseph@acube.co', '9020964268', 'No 120, Infopark TBC, Kaloor, Kochi', NULL, 1, NULL, 3, 2, NULL, '2014-08-28 05:25:06', '0000-00-00 00:00:00', 2),
(5, 'divya', '6a670fed44634a9e6967bc5cec37840b', 'Divya', 'Manoj', 'divya@acube.co', '9020964268', 'Kaloor,ernakulam,kerala', NULL, 1, NULL, 3, 2, NULL, '2014-08-28 05:26:37', '0000-00-00 00:00:00', 0),
(6, 'ratheesh', 'e10adc3949ba59abbe56e057f20f883e', 'Ratheesh', 'Vijayan', 'ratheeshvijayan@acube.co', '9946109570', 'No 120, Infopark TBC, Kaloor, Kochi', NULL, 1, NULL, 3, 2, NULL, '2014-10-11 07:29:20', '0000-00-00 00:00:00', 3),
(7, 'rajeshtr', 'e10adc3949ba59abbe56e057f20f883e', 'Rajesh', 'T R', 'rajeshtr@acube.co', '9946999354', 'No 120, Infopark TBC, Kaloor, Kochi', NULL, 1, NULL, 3, 2, NULL, '2014-10-11 07:37:20', '0000-00-00 00:00:00', 4),
(8, 'acube', 'e10adc3949ba59abbe56e057f20f883e', 'Acube', 'Innovations', 'info@acube.co', '4846066060', 'No 120, Infopark TBC, Kochi.', NULL, 1, NULL, 2, 3, NULL, '2014-10-11 09:14:10', '0000-00-00 00:00:00', 0),
(9, 'rajkumar', 'e10adc3949ba59abbe56e057f20f883e', 'Raj', 'Kumar', 'mail@connectncabs.com', '9645689669', 'mail@connectncabs.com', NULL, 1, NULL, 3, 2, NULL, '2014-10-14 08:53:14', '0000-00-00 00:00:00', 5),
(10, 'sajukumar', 'e10adc3949ba59abbe56e057f20f883e', 'Saju', 'Kumar', 'mail1@connectncabs.com', '9946109575', 'mail@connectncabs.com', NULL, 1, NULL, 3, 2, NULL, '2014-10-14 08:57:50', '0000-00-00 00:00:00', 6),
(11, 'valsa', 'e10adc3949ba59abbe56e057f20f883e', 'Valsa', 'Sajukumar', 'mail2@connectncabs.com', '9946109578', 'mail@connectncabs.com', NULL, 1, NULL, 3, 2, NULL, '2014-10-14 08:59:21', '0000-00-00 00:00:00', 7),
(12, 'nijo', 'bf8191475f55068537a0dc716078dddb', 'nijo', 'joseph', 'nijo@acube.co', '9020989098', 'dsadasdawtehgrte', NULL, 1, NULL, 3, 2, NULL, '2014-11-19 06:26:43', '0000-00-00 00:00:00', 0),
(13, 'demo123', '62cc2d8b4bf2d8728120d052163a77df', 'Galaxy', 'Demo', 'info1@acube.co', '9946999353', 'Galaxy\nKochi', NULL, 1, NULL, 2, 4, NULL, '2014-11-25 07:11:44', '0000-00-00 00:00:00', 1),
(14, 'demouser', '62cc2d8b4bf2d8728120d052163a77df', 'User', 'demo', 'userdemo@galaxy.com', '1234567890', 'Galaxy\nKochi', NULL, 1, NULL, 3, 4, NULL, '2014-11-25 07:48:09', '0000-00-00 00:00:00', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `user_login_attempts`
--

INSERT INTO `user_login_attempts` (`id`, `user_id`, `ip_address`, `created`) VALUES
(1, 6, '122.174.219.34', '2014-11-03 05:29:48'),
(2, 6, '122.174.219.34', '2014-11-03 05:29:56');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`id`, `name`, `description`) VALUES
(1, 'System Administrator', 'System Administrator'),
(2, 'Organisation Administrator', 'Organisation Administrator'),
(3, 'Front Desk', 'Front Desk');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `registration_number`, `registration_date`, `engine_number`, `chases_number`, `vehicles_insurance_id`, `vehicle_loan_id`, `vehicle_owner_id`, `vehicle_ownership_types_id`, `vehicle_type_id`, `vehicle_make_id`, `vehicle_model_id`, `vehicle_manufacturing_year`, `vehicle_ac_type_id`, `vehicle_fuel_type_id`, `vehicle_seating_capacity_id`, `vehicle_permit_type_id`, `vehicle_permit_renewal_date`, `vehicle_permit_renewal_amount`, `tax_renewal_amount`, `tax_renewal_date`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'KL 01 Z 5534', '2014-12-01', '275272728752', '414258852752', 1, 0, 3, 1, 2, 1, 1, 2014, 1, 1, 1, 1, '2014-11-13', 500, 6, '2014-10-13', 2, 5, '2014-10-13 09:05:49', '2014-10-27 04:34:14'),
(2, 'KL 07 CA 2251', '2014-10-14', '324555', '324555', 0, 4, 1, 2, 2, 1, 1, 1989, 1, 2, 2, 2, '2014-10-15', 2350, 2000, '2014-10-16', 2, 5, '2014-10-13 09:41:19', '2014-10-24 09:19:06'),
(3, '4578645', '2014-10-21', '5243', '124', 0, 1, 0, 2, 2, 1, 1, 2014, 2, 1, 2, 1, '2014-10-29', 3556, 4343, '2014-10-23', 1, 5, '2014-10-14 07:21:17', '0000-00-00 00:00:00'),
(4, '4545456', '2014-10-22', '436436436', '46464646', 0, 2, 0, 3, 3, 2, 1, 2014, 2, 2, 3, 1, '2014-10-17', 4235, 43646, '2014-10-21', 1, 5, '2014-10-14 07:32:23', '0000-00-00 00:00:00'),
(5, 'Kl 6585', '2014-10-21', '5243', '253', 0, 3, 2, 2, 2, 3, 1, 2014, 1, 2, 1, 2, '2014-10-24', 5775, 350, '2014-10-21', 1, 5, '2014-10-14 07:38:57', '0000-00-00 00:00:00'),
(6, 'KL 01 Z 5878', '2014-12-01', '275272728752234', '41425885275232', 0, 0, 4, 1, 2, 1, 1, 0, 1, 2, 1, 1, '2021-10-31', 5000, 4252, '2014-10-15', 2, 6, '2014-10-15 09:58:01', '0000-00-00 00:00:00'),
(7, 'KL 07 AD 0369', '2014-12-01', '2454572728752', '2454572728752', 0, 0, 5, 1, 2, 1, 1, 0, 1, 2, 1, 1, '2014-10-15', 2140, 4252, '2014-10-15', 2, 6, '2014-10-15 10:19:00', '0000-00-00 00:00:00'),
(8, 'KL-07 1234', '0000-00-00', '123456', '123456', 0, 0, 0, 3, 2, 1, 1, 2011, 1, 2, 2, 1, '0000-00-00', 0, 1200, '0000-00-00', 4, 14, '2014-11-26 05:33:20', '2014-11-26 06:26:46'),
(9, 'kl-7-789', '2014-10-21', '', '', 0, 0, 0, 3, 1, 4, 6, 2014, 2, 3, 2, -1, '0000-00-00', 0, 0, '0000-00-00', 4, 14, '2014-11-26 05:35:22', '0000-00-00 00:00:00'),
(10, 'Kl-01 1212', '0000-00-00', '', '', 0, 0, 0, 1, 1, 4, 4, 2004, 1, 2, 2, 2, '0000-00-00', 0, 0, '0000-00-00', 4, 14, '2014-11-26 05:38:56', '0000-00-00 00:00:00'),
(11, 'kl-7-6000', '2014-10-30', '', '', 0, 0, 0, 1, 1, 4, 8, 2014, 1, 3, 2, -1, '0000-00-00', 0, 0, '0000-00-00', 4, 14, '2014-11-26 05:57:22', '2014-11-27 05:19:20'),
(12, 'KL-07 5555', '0000-00-00', '', '', 2, 5, 6, 2, 1, 5, 3, 2012, 1, 2, 2, 2, '0000-00-00', 0, 0, '0000-00-00', 4, 14, '2014-11-26 06:10:17', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `vehicles_insurance`
--

INSERT INTO `vehicles_insurance` (`id`, `vehicle_id`, `insurance_number`, `insurance_date`, `insurance_renewal_date`, `insurance_premium_amount`, `insurance_amount`, `Insurance_agency`, `Insurance_agency_address`, `Insurance_agency_phone`, `Insurance_agency_email`, `Insurance_agency_web`) VALUES
(1, 1, '3455653322', '0000-00-00', '0000-00-00', 457, 457.65, '', '', '', '', ''),
(2, 12, '123', '2014-11-01', '2015-11-01', 5000, 800000, 'National', '', '1231231231', '', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `vehicle_ac_types`
--

INSERT INTO `vehicle_ac_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'AC', 'AC', NULL, 4, 5, '2014-09-09 06:21:20', '0000-00-00 00:00:00'),
(2, 'NonAC', 'NonAc', NULL, 4, 5, '2014-09-09 06:21:32', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `vehicle_beacon_light_options`
--

INSERT INTO `vehicle_beacon_light_options` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Red', 'Red', NULL, 4, 5, '2014-09-09 06:23:08', '0000-00-00 00:00:00'),
(2, 'Blue', 'Blue', NULL, 4, 5, '2014-09-09 06:23:16', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `vehicle_devices`
--

INSERT INTO `vehicle_devices` (`id`, `vehicle_id`, `device_id`, `from_date`, `to_date`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 1, 1, '2014-11-13', '2014-11-12', 2, 6, '2014-10-13 09:05:49', '2014-10-15 10:08:57'),
(2, 2, 2, '2014-12-16', '2014-12-15', 2, 4, '2014-10-13 09:41:19', '2014-10-15 09:11:41'),
(3, 3, 5, '2014-10-23', '9999-12-30', 1, 5, '2014-10-14 07:21:17', '0000-00-00 00:00:00'),
(4, 4, 6, '2014-10-17', '9999-12-30', 1, 5, '2014-10-14 07:32:23', '0000-00-00 00:00:00'),
(5, 5, 7, '2014-10-23', '9999-12-30', 1, 5, '2014-10-14 07:38:57', '0000-00-00 00:00:00'),
(6, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 09:11:41', '2014-10-15 10:15:45'),
(7, 6, 3, '2014-11-13', '9999-12-30', 2, 6, '2014-10-15 09:58:01', '0000-00-00 00:00:00'),
(8, 1, 1, '2014-11-13', '2014-11-12', 2, 4, '2014-10-15 10:08:57', '2014-10-16 04:08:11'),
(9, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 10:15:45', '2014-10-15 10:47:47'),
(10, 7, 10, '2014-10-15', '9999-12-30', 2, 6, '2014-10-15 10:19:00', '0000-00-00 00:00:00'),
(11, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 10:47:47', '2014-10-15 10:48:25'),
(12, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 10:48:25', '2014-10-16 04:11:00'),
(13, 1, 1, '2014-11-13', '2014-11-10', 2, 5, '2014-10-16 04:08:11', '2014-10-16 04:45:41'),
(14, 2, 2, '2014-12-16', '2014-11-13', 2, 5, '2014-10-16 04:11:00', '2014-10-16 04:12:14'),
(15, 2, 2, '2014-11-14', '2014-11-13', 2, 5, '2014-10-16 04:12:14', '2014-10-24 09:18:49'),
(16, 1, 1, '2014-11-11', '2014-11-10', 2, 4, '2014-10-16 04:45:41', '2014-10-21 07:03:29'),
(17, 1, 1, '2014-11-11', '2014-11-10', 2, 5, '2014-10-21 07:03:29', '2014-10-21 07:05:59'),
(18, 1, 1, '2014-11-11', '2014-11-10', 2, 5, '2014-10-21 07:05:59', '2014-10-21 07:12:23'),
(19, 1, 1, '2014-11-11', '2014-11-10', 2, 5, '2014-10-21 07:12:23', '2014-10-21 07:13:21'),
(20, 1, 1, '2014-11-11', '2014-11-10', 2, 5, '2014-10-21 07:13:21', '2014-10-21 08:10:54'),
(21, 1, 1, '2014-11-11', '2014-11-10', 2, 5, '2014-10-21 08:10:54', '2014-10-27 04:34:14'),
(22, 2, 2, '2014-11-14', '2014-11-13', 2, 5, '2014-10-24 09:18:49', '2014-10-24 09:19:06'),
(23, 2, 2, '2014-11-14', '9999-12-30', 2, 5, '2014-10-24 09:19:06', '0000-00-00 00:00:00'),
(24, 1, 1, '2014-11-11', '9999-12-30', 2, 5, '2014-10-27 04:34:14', '0000-00-00 00:00:00'),
(25, 8, -1, '0000-00-00', '1999-11-29', 4, 14, '2014-11-26 05:33:20', '2014-11-26 06:26:46'),
(26, 9, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 05:35:22', '0000-00-00 00:00:00'),
(27, 10, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 05:38:56', '0000-00-00 00:00:00'),
(28, 11, -1, '0000-00-00', '1999-11-29', 4, 14, '2014-11-26 05:57:22', '2014-11-27 05:14:17'),
(29, 12, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 06:10:17', '0000-00-00 00:00:00'),
(30, 8, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 06:26:46', '0000-00-00 00:00:00'),
(31, 11, -1, '0000-00-00', '1999-11-29', 4, 14, '2014-11-27 05:14:17', '2014-11-27 05:19:20'),
(32, 11, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-27 05:19:20', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `vehicle_drivers`
--

INSERT INTO `vehicle_drivers` (`id`, `vehicle_id`, `driver_id`, `from_date`, `to_date`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 1, 1, '2014-10-13', '2014-10-14', 2, 6, '2014-10-13 09:05:49', '2014-10-15 10:08:57'),
(2, 2, 2, '2014-12-16', '2014-12-15', 2, 4, '2014-10-13 09:41:19', '2014-10-15 09:11:41'),
(3, 3, 5, '2014-10-29', '9999-12-30', 1, 5, '2014-10-14 07:21:17', '0000-00-00 00:00:00'),
(4, 4, 6, '2014-10-29', '9999-12-30', 1, 5, '2014-10-14 07:32:23', '0000-00-00 00:00:00'),
(5, 5, 7, '2014-10-23', '9999-12-30', 1, 5, '2014-10-14 07:38:57', '0000-00-00 00:00:00'),
(6, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 09:11:41', '2014-10-15 10:15:45'),
(7, 6, 3, '2014-10-13', '9999-12-30', 2, 6, '2014-10-15 09:58:01', '0000-00-00 00:00:00'),
(8, 1, 1, '2014-10-15', '2014-10-14', 2, 4, '2014-10-15 10:08:57', '2014-10-16 04:08:11'),
(9, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 10:15:45', '2014-10-15 10:47:47'),
(10, 7, 4, '2014-10-15', '9999-12-30', 2, 6, '2014-10-15 10:19:00', '0000-00-00 00:00:00'),
(11, 2, 2, '2014-12-16', '2014-12-15', 2, 6, '2014-10-15 10:47:47', '2014-10-15 10:48:25'),
(12, 2, 2, '2014-12-16', '2014-11-10', 2, 6, '2014-10-15 10:48:25', '2014-10-16 04:11:00'),
(13, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-16 04:08:11', '2014-10-16 04:45:41'),
(14, 2, 2, '2014-11-11', '2014-11-10', 2, 5, '2014-10-16 04:11:00', '2014-10-16 04:12:14'),
(15, 2, 2, '2014-11-11', '2014-11-10', 2, 5, '2014-10-16 04:12:14', '2014-10-24 09:18:49'),
(16, 1, 1, '2014-10-15', '2014-10-14', 2, 4, '2014-10-16 04:45:41', '2014-10-21 07:03:29'),
(17, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-21 07:03:29', '2014-10-21 07:05:59'),
(18, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-21 07:05:59', '2014-10-21 07:12:23'),
(19, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-21 07:12:23', '2014-10-21 07:13:21'),
(20, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-21 07:13:21', '2014-10-21 08:10:54'),
(21, 1, 1, '2014-10-15', '2014-10-14', 2, 5, '2014-10-21 08:10:54', '2014-10-27 04:34:14'),
(22, 2, 51, '2014-11-11', '2014-11-10', 2, 5, '2014-10-24 09:18:49', '2014-10-24 09:19:06'),
(23, 2, 7, '2014-11-11', '9999-12-30', 2, 5, '2014-10-24 09:19:06', '0000-00-00 00:00:00'),
(24, 1, 1, '2014-10-15', '9999-12-30', 2, 5, '2014-10-27 04:34:14', '0000-00-00 00:00:00'),
(25, 8, 55, '0000-00-00', '2014-11-25', 4, 14, '2014-11-26 05:33:20', '2014-11-26 06:26:46'),
(26, 9, -1, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 05:35:22', '0000-00-00 00:00:00'),
(27, 10, 57, '0000-00-00', '9999-12-30', 4, 14, '2014-11-26 05:38:56', '0000-00-00 00:00:00'),
(28, 11, -1, '0000-00-00', '2014-11-26', 4, 14, '2014-11-26 05:57:22', '2014-11-27 05:14:17'),
(29, 12, 58, '2014-11-26', '9999-12-30', 4, 14, '2014-11-26 06:10:17', '0000-00-00 00:00:00'),
(30, 8, 55, '2014-11-26', '9999-12-30', 4, 14, '2014-11-26 06:26:46', '0000-00-00 00:00:00'),
(31, 11, 59, '2014-11-27', '2014-11-29', 4, 14, '2014-11-27 05:14:17', '2014-11-27 05:19:20'),
(32, 11, 60, '2014-11-30', '9999-12-30', 4, 14, '2014-11-27 05:19:20', '0000-00-00 00:00:00');

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
(1, '17', '17percent', NULL, 4, 5, '2014-09-09 06:24:25', '0000-00-00 00:00:00'),
(2, '20', '20percent', NULL, 4, 5, '2014-09-09 06:24:39', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `vehicle_fuel_types`
--

INSERT INTO `vehicle_fuel_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Petrol', 'Petrol', NULL, 4, 5, '2014-09-09 06:21:47', '0000-00-00 00:00:00'),
(2, 'Diesel', 'Diesel', NULL, 4, 5, '2014-09-09 06:21:59', '0000-00-00 00:00:00'),
(3, 'CNG', 'CNG', NULL, 4, 5, '2014-09-09 06:22:08', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `vehicle_loans`
--

INSERT INTO `vehicle_loans` (`id`, `vehicle_id`, `total_amount`, `number_of_emi`, `emi_amount`, `number_of_paid_emi`, `emi_payment_date`, `loan_agency`, `loan_agency_address`, `loan_agency_phone`, `loan_agency_email`, `loan_agency_web`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 3, 57643, 435353, 5335, 2, '2014-10-22', 'ICICI', 'Bombay', '0484245678', 'icici@yahoo.co', 'icici.com', 1, 5, '2014-10-14 07:28:43', '0000-00-00 00:00:00'),
(2, 4, 564473, 3465647, 46333, 2, '2014-10-22', 'ICICI', 'bombay', '0484245634', 'iciciu@yahoo.co', 'icici.com', 1, 5, '2014-10-14 07:33:52', '0000-00-00 00:00:00'),
(3, 5, 5000, 2, 46333, 1, '2014-10-25', 'ICICI', 'Bombay', '0484245458', 'icici@yaho.co', 'icici.com', 1, 5, '2014-10-14 07:40:40', '0000-00-00 00:00:00'),
(4, 2, 10, 2, 0, 1, '2014-10-29', '', '', '', '', '', 2, 5, '2014-10-21 04:59:48', '0000-00-00 00:00:00'),
(5, 12, 800000, 60, 15000, 0, '2014-12-01', '', '', '', '', '', 4, 14, '2014-11-26 06:16:34', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `vehicle_makes`
--

INSERT INTO `vehicle_makes` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'TATA', 'TATA', NULL, 4, 5, '2014-09-09 06:23:33', '2014-10-15 10:16:37'),
(2, 'Toyota', 'Toyota', NULL, 4, 5, '2014-09-09 06:23:45', '0000-00-00 00:00:00'),
(3, 'Fiat', 'Fiat', NULL, 4, 5, '2014-09-09 06:23:56', '0000-00-00 00:00:00'),
(4, 'Ford', 'Ford', NULL, 4, 4, '2014-09-25 06:06:55', '2014-10-23 05:38:55'),
(5, 'Mahindra', 'Mahindra', NULL, 4, 6, '2014-10-23 05:39:19', '0000-00-00 00:00:00'),
(6, 'Honda', 'Honda', NULL, 4, 6, '2014-10-23 05:39:36', '0000-00-00 00:00:00'),
(7, 'Mitsubishi', 'Mitsubishi', NULL, 4, 6, '2014-10-23 05:58:15', '0000-00-00 00:00:00'),
(8, 'Volkswagen', 'Volkswagen', NULL, 4, 6, '2014-10-23 05:58:53', '0000-00-00 00:00:00'),
(9, 'Benz', 'Benz', NULL, 4, 6, '2014-10-23 05:59:13', '0000-00-00 00:00:00'),
(10, 'Chevrolet', 'Chevrolet', NULL, 4, 6, '2014-10-23 06:00:21', '0000-00-00 00:00:00'),
(11, 'Nissan', 'Nissan', NULL, 4, 6, '2014-10-27 08:29:26', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `vehicle_models`
--

INSERT INTO `vehicle_models` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Indica D', 'Tata', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(2, 'Indiago D', 'Tata', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(3, 'Logan D', 'Mahindra', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(4, 'Ikon D', 'Ford', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(5, 'Lancer D', 'Mistubushi', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(6, 'Fiesta D', 'Ford', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(7, 'City', 'Honda', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(8, 'Corolla', 'Tayota', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(9, 'Corolla Altis', 'Tayota', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(10, 'Jetta D', 'Volkswagan', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(11, 'Benz E Class', 'Benz', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(12, 'Tavera D', 'Cheverlot', NULL, 4, 6, '2014-10-13 08:59:54', '0000-00-00 00:00:00'),
(13, 'Xylo D', 'Mahindra', NULL, 4, 6, '2014-10-15 05:34:55', '0000-00-00 00:00:00'),
(14, 'Innova D', 'Tayota', NULL, 4, 6, '2014-10-15 05:34:55', '0000-00-00 00:00:00'),
(15, 'Safari', 'Tata', NULL, 4, 6, '2014-10-15 05:34:55', '0000-00-00 00:00:00'),
(16, 'Sunny', 'Sunny', NULL, 4, 6, '2014-10-27 08:29:38', '0000-00-00 00:00:00');

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
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `vehicle_owners`
--

INSERT INTO `vehicle_owners` (`id`, `vehicle_id`, `name`, `address`, `mobile`, `email`, `dob`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 2, 'Deril V S', 'Deril V S\nErnakulam', '9845345654', 'deril@gmail.com', '1980-10-04', 2, 4, '2014-10-13 09:42:16', '0000-00-00 00:00:00'),
(2, 5, 'Hari PS', 'Cochin', '9876567654', 'hari@gmail.com', '1989-06-19', 1, 5, '2014-10-14 07:45:49', '0000-00-00 00:00:00'),
(3, 1, 'Sunny Thomas', 'Sunny Thomas,\n House, Street,\n District.', '8089251012', 'info@acube.co', '2014-10-13', 2, 5, '2014-10-15 09:10:45', '2014-10-27 04:34:55'),
(4, 6, 'Nisith Ram', 'House, Street, District.', '9946109574', 'info@acube.co', '2014-10-15', 2, 6, '2014-10-15 09:58:25', '0000-00-00 00:00:00'),
(5, 7, 'Mary Varghese', 'House no, Plot, District.', '8089254512', 'info@acube.co', '2014-10-15', 2, 6, '2014-10-15 10:19:44', '0000-00-00 00:00:00'),
(6, 12, 'Sajid', '', '1478523698', '', '0000-00-00', 4, 14, '2014-11-26 06:17:13', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `vehicle_ownership_types`
--

INSERT INTO `vehicle_ownership_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Owned', 'Owned', NULL, 4, 5, '2014-09-09 06:19:29', '0000-00-00 00:00:00'),
(2, 'Rented', 'Rented', NULL, 4, 5, '2014-09-09 06:19:45', '0000-00-00 00:00:00'),
(3, 'Attached', 'Attached', NULL, 4, 5, '2014-09-09 06:20:04', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vehicle_permit_types`
--

INSERT INTO `vehicle_permit_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'All Kerala', 'All Kerala', NULL, 4, 6, '2014-09-09 06:26:11', '0000-00-00 00:00:00'),
(2, 'All India', 'All India', NULL, 4, 6, '2014-09-09 06:26:25', '0000-00-00 00:00:00'),
(3, 'Only Kerala ', 'Only Kerala', NULL, 4, 6, '2014-10-15 06:10:31', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `vehicle_seating_capacity`
--

INSERT INTO `vehicle_seating_capacity` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, '4', '4seated', NULL, 4, 5, '2014-09-09 06:22:33', '0000-00-00 00:00:00'),
(2, '5', '5seated', NULL, 4, 5, '2014-09-09 06:22:44', '0000-00-00 00:00:00'),
(3, '6', '6seated', NULL, 4, 5, '2014-09-09 06:22:55', '0000-00-00 00:00:00'),
(4, '7', '7seated', NULL, 4, 5, '2014-10-15 06:07:37', '0000-00-00 00:00:00'),
(5, '8', '8sested', NULL, 4, 5, '2014-10-15 06:07:37', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `vehicle_types`
--

INSERT INTO `vehicle_types` (`id`, `name`, `description`, `value`, `organisation_id`, `user_id`, `created`, `updated`) VALUES
(1, 'Sedan', 'Sedan', NULL, 4, 5, '2014-09-09 06:20:26', '0000-00-00 00:00:00'),
(2, 'Hatchback', 'Hatchback', NULL, 4, 5, '2014-09-09 06:20:43', '0000-00-00 00:00:00'),
(3, 'SUV', 'SUV', NULL, 4, 5, '2014-09-09 06:20:55', '0000-00-00 00:00:00'),
(4, 'Traveler', 'Traveler', NULL, 4, 5, '2014-09-09 06:21:06', '0000-00-00 00:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
