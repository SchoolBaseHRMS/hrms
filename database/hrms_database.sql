/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - mock
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mock` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `mock`;

/*Table structure for table `calm_audit_reports` */

DROP TABLE IF EXISTS `calm_audit_reports`;

CREATE TABLE `calm_audit_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `audit_id` int(11) NOT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `audit_id` (`audit_id`),
  CONSTRAINT `calm_audit_reports_ibfk_1` FOREIGN KEY (`audit_id`) REFERENCES `calm_audits` (`audit_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_audit_reports` */

/*Table structure for table `calm_audits` */

DROP TABLE IF EXISTS `calm_audits`;

CREATE TABLE `calm_audits` (
  `audit_id` int(11) NOT NULL AUTO_INCREMENT,
  `audit_title` varchar(255) NOT NULL,
  `audit_type` enum('Internal','External') DEFAULT NULL,
  `audit_date` date DEFAULT NULL,
  `auditor_name` varchar(100) DEFAULT NULL,
  `findings` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `status` enum('Open','In Progress','Closed') DEFAULT 'Open',
  `related_risk` int(11) DEFAULT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `related_risk` (`related_risk`),
  CONSTRAINT `calm_audits_ibfk_1` FOREIGN KEY (`related_risk`) REFERENCES `calm_risk_assessments` (`risk_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_audits` */

/*Table structure for table `calm_incident_reports` */

DROP TABLE IF EXISTS `calm_incident_reports`;

CREATE TABLE `calm_incident_reports` (
  `incident_id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_type` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `date_reported` date NOT NULL,
  `reported_by` varchar(100) DEFAULT NULL,
  `severity` enum('Low','Medium','High','Critical') NOT NULL,
  `status` enum('Open','In Progress','Resolved','Closed') DEFAULT 'Open',
  `resolution_notes` text DEFAULT NULL,
  `related_policy` int(11) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `related_policy` (`related_policy`),
  CONSTRAINT `calm_incident_reports_ibfk_1` FOREIGN KEY (`related_policy`) REFERENCES `calm_policy_documents` (`policy_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_incident_reports` */

/*Table structure for table `calm_labor_law_compliance` */

DROP TABLE IF EXISTS `calm_labor_law_compliance`;

CREATE TABLE `calm_labor_law_compliance` (
  `compliance_id` int(11) NOT NULL AUTO_INCREMENT,
  `law_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `compliance_status` enum('Compliant','Non-Compliant','Pending') DEFAULT 'Pending',
  `last_review_date` date DEFAULT NULL,
  `responsible_person` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`compliance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_labor_law_compliance` */

/*Table structure for table `calm_policy_documents` */

DROP TABLE IF EXISTS `calm_policy_documents`;

CREATE TABLE `calm_policy_documents` (
  `policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `uploaded_by` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `status` enum('Active','Archived') DEFAULT 'Active',
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_policy_documents` */

/*Table structure for table `calm_risk_assessments` */

DROP TABLE IF EXISTS `calm_risk_assessments`;

CREATE TABLE `calm_risk_assessments` (
  `risk_id` int(11) NOT NULL AUTO_INCREMENT,
  `risk_area` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `likelihood` enum('Low','Medium','High') NOT NULL,
  `impact` enum('Low','Medium','High','Critical') NOT NULL,
  `mitigation_plan` text DEFAULT NULL,
  `assessed_by` varchar(100) DEFAULT NULL,
  `assessment_date` date DEFAULT NULL,
  `related_incident` int(11) DEFAULT NULL,
  PRIMARY KEY (`risk_id`),
  KEY `related_incident` (`related_incident`),
  CONSTRAINT `calm_risk_assessments_ibfk_1` FOREIGN KEY (`related_incident`) REFERENCES `calm_incident_reports` (`incident_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `calm_risk_assessments` */

/*Table structure for table `ee_announcements` */

DROP TABLE IF EXISTS `ee_announcements`;

CREATE TABLE `ee_announcements` (
  `announcement_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`announcement_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `ee_announcements_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_announcements` */

/*Table structure for table `ee_attachments` */

DROP TABLE IF EXISTS `ee_attachments`;

CREATE TABLE `ee_attachments` (
  `attachment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`attachment_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `ee_attachments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `ee_posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_attachments` */

/*Table structure for table `ee_event_rsvps` */

DROP TABLE IF EXISTS `ee_event_rsvps`;

CREATE TABLE `ee_event_rsvps` (
  `rsvp_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `employee_id` bigint(20) unsigned NOT NULL,
  `response` enum('yes','no','maybe') DEFAULT 'yes',
  `responded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`rsvp_id`),
  KEY `event_id` (`event_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ee_event_rsvps_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `ee_events` (`event_id`),
  CONSTRAINT `ee_event_rsvps_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_event_rsvps` */

/*Table structure for table `ee_events` */

DROP TABLE IF EXISTS `ee_events`;

CREATE TABLE `ee_events` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`event_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `ee_events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_events` */

/*Table structure for table `ee_grievance_notes` */

DROP TABLE IF EXISTS `ee_grievance_notes`;

CREATE TABLE `ee_grievance_notes` (
  `note_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `grievance_id` bigint(20) unsigned NOT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `note_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`note_id`),
  KEY `grievance_id` (`grievance_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `ee_grievance_notes_ibfk_1` FOREIGN KEY (`grievance_id`) REFERENCES `ee_grievances` (`grievance_id`),
  CONSTRAINT `ee_grievance_notes_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_grievance_notes` */

/*Table structure for table `ee_grievances` */

DROP TABLE IF EXISTS `ee_grievances`;

CREATE TABLE `ee_grievances` (
  `grievance_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text NOT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `status` enum('open','in_review','resolved') DEFAULT 'open',
  `assigned_to` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`grievance_id`),
  KEY `employee_id` (`employee_id`),
  KEY `assigned_to` (`assigned_to`),
  CONSTRAINT `ee_grievances_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`),
  CONSTRAINT `ee_grievances_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_grievances` */

/*Table structure for table `ee_group_members` */

DROP TABLE IF EXISTS `ee_group_members`;

CREATE TABLE `ee_group_members` (
  `membership_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `employee_id` bigint(20) unsigned NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`membership_id`),
  KEY `group_id` (`group_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ee_group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `ee_groups` (`group_id`),
  CONSTRAINT `ee_group_members_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_group_members` */

/*Table structure for table `ee_groups` */

DROP TABLE IF EXISTS `ee_groups`;

CREATE TABLE `ee_groups` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`group_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `ee_groups_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_groups` */

/*Table structure for table `ee_messages` */

DROP TABLE IF EXISTS `ee_messages`;

CREATE TABLE `ee_messages` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `ee_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `em_employees` (`employee_id`),
  CONSTRAINT `ee_messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_messages` */

/*Table structure for table `ee_post_comments` */

DROP TABLE IF EXISTS `ee_post_comments`;

CREATE TABLE `ee_post_comments` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `comment_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`comment_id`),
  KEY `post_id` (`post_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `ee_post_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `ee_posts` (`post_id`),
  CONSTRAINT `ee_post_comments_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_post_comments` */

/*Table structure for table `ee_posts` */

DROP TABLE IF EXISTS `ee_posts`;

CREATE TABLE `ee_posts` (
  `post_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`post_id`),
  KEY `group_id` (`group_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `ee_posts_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `ee_groups` (`group_id`),
  CONSTRAINT `ee_posts_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_posts` */

/*Table structure for table `ee_recognitions` */

DROP TABLE IF EXISTS `ee_recognitions`;

CREATE TABLE `ee_recognitions` (
  `recognition_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `giver_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned NOT NULL,
  `message` text DEFAULT NULL,
  `badge` varchar(100) DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recognition_id`),
  KEY `giver_id` (`giver_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `ee_recognitions_ibfk_1` FOREIGN KEY (`giver_id`) REFERENCES `em_employees` (`employee_id`),
  CONSTRAINT `ee_recognitions_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_recognitions` */

/*Table structure for table `ee_reward_redemptions` */

DROP TABLE IF EXISTS `ee_reward_redemptions`;

CREATE TABLE `ee_reward_redemptions` (
  `redemption_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) unsigned NOT NULL,
  `reward_id` bigint(20) unsigned NOT NULL,
  `redeemed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`redemption_id`),
  KEY `employee_id` (`employee_id`),
  KEY `reward_id` (`reward_id`),
  CONSTRAINT `ee_reward_redemptions_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`),
  CONSTRAINT `ee_reward_redemptions_ibfk_2` FOREIGN KEY (`reward_id`) REFERENCES `ee_rewards` (`reward_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_reward_redemptions` */

/*Table structure for table `ee_rewards` */

DROP TABLE IF EXISTS `ee_rewards`;

CREATE TABLE `ee_rewards` (
  `reward_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `points_required` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reward_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_rewards` */

/*Table structure for table `ee_survey_options` */

DROP TABLE IF EXISTS `ee_survey_options`;

CREATE TABLE `ee_survey_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `option_text` varchar(255) NOT NULL,
  PRIMARY KEY (`option_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `ee_survey_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `ee_survey_questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_survey_options` */

/*Table structure for table `ee_survey_questions` */

DROP TABLE IF EXISTS `ee_survey_questions`;

CREATE TABLE `ee_survey_questions` (
  `question_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) unsigned NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('multiple_choice','rating','text') NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `ee_survey_questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `ee_surveys` (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_survey_questions` */

/*Table structure for table `ee_survey_responses` */

DROP TABLE IF EXISTS `ee_survey_responses`;

CREATE TABLE `ee_survey_responses` (
  `response_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) unsigned NOT NULL,
  `question_id` bigint(20) unsigned NOT NULL,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `response_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`response_id`),
  KEY `survey_id` (`survey_id`),
  KEY `question_id` (`question_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ee_survey_responses_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `ee_surveys` (`survey_id`),
  CONSTRAINT `ee_survey_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `ee_survey_questions` (`question_id`),
  CONSTRAINT `ee_survey_responses_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_survey_responses` */

/*Table structure for table `ee_surveys` */

DROP TABLE IF EXISTS `ee_surveys`;

CREATE TABLE `ee_surveys` (
  `survey_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `scheduled_date` date DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`survey_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `ee_surveys_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `em_employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ee_surveys` */

/*Table structure for table `em_admin` */

DROP TABLE IF EXISTS `em_admin`;

CREATE TABLE `em_admin` (
  `id` int(20) NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle` varchar(20) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` enum('STAFF','FACULTY','LIABILITIES') NOT NULL DEFAULT 'STAFF',
  `status` varchar(20) DEFAULT NULL,
  `date_hired` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_admin` */

insert  into `em_admin`(`id`,`last_name`,`first_name`,`middle`,`position`,`department`,`status`,`date_hired`) values 
(1001,'Santos','Maria','Lopez','Teacher I','FACULTY','Active','2022-06-15'),
(1002,'Reyes','Juan','Cruz','HR Assistant','STAFF','Active','2021-03-01'),
(1003,'Garcia','Ana','Torres','Accountant','LIABILITIES','Active','2019-09-10'),
(1004,'Dela Cruz','Pedro','Mendoza','IT Specialist','STAFF','Active','2020-11-20'),
(1005,'Villanueva','Sofia','Ramos','Guidance Counselor','FACULTY','Active','2023-01-05'),
(1006,'Mendoza','Carlos','Bautista','Maintenance Staff','STAFF','Active','2018-05-12'),
(1007,'Torres','Isabella','Flores','School Nurse','LIABILITIES','Active','2017-02-18'),
(1008,'Ramos','Miguel','Domingo','Librarian','FACULTY','Active','2021-08-25'),
(1009,'Aquino','Elena','Castro','Registrar','STAFF','Active','2019-04-14'),
(1010,'Fernandez','Luis','Santos','Finance Officer','LIABILITIES','Active','2020-09-01');

/*Table structure for table `em_document_management` */

DROP TABLE IF EXISTS `em_document_management`;

CREATE TABLE `em_document_management` (
  `document_id` int(11) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `educational_attainment` varchar(250) DEFAULT NULL,
  `certificate_type` varchar(250) DEFAULT NULL,
  `training` varchar(250) DEFAULT NULL,
  `license_no` varchar(50) DEFAULT NULL,
  `sss` varchar(50) DEFAULT NULL,
  `pag_ibig` varchar(50) DEFAULT NULL,
  `philhealth` varchar(50) DEFAULT NULL,
  `nbi_clearance` varchar(50) DEFAULT NULL,
  `police_clearance` varchar(50) DEFAULT NULL,
  `baranggay_clearance` varchar(250) DEFAULT NULL,
  `date_uploaded` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_document_management` */

insert  into `em_document_management`(`document_id`,`id`,`educational_attainment`,`certificate_type`,`training`,`license_no`,`sss`,`pag_ibig`,`philhealth`,`nbi_clearance`,`police_clearance`,`baranggay_clearance`,`date_uploaded`) values 
(1,1001,'Bachelor of Education','Teaching Certificate','Child Development Training','LIC123456','SSS12345','PAGIBIG12345','PHIL12345','NBI001','POL001','BRGY001','2022-07-01'),
(2,1002,'BS in Psychology','HR Management Cert','Workplace Compliance Training','LIC223344','SSS54321','PAGIBIG54321','PHIL54321','NBI002','POL002','BRGY002','2021-03-05'),
(3,1003,'BS in Accountancy','CPA License','Taxation Workshop','CPA67890','SSS67890','PAGIBIG67890','PHIL67890','NBI003','POL003','BRGY003','2019-10-15'),
(4,1004,'BS in Information Technology','IT Specialist Cert','Cybersecurity Training','IT445566','SSS11223','PAGIBIG11223','PHIL11223','NBI004','POL004','BRGY004','2020-12-01'),
(5,1005,'MA in Psychology','Guidance License','Mental Health Workshop','GUID99887','SSS33445','PAGIBIG33445','PHIL33445','NBI005','POL005','BRGY005','2023-02-01'),
(6,1006,'High School Graduate','Maintenance Cert','Safety Training','MAINT2233','SSS55667','PAGIBIG55667','PHIL55667','NBI006','POL006','BRGY006','2018-06-01'),
(7,1007,'BS in Nursing','Nurse License','First Aid Training','NUR445566','SSS77889','PAGIBIG77889','PHIL77889','NBI007','POL007','BRGY007','2017-03-01'),
(8,1008,'BS in Library Science','Librarian Cert','Digital Archiving Workshop','LIB112233','SSS99001','PAGIBIG99001','PHIL99001','NBI008','POL008','BRGY008','2021-09-01'),
(9,1009,'BS in Business Administration','Registrar Cert','Records Management Training','REG778899','SSS22334','PAGIBIG22334','PHIL22334','NBI009','POL009','BRGY009','2019-05-01'),
(10,1010,'BS in Finance','CPA Equivalent','Budget Management Training','FIN667788','SSS44556','PAGIBIG44556','PHIL44556','NBI010','POL010','BRGY010','2020-10-01'),
(11,1011,'PhD in Mathematics','Board Exam Cert','Research Workshop','LIC1011','SSS1011','PAGIBIG1011','PHIL1011','NBI011','POL011','BRGY011','2021-09-01'),
(12,1012,'MA in English','Teaching Certificate','TESOL Training','LIC1012','SSS1012','PAGIBIG1012','PHIL1012','NBI012','POL012','BRGY012','2020-07-01'),
(13,1013,'BS in Physics','Instructor License','Science Lab Safety','LIC1013','SSS1013','PAGIBIG1013','PHIL1013','NBI013','POL013','BRGY013','2019-10-20'),
(14,1014,'PhD in History','Faculty Cert','Archaeology Seminar','LIC1014','SSS1014','PAGIBIG1014','PHIL1014','NBI014','POL014','BRGY014','2022-03-01'),
(15,1015,'MA in Economics','Teaching License','Business Forum Training','LIC1015','SSS1015','PAGIBIG1015','PHIL1015','NBI015','POL015','BRGY015','2018-06-01'),
(16,1016,'BS in Political Science','Instructor Certificate','Public Speaking Workshop','LIC1016','SSS1016','PAGIBIG1016','PHIL1016','NBI016','POL016','BRGY016','2021-04-01'),
(17,1017,'PhD in Computer Science','Professor License','AI & Data Science Training','LIC1017','SSS1017','PAGIBIG1017','PHIL1017','NBI017','POL017','BRGY017','2017-12-01'),
(18,1018,'MA in Fine Arts','Instructor Cert','Creative Arts Workshop','LIC1018','SSS1018','PAGIBIG1018','PHIL1018','NBI018','POL018','BRGY018','2019-05-01'),
(19,1019,'BS in Philosophy','Teaching Certificate','Ethics Seminar','LIC1019','SSS1019','PAGIBIG1019','PHIL1019','NBI019','POL019','BRGY019','2020-11-01'),
(20,1020,'PhD in Biology','Board License','Biotech Training','LIC1020','SSS1020','PAGIBIG1020','PHIL1020','NBI020','POL020','BRGY020','2016-02-01'),
(21,1021,'High School Graduate','TESDA Certificate','Safety Training','LIC1021','SSS1021','PAGIBIG1021','PHIL1021','NBI1021','POLICE1021','BRGY1021','2021-01-16'),
(22,1022,'College Undergraduate','Janitorial NCII','Housekeeping','LIC1022','SSS1022','PAGIBIG1022','PHIL1022','NBI1022','POLICE1022','BRGY1022','2020-11-11'),
(23,1023,'High School Graduate','Security License','Security Training','LIC1023','SSS1023','PAGIBIG1023','PHIL1023','NBI1023','POLICE1023','BRGY1023','2019-05-21'),
(24,1024,'Vocational Course','Food Handling Cert','Kitchen Safety','LIC1024','SSS1024','PAGIBIG1024','PHIL1024','NBI1024','POLICE1024','BRGY1024','2018-03-12'),
(25,1025,'Vocational Course','TESDA Certificate','Electrical Safety','LIC1025','SSS1025','PAGIBIG1025','PHIL1025','NBI1025','POLICE1025','BRGY1025','2022-07-02'),
(26,1026,'High School Graduate','Driver License','Defensive Driving','LIC1026','SSS1026','PAGIBIG1026','PHIL1026','NBI1026','POLICE1026','BRGY1026','2017-08-26'),
(27,1027,'Vocational Course','TESDA Certificate','Plumbing Training','LIC1027','SSS1027','PAGIBIG1027','PHIL1027','NBI1027','POLICE1027','BRGY1027','2016-12-03'),
(28,1028,'High School Graduate','TESDA Cert','Groundskeeping','LIC1028','SSS1028','PAGIBIG1028','PHIL1028','NBI1028','POLICE1028','BRGY1028','2021-09-14'),
(29,1029,'High School Graduate','Messenger Training','Clerical Skills','LIC1029','SSS1029','PAGIBIG1029','PHIL1029','NBI1029','POLICE1029','BRGY1029','2020-04-20'),
(30,1030,'College Undergraduate','Office Clerk Cert','Admin Training','LIC1030','SSS1030','PAGIBIG1030','PHIL1030','NBI1030','POLICE1030','BRGY1030','2019-07-01');

/*Table structure for table `em_employee_history` */

DROP TABLE IF EXISTS `em_employee_history`;

CREATE TABLE `em_employee_history` (
  `history_id` int(20) NOT NULL,
  `id` int(20) DEFAULT NULL,
  `company_name` varchar(250) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` enum('STAFF','FACULTY','LIABILITIES') NOT NULL DEFAULT 'STAFF',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `reason_for_leaving` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_employee_history` */

insert  into `em_employee_history`(`history_id`,`id`,`company_name`,`position`,`department`,`start_date`,`end_date`,`reason_for_leaving`) values 
(1,1001,'ABC Academy','Assistant Teacher','FACULTY','2020-01-01','2022-05-30','Career Growth'),
(2,1002,'XYZ Corp','Recruitment Officer','STAFF','2018-02-01','2021-02-15','Better Opportunity'),
(3,1003,'DEF Finance','Junior Accountant','LIABILITIES','2015-08-01','2019-08-31','Company Downsizing'),
(4,1004,'TechWorld Inc.','IT Support','STAFF','2017-01-01','2020-10-31','Relocation'),
(5,1005,'MindCare Org','Assistant Counselor','FACULTY','2021-01-01','2022-12-31','Promotion'),
(6,1006,'BuildPro Services','Janitor','STAFF','2015-01-01','2018-04-30','Contract Ended'),
(7,1007,'HealthPlus Clinic','Nurse Intern','LIABILITIES','2016-01-01','2017-01-31','Further Studies'),
(8,1008,'BookWorld Library','Assistant Librarian','FACULTY','2019-01-01','2021-07-31','Better Offer'),
(9,1009,'City Hall Records','Records Clerk','STAFF','2016-05-01','2019-03-31','Career Growth'),
(10,1010,'FinanceCorp','Junior Analyst','LIABILITIES','2017-01-01','2020-08-31','Career Advancement'),
(11,1011,'Metro University','Lecturer','FACULTY','2015-01-01','2021-07-31','Promotion'),
(12,1012,'Language Center','Instructor','FACULTY','2017-02-01','2020-05-31','Career Growth'),
(13,1013,'Science Institute','Lab Instructor','FACULTY','2016-01-01','2019-08-31','Relocation'),
(14,1014,'History Academy','History Teacher','FACULTY','2018-01-01','2022-01-31','Promotion'),
(15,1015,'Business School','Economics Lecturer','FACULTY','2010-01-01','2018-04-30','Retirement from old post'),
(16,1016,'Civic College','PolSci Instructor','FACULTY','2018-01-01','2021-02-28','Better Offer'),
(17,1017,'Tech Institute','IT Professor','FACULTY','2012-06-01','2017-10-31','Transfer to University'),
(18,1018,'Arts Academy','Art Instructor','FACULTY','2015-03-01','2019-03-31','Pursued MA Degree'),
(19,1019,'Philosophy Institute','Instructor','FACULTY','2016-09-01','2020-09-30','Research Fellowship'),
(20,1020,'BioLab Research','Research Assistant','FACULTY','2012-01-01','2016-12-31','Academic Promotion'),
(21,1021,'Clean & Green Services','Janitor','STAFF','2018-01-10','2020-12-31','Contract Ended'),
(22,1022,'Metro Janitorial','Janitor','STAFF','2017-03-01','2020-10-30','Better Opportunity'),
(23,1023,'Secure Guards Inc.','Security Guard','STAFF','2016-04-15','2019-05-19','Relocation'),
(24,1024,'Food Express','Kitchen Helper','STAFF','2015-02-20','2018-03-10','Career Shift'),
(25,1025,'Power Builders','Electrician','STAFF','2019-05-01','2022-06-30','Career Growth'),
(26,1026,'Safe Transport','Driver','STAFF','2015-07-01','2017-08-24','Finished Contract'),
(27,1027,'Pipe Masters','Plumber','STAFF','2014-01-12','2016-12-01','Company Closure'),
(28,1028,'City Gardeners','Groundskeeper','STAFF','2019-01-01','2021-09-12','Project Completion'),
(29,1029,'Courier Express','Messenger','STAFF','2017-03-10','2020-04-18','Better Pay'),
(30,1030,'Office Works Inc.','Clerk','STAFF','2016-05-01','2019-06-29','Pursue New Job');

/*Table structure for table `em_employees` */

DROP TABLE IF EXISTS `em_employees`;

CREATE TABLE `em_employees` (
  `employee_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_number` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `employee_number` (`employee_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_employees` */

/*Table structure for table `em_faculty_dep` */

DROP TABLE IF EXISTS `em_faculty_dep`;

CREATE TABLE `em_faculty_dep` (
  `id` int(20) NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle` varchar(20) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` enum('STAFF','FACULTY','LIABILITIES') NOT NULL DEFAULT 'STAFF',
  `status` varchar(50) DEFAULT NULL,
  `date_hired` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_faculty_dep` */

insert  into `em_faculty_dep`(`id`,`last_name`,`first_name`,`middle`,`position`,`department`,`status`,`date_hired`) values 
(1011,'Cruz','Alberto','Reyes','Professor I','FACULTY','Active','2021-08-01'),
(1012,'Morales','Beatriz','Santos','Associate Professor','FACULTY','Active','2020-06-15'),
(1013,'Domingo','Carmen','Lopez','Instructor II','FACULTY','Active','2019-09-10'),
(1014,'Navarro','Daniel','Torres','Assistant Professor','FACULTY','Active','2022-02-20'),
(1015,'Estrada','Felipe','Garcia','Professor II','FACULTY','Active','2018-05-12'),
(1016,'Jimenez','Gabriela','Castro','Instructor I','FACULTY','Active','2021-03-10'),
(1017,'Lopez','Hector','Mendoza','Professor III','FACULTY','Active','2017-11-05'),
(1018,'Santiago','Isabel','Domingo','Assistant Professor II','FACULTY','Active','2019-04-18'),
(1019,'Roxas','Javier','Aquino','Instructor III','FACULTY','Active','2020-10-25'),
(1020,'Velasquez','Katrina','Fernandez','Professor I','FACULTY','Active','2016-01-15');

/*Table structure for table `em_personal_info` */

DROP TABLE IF EXISTS `em_personal_info`;

CREATE TABLE `em_personal_info` (
  `personal_id` int(11) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `civil_status` varchar(10) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `emergency_name` varchar(20) DEFAULT NULL,
  `emergency_contact` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_personal_info` */

insert  into `em_personal_info`(`personal_id`,`id`,`date_of_birth`,`gender`,`civil_status`,`contact_number`,`email`,`address`,`emergency_name`,`emergency_contact`) values 
(1,1001,'1995-04-20','Female','Single','09171234567','maria.santos@example.com','Quezon City, Metro Manila','Lopez, Jose','09181112222'),
(2,1002,'1990-11-12','Male','Married','09179876543','juan.reyes@example.com','Makati City, Metro Manila','Cruz, Ana','09182223333'),
(3,1003,'1985-07-05','Female','Single','09175554444','ana.garcia@example.com','Cebu City, Cebu','Torres, Luis','09183334444'),
(4,1004,'1992-02-10','Male','Single','09179998888','pedro.delacruz@example.com','Pasig City, Metro Manila','Mendoza, Carla','09184445555'),
(5,1005,'1996-09-08','Female','Married','09172223333','sofia.villanueva@example.com','Davao City, Davao del Sur','Ramos, Pedro','09185556666'),
(6,1006,'1988-06-18','Male','Married','09173334444','carlos.mendoza@example.com','Baguio City, Benguet','Bautista, Maria','09186667777'),
(7,1007,'1993-12-25','Female','Single','09174445555','isabella.torres@example.com','Iloilo City, Iloilo','Flores, Juan','09187778888'),
(8,1008,'1991-01-14','Male','Single','09175556666','miguel.ramos@example.com','Taguig City, Metro Manila','Domingo, Clara','09188889999'),
(9,1009,'1987-05-30','Female','Married','09176667777','elena.aquino@example.com','Cavite City, Cavite','Castro, Miguel','09189990000'),
(10,1010,'1989-03-22','Male','Married','09177778888','luis.fernandez@example.com','Manila City, Metro Manila','Santos, Andrea','09180001111'),
(11,1011,'1980-03-15','Male','Married','09170001111','alberto.cruz@example.com','Quezon City, Metro Manila','Reyes, Maria','09181112222'),
(12,1012,'1985-07-25','Female','Single','09172223333','beatriz.morales@example.com','Makati City, Metro Manila','Santos, Juan','09182223333'),
(13,1013,'1990-01-10','Female','Married','09173334444','carmen.domingo@example.com','Cebu City, Cebu','Lopez, Ana','09183334444'),
(14,1014,'1988-11-05','Male','Single','09174445555','daniel.navarro@example.com','Pasig City, Metro Manila','Torres, Luis','09184445555'),
(15,1015,'1975-09-18','Male','Married','09175556666','felipe.estrada@example.com','Davao City, Davao del Sur','Garcia, Elena','09185556666'),
(16,1016,'1992-06-22','Female','Single','09176667777','gabriela.jimenez@example.com','Bacolod City, Negros Occidental','Castro, Miguel','09186667777'),
(17,1017,'1978-09-30','Male','Married','09177778888','hector.lopez@example.com','Taguig City, Metro Manila','Mendoza, Clara','09187778888'),
(18,1018,'1987-12-12','Female','Single','09178889999','isabel.santiago@example.com','Iloilo City, Iloilo','Domingo, Rafael','09188889999'),
(19,1019,'1991-04-05','Male','Married','09179990000','javier.roxas@example.com','Cavite City, Cavite','Aquino, Liza','09189990000'),
(20,1020,'1983-08-28','Female','Married','09180001111','katrina.velasquez@example.com','Manila City, Metro Manila','Fernandez, Luis','09180001112'),
(21,1021,'1990-05-10','Male','Single','09171234501','juan.villanueva@example.com','Quezon City','Pedro Villanueva','09181234501'),
(22,1022,'1988-07-22','Female','Married','09171234502','maria.santos@example.com','Manila','Ana Santos','09181234502'),
(23,1023,'1985-01-30','Male','Married','09171234503','carlos.reyes@example.com','Caloocan','Luis Reyes','09181234503'),
(24,1024,'1992-11-18','Female','Single','09171234504','ana.lopez@example.com','Makati','Jose Lopez','09181234504'),
(25,1025,'1987-02-15','Male','Married','09171234505','pedro.garcia@example.com','Pasig','Mario Garcia','09181234505'),
(26,1026,'1991-09-05','Female','Single','09171234506','luisa.cruz@example.com','Taguig','Juan Cruz','09181234506'),
(27,1027,'1984-06-12','Male','Married','09171234507','ramon.torres@example.com','Laguna','Jose Torres','09181234507'),
(28,1028,'1993-12-21','Female','Single','09171234508','josefina.mendoza@example.com','Bulacan','Maria Mendoza','09181234508'),
(29,1029,'1989-03-25','Male','Single','09171234509','francisco.aquino@example.com','Batangas','Ana Aquino','09181234509'),
(30,1030,'1990-10-14','Female','Married','09171234510','elena.domingo@example.com','Rizal','Carmen Domingo','09181234510');

/*Table structure for table `em_support_operation_dep` */

DROP TABLE IF EXISTS `em_support_operation_dep`;

CREATE TABLE `em_support_operation_dep` (
  `id` int(20) NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle` varchar(20) NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` enum('STAFF','FACULTY','LIABILITIES') NOT NULL DEFAULT 'STAFF',
  `status` varchar(20) DEFAULT NULL,
  `date_hired` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `em_support_operation_dep` */

insert  into `em_support_operation_dep`(`id`,`last_name`,`first_name`,`middle`,`position`,`department`,`status`,`date_hired`) values 
(1021,'Villanueva','Juan','C','Maintenance Staff','STAFF','Active','2021-01-15'),
(1022,'Santos','Maria','D','Janitorial Staff','STAFF','Active','2020-11-10'),
(1023,'Reyes','Carlos','B','Security Guard','STAFF','Active','2019-05-20'),
(1024,'Lopez','Ana','E','Cafeteria Helper','STAFF','Active','2018-03-11'),
(1025,'Garcia','Pedro','F','Electrician','STAFF','Active','2022-07-01'),
(1026,'Cruz','Luisa','G','Driver','STAFF','Active','2017-08-25'),
(1027,'Torres','Ramon','H','Plumber','STAFF','Active','2016-12-02'),
(1028,'Mendoza','Josefina','I','Groundskeeper','STAFF','Active','2021-09-13'),
(1029,'Aquino','Francisco','J','Messenger','STAFF','Active','2020-04-19'),
(1030,'Domingo','Elena','K','Clerk','STAFF','Active','2019-06-30');

/*Table structure for table `lad_certifications` */

DROP TABLE IF EXISTS `lad_certifications`;

CREATE TABLE `lad_certifications` (
  `certification_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `certificate_name` varchar(150) NOT NULL,
  `issued_date` date DEFAULT curdate(),
  `expiry_date` date DEFAULT NULL,
  `status` varchar(30) DEFAULT 'Valid',
  PRIMARY KEY (`certification_id`),
  KEY `employee_id` (`employee_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `lad_certifications_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE,
  CONSTRAINT `lad_certifications_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `lad_elearning` (`course_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `lad_certifications` */

/*Table structure for table `lad_course_enrollment` */

DROP TABLE IF EXISTS `lad_course_enrollment`;

CREATE TABLE `lad_course_enrollment` (
  `enrollment_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `training_id` int(11) NOT NULL,
  `enrolled_on` date DEFAULT curdate(),
  `completion_status` varchar(30) DEFAULT 'Enrolled',
  `feedback` text DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  KEY `employee_id` (`employee_id`),
  KEY `training_id` (`training_id`),
  CONSTRAINT `lad_course_enrollment_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE,
  CONSTRAINT `lad_course_enrollment_ibfk_2` FOREIGN KEY (`training_id`) REFERENCES `lad_training` (`training_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `lad_course_enrollment` */

/*Table structure for table `lad_elearning` */

DROP TABLE IF EXISTS `lad_elearning`;

CREATE TABLE `lad_elearning` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `content_link` varchar(255) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `level` varchar(30) DEFAULT NULL,
  `instructor_name` varchar(120) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `status` varchar(30) DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `lad_elearning` */

/*Table structure for table `lad_skillsgap_analysis` */

DROP TABLE IF EXISTS `lad_skillsgap_analysis`;

CREATE TABLE `lad_skillsgap_analysis` (
  `skillsgap_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `skill_name` varchar(150) NOT NULL,
  `current_level` varchar(50) DEFAULT NULL,
  `required_level` varchar(50) DEFAULT NULL,
  `gap_notes` text DEFAULT NULL,
  `analysis_date` date DEFAULT curdate(),
  PRIMARY KEY (`skillsgap_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `lad_skillsgap_analysis_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `lad_skillsgap_analysis` */

/*Table structure for table `lad_training` */

DROP TABLE IF EXISTS `lad_training`;

CREATE TABLE `lad_training` (
  `training_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_title` varchar(150) NOT NULL,
  `trainer_name` varchar(120) NOT NULL,
  `laboratory_room` varchar(100) DEFAULT NULL,
  `mode` varchar(50) NOT NULL,
  `schedule_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(30) DEFAULT 'Scheduled',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`training_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `lad_training` */

/*Table structure for table `pacm_allowances` */

DROP TABLE IF EXISTS `pacm_allowances`;

CREATE TABLE `pacm_allowances` (
  `allowance_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `allowance_code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `taxable` tinyint(1) DEFAULT 1,
  `recurring` tinyint(1) DEFAULT 1,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_allowances` */

/*Table structure for table `pacm_benefits` */

DROP TABLE IF EXISTS `pacm_benefits`;

CREATE TABLE `pacm_benefits` (
  `benefit_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `benefit_type` varchar(100) DEFAULT NULL,
  `provider` varchar(150) DEFAULT NULL,
  `employee_contribution` decimal(12,2) DEFAULT 0.00,
  `employer_contribution` decimal(12,2) DEFAULT 0.00,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_benefits` */

/*Table structure for table `pacm_compliance` */

DROP TABLE IF EXISTS `pacm_compliance`;

CREATE TABLE `pacm_compliance` (
  `compliance_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('pending','in_progress','completed','overdue') DEFAULT 'pending',
  `document_url` varchar(255) DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `last_checked` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_compliance` */

/*Table structure for table `pacm_deductions` */

DROP TABLE IF EXISTS `pacm_deductions`;

CREATE TABLE `pacm_deductions` (
  `deduction_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `deduction_code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `pre_tax` tinyint(1) DEFAULT 1,
  `recurring` tinyint(1) DEFAULT 0,
  `period_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_deductions` */

/*Table structure for table `pacm_departments` */

DROP TABLE IF EXISTS `pacm_departments`;

CREATE TABLE `pacm_departments` (
  `department_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `manager_emp_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_departments` */

/*Table structure for table `pacm_pay_periods` */

DROP TABLE IF EXISTS `pacm_pay_periods`;

CREATE TABLE `pacm_pay_periods` (
  `period_id` int(11) NOT NULL,
  `period_name` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `frequency` enum('monthly','semimonthly','weekly','biweekly') DEFAULT 'monthly',
  `closed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_pay_periods` */

/*Table structure for table `pacm_payroll_audit` */

DROP TABLE IF EXISTS `pacm_payroll_audit`;

CREATE TABLE `pacm_payroll_audit` (
  `audit_id` int(11) NOT NULL,
  `actor` varchar(150) DEFAULT NULL,
  `action` varchar(150) DEFAULT NULL,
  `object_type` varchar(100) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_payroll_audit` */

/*Table structure for table `pacm_payslip_lines` */

DROP TABLE IF EXISTS `pacm_payslip_lines`;

CREATE TABLE `pacm_payslip_lines` (
  `line_id` int(11) NOT NULL,
  `payslip_id` int(11) NOT NULL,
  `component_type` enum('allowance','deduction','tax','benefit','statutory','other') NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `label` varchar(150) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT 0.00,
  `sequence` int(11) DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_payslip_lines` */

/*Table structure for table `pacm_payslips` */

DROP TABLE IF EXISTS `pacm_payslips`;

CREATE TABLE `pacm_payslips` (
  `payslip_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `calc_id` int(11) DEFAULT NULL,
  `generated_by` varchar(100) DEFAULT NULL,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `gross_pay` decimal(12,2) DEFAULT 0.00,
  `total_allowances` decimal(12,2) DEFAULT 0.00,
  `total_deductions` decimal(12,2) DEFAULT 0.00,
  `total_taxes` decimal(12,2) DEFAULT 0.00,
  `net_pay` decimal(12,2) DEFAULT 0.00,
  `pdf_url` varchar(255) DEFAULT NULL,
  `status` enum('draft','finalized','sent') DEFAULT 'draft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_payslips` */

/*Table structure for table `pacm_salary_calculation` */

DROP TABLE IF EXISTS `pacm_salary_calculation`;

CREATE TABLE `pacm_salary_calculation` (
  `calc_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `basic_salary` decimal(12,2) NOT NULL DEFAULT 0.00,
  `days_worked` decimal(5,2) DEFAULT 0.00,
  `overtime_hours` decimal(6,2) DEFAULT 0.00,
  `overtime_multiplier` decimal(5,2) DEFAULT 1.00,
  `gross_pay` decimal(12,2) DEFAULT 0.00,
  `total_allowances` decimal(12,2) DEFAULT 0.00,
  `total_deductions` decimal(12,2) DEFAULT 0.00,
  `total_taxes` decimal(12,2) DEFAULT 0.00,
  `total_statutory` decimal(12,2) DEFAULT 0.00,
  `net_pay` decimal(12,2) DEFAULT 0.00,
  `calculated_by` varchar(100) DEFAULT NULL,
  `calculated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_salary_calculation` */

/*Table structure for table `pacm_settings` */

DROP TABLE IF EXISTS `pacm_settings`;

CREATE TABLE `pacm_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_settings` */

/*Table structure for table `pacm_statutory` */

DROP TABLE IF EXISTS `pacm_statutory`;

CREATE TABLE `pacm_statutory` (
  `statutory_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `employee_rate` decimal(6,4) DEFAULT 0.0000,
  `employer_rate` decimal(6,4) DEFAULT 0.0000,
  `cap_amount` decimal(12,2) DEFAULT NULL,
  `calculation_basis` enum('gross','basic','taxable') DEFAULT 'gross',
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_statutory` */

/*Table structure for table `pacm_taxes` */

DROP TABLE IF EXISTS `pacm_taxes`;

CREATE TABLE `pacm_taxes` (
  `tax_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `rate_percent` decimal(6,4) DEFAULT 0.0000,
  `fixed_amount` decimal(12,2) DEFAULT 0.00,
  `calculation_method` enum('percentage','fixed','progressive','custom') DEFAULT 'percentage',
  `json_rule` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_rule`)),
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pacm_taxes` */

/*Table structure for table `pm_evaluations` */

DROP TABLE IF EXISTS `pm_evaluations`;

CREATE TABLE `pm_evaluations` (
  `id` int(11) NOT NULL,
  `employee_name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `punctuality` varchar(50) NOT NULL,
  `performance` varchar(50) NOT NULL,
  `teamwork` varchar(50) NOT NULL,
  `comments` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_score` int(11) DEFAULT NULL,
  `average_score` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pm_evaluations` */

/*Table structure for table `rao_applicants` */

DROP TABLE IF EXISTS `rao_applicants`;

CREATE TABLE `rao_applicants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `resume_file` varchar(255) DEFAULT NULL,
  `application_status` varchar(50) DEFAULT 'Applied',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `rao_applicants_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `rao_jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_applicants` */

/*Table structure for table `rao_documents` */

DROP TABLE IF EXISTS `rao_documents`;

CREATE TABLE `rao_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `document_type` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `rao_documents_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_documents` */

/*Table structure for table `rao_interview_feedback` */

DROP TABLE IF EXISTS `rao_interview_feedback`;

CREATE TABLE `rao_interview_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interview_id` int(11) DEFAULT NULL,
  `interviewer_name` varchar(255) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interview_id` (`interview_id`),
  CONSTRAINT `rao_interview_feedback_ibfk_1` FOREIGN KEY (`interview_id`) REFERENCES `rao_interviews` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_interview_feedback` */

/*Table structure for table `rao_interviews` */

DROP TABLE IF EXISTS `rao_interviews`;

CREATE TABLE `rao_interviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `interview_date` datetime DEFAULT NULL,
  `interview_type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `rao_interviews_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_interviews` */

/*Table structure for table `rao_jobs` */

DROP TABLE IF EXISTS `rao_jobs`;

CREATE TABLE `rao_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_title` varchar(255) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `employment_type` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_jobs` */

/*Table structure for table `rao_offers` */

DROP TABLE IF EXISTS `rao_offers`;

CREATE TABLE `rao_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `offer_date` date DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `benefits` text DEFAULT NULL,
  `offer_status` varchar(50) DEFAULT 'Pending',
  `signed_document` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `rao_offers_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_offers` */

/*Table structure for table `rao_onboarding` */

DROP TABLE IF EXISTS `rao_onboarding`;

CREATE TABLE `rao_onboarding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `mentor` varchar(255) DEFAULT NULL,
  `tasks` text DEFAULT NULL,
  `progress` varchar(50) DEFAULT 'Not Started',
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `rao_onboarding_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_onboarding` */

/*Table structure for table `rao_resume_data` */

DROP TABLE IF EXISTS `rao_resume_data`;

CREATE TABLE `rao_resume_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `experience` text DEFAULT NULL,
  `education` text DEFAULT NULL,
  `certifications` text DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `flagged` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `rao_resume_data_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_resume_data` */

/*Table structure for table `rao_screening_answers` */

DROP TABLE IF EXISTS `rao_screening_answers`;

CREATE TABLE `rao_screening_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `rao_screening_answers_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `rao_applicants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rao_screening_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `rao_screening_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_screening_answers` */

/*Table structure for table `rao_screening_questions` */

DROP TABLE IF EXISTS `rao_screening_questions`;

CREATE TABLE `rao_screening_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT NULL,
  `question` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `rao_screening_questions_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `rao_jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rao_screening_questions` */

/*Table structure for table `spcd_career_path` */

DROP TABLE IF EXISTS `spcd_career_path`;

CREATE TABLE `spcd_career_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) NOT NULL,
  `current_position` varchar(100) DEFAULT NULL,
  `target_position` varchar(100) DEFAULT NULL,
  `development_actions` text DEFAULT NULL,
  `expected_completion_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `spcd_career_path` */

/*Table structure for table `spcd_high_potential` */

DROP TABLE IF EXISTS `spcd_high_potential`;

CREATE TABLE `spcd_high_potential` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `potential_score` int(11) DEFAULT NULL,
  `last_review_date` date DEFAULT NULL,
  `next_review_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `spcd_high_potential` */

/*Table structure for table `spcd_leadership_program` */

DROP TABLE IF EXISTS `spcd_leadership_program`;

CREATE TABLE `spcd_leadership_program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_name` varchar(100) DEFAULT NULL,
  `employee_name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('Ongoing','Completed','Planned') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `spcd_leadership_program` */

/*Table structure for table `spcd_role_transition` */

DROP TABLE IF EXISTS `spcd_role_transition`;

CREATE TABLE `spcd_role_transition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) DEFAULT NULL,
  `current_role` varchar(100) DEFAULT NULL,
  `new_role` varchar(100) DEFAULT NULL,
  `transition_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `spcd_role_transition` */

/*Table structure for table `spcd_talent_pool` */

DROP TABLE IF EXISTS `spcd_talent_pool`;

CREATE TABLE `spcd_talent_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `potential_level` enum('High','Medium','Low') NOT NULL,
  `date_identified` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `spcd_talent_pool` */

insert  into `spcd_talent_pool`(`id`,`employee_name`,`employee_id`,`department`,`position`,`potential_level`,`date_identified`,`created_at`) values 
(1,'sgsdds','1233','sfasf','safassaf','Low','2025-09-01','2025-09-01 16:23:29');

/*Table structure for table `taam_attendance_log` */

DROP TABLE IF EXISTS `taam_attendance_log`;

CREATE TABLE `taam_attendance_log` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `clock_in` datetime DEFAULT NULL,
  `clock_out` datetime DEFAULT NULL,
  `STATUS` enum('present','absent','late','leave') DEFAULT 'present',
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `employee_id` (`employee_id`,`log_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_attendance_log` */

/*Table structure for table `taam_audit_log` */

DROP TABLE IF EXISTS `taam_audit_log`;

CREATE TABLE `taam_audit_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ACTION` varchar(100) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `action_time` datetime DEFAULT current_timestamp(),
  `details` text DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_audit_log` */

/*Table structure for table `taam_departments` */

DROP TABLE IF EXISTS `taam_departments`;

CREATE TABLE `taam_departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_departments` */

/*Table structure for table `taam_leave_requests` */

DROP TABLE IF EXISTS `taam_leave_requests`;

CREATE TABLE `taam_leave_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) NOT NULL,
  `leave_type` enum('Annual','Sick','Emergency') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_leave_requests` */

/*Table structure for table `taam_leave_types` */

DROP TABLE IF EXISTS `taam_leave_types`;

CREATE TABLE `taam_leave_types` (
  `leave_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`leave_type_id`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_leave_types` */

/*Table structure for table `taam_overtime_requests` */

DROP TABLE IF EXISTS `taam_overtime_requests`;

CREATE TABLE `taam_overtime_requests` (
  `overtime_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `ot_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `reason` text DEFAULT NULL,
  `STATUS` enum('pending','approved','rejected') DEFAULT 'pending',
  `requested_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`overtime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_overtime_requests` */

/*Table structure for table `taam_shift_schedule` */

DROP TABLE IF EXISTS `taam_shift_schedule`;

CREATE TABLE `taam_shift_schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `status` enum('scheduled','completed','missed') DEFAULT 'scheduled',
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `employee_id` (`employee_id`,`shift_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `taam_shift_schedule` */

/*Table structure for table `user_accounts` */

DROP TABLE IF EXISTS `user_accounts`;

CREATE TABLE `user_accounts` (
  `id` int(11) NOT NULL,
  `employee_id` int(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_accounts` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password_hash`,`role`,`created_at`) values 
(1,'Andrie','andrie','user','2025-08-25 11:09:00'),
(2,'Dan','Dan','user','2025-08-25 11:09:47'),
(3,'corre','corre','user','2025-08-25 11:10:19'),
(4,'jhon carlo','tsukasa','user','2025-08-25 11:56:04'),
(5,'jhoncarlo','tsukasa07','admin','2025-08-25 14:52:03');

/*Table structure for table `wfar_attrition_turnover` */

DROP TABLE IF EXISTS `wfar_attrition_turnover`;

CREATE TABLE `wfar_attrition_turnover` (
  `attrition_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `last_working_day` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`attrition_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `wfar_attrition_turnover_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `wfar_attrition_turnover` */

/*Table structure for table `wfar_diversity_inclusion` */

DROP TABLE IF EXISTS `wfar_diversity_inclusion`;

CREATE TABLE `wfar_diversity_inclusion` (
  `diversity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `ethnicity` varchar(100) DEFAULT NULL,
  `disability_status` enum('Yes','No') DEFAULT NULL,
  `veteran_status` enum('Yes','No') DEFAULT NULL,
  PRIMARY KEY (`diversity_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `wfar_diversity_inclusion_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `wfar_diversity_inclusion` */

/*Table structure for table `wfar_predictive_analytics` */

DROP TABLE IF EXISTS `wfar_predictive_analytics`;

CREATE TABLE `wfar_predictive_analytics` (
  `prediction_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `risk_level` enum('Low','Medium','High') DEFAULT NULL,
  `prediction_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`prediction_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `wfar_predictive_analytics_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `em_employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `wfar_predictive_analytics` */

/*Table structure for table `wr_custom_reports` */

DROP TABLE IF EXISTS `wr_custom_reports`;

CREATE TABLE `wr_custom_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `wr_custom_reports` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
