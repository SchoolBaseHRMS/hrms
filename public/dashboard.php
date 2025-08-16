<?php
  // HRMS Simple Dashboard with Fixed Sidebar
  session_start();
  if (!isset($_SESSION["admin_name"])) { $_SESSION["admin_name"] = "Admin Doe"; }
  date_default_timezone_set("Asia/Manila");
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>HRMS Dashboard — Fixed Sidebar</title>
  <link rel="stylesheet" href="styles/dashboard.css?ts=<?php echo time(); ?>"/>
</head>
<body>
  <aside class="sidebar" aria-label="Primary">
    <div class="brand">HRMS</div>
    <nav class="menu" role="navigation" aria-label="Main">
      <a href="#" class="menu-item" data-view="overview">Overview</a>

      <div class="menu-section">Modules</div>

      <!-- Employee Management -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-employee">
          1. Employee Management
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-employee" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="employee-db">Employee Database</a>
          <a href="#" class="submenu-item" data-view="personal-info">Personal Info</a>
          <a href="#" class="submenu-item" data-view="employment-history">Employment History</a>
          <a href="#" class="submenu-item" data-view="documents">Document Management</a>
          <a href="#" class="submenu-item" data-view="self-service">Employee Self-Service</a>
        </div>
      </div>

      <!-- Recruitment & Onboarding -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-recruitment">
          2. Recruitment & Onboarding
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-recruitment" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="job-posting">Job Posting & ATS</a>
          <a href="#" class="submenu-item" data-view="resume-parsing">Resume Parsing</a>
          <a href="#" class="submenu-item" data-view="interviews">Interview Scheduling</a>
          <a href="#" class="submenu-item" data-view="offers">Offer Management</a>
          <a href="#" class="submenu-item" data-view="onboarding">New Hire Onboarding</a>
        </div>
      </div>

      <!-- Payroll -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-payroll">
          3. Payroll & Compensation
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-payroll" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="salary">Salary Calculation</a>
          <a href="#" class="submenu-item" data-view="tax">Tax & Deductions</a>
          <a href="#" class="submenu-item" data-view="deductions">Deductions</a>
          <a href="#" class="submenu-item" data-view="benefits">Benefits & Allowances</a>
          <a href="#" class="submenu-item" data-view="allowances">Allowances</a>
          <a href="#" class="submenu-item" data-view="payslips">Payslip Generation</a>
          <a href="#" class="submenu-item" data-view="compliance-payroll">Compliance Reporting</a>
        </div>
      </div>

      <!-- Time & Attendance -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-time">
          4. Time & Attendance
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-time" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="shifts">Shift Scheduling</a>
          <a href="#" class="submenu-item" data-view="attendance">Attendance Tracking</a>
          <a href="#" class="submenu-item" data-view="leave">Leave Management</a>
          <a href="#" class="submenu-item" data-view="overtime">Overtime & Absence</a>
          <a href="#" class="submenu-item" data-view="absence">Absence</a>
          <a href="#" class="submenu-item" data-view="holiday">Holiday</a>
          <a href="#" class="submenu-item" data-view="calendar">Calendar</a>
        </div>
      </div>

      <!-- Performance -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-performance">
          5. Performance Management
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-performance" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="goals">Goal & KPI Tracking</a>
          <a href="#" class="submenu-item" data-view="appraisals">Appraisals</a>
          <a href="#" class="submenu-item" data-view="feedback360">360° Feedback</a>
          <a href="#" class="submenu-item" data-view="perf-reports">Performance Reports</a>
          <a href="#" class="submenu-item" data-view="training-reco">Training Recommendations</a>
        </div>
      </div>

      <!-- Learning -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-learning">
          6. Learning & Development
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-learning" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="programs">Training Programs</a>
          <a href="#" class="submenu-item" data-view="enrollment">Course Enrollment</a>
          <a href="#" class="submenu-item" data-view="certs">Certification Management</a>
          <a href="#" class="submenu-item" data-view="elearning">E-Learning</a>
          <a href="#" class="submenu-item" data-view="skills-gap">Skills Gap Analysis</a>
        </div>
      </div>

      <!-- Engagement -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-engagement">
          7. Engagement & Relations
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-engagement" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="surveys">Surveys & Feedback</a>
          <a href="#" class="submenu-item" data-view="rewards">Recognition & Rewards</a>
          <a href="#" class="submenu-item" data-view="grievances">Grievance Handling</a>
          <a href="#" class="submenu-item" data-view="portal">Communication Portal</a>
          <a href="#" class="submenu-item" data-view="collab">Social Collaboration</a>
        </div>
      </div>

      <!-- Compliance -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-compliance">
          8. Compliance & Legal
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-compliance" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="labor-law">Labor Law Compliance</a>
          <a href="#" class="submenu-item" data-view="policy">Policy Documents</a>
          <a href="#" class="submenu-item" data-view="incidents">Incident Reporting</a>
          <a href="#" class="submenu-item" data-view="risks">Risk Assessment</a>
          <a href="#" class="submenu-item" data-view="audits">Audits & Reporting</a>
        </div>
      </div>

      <!-- Analytics -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-analytics">
          9. Workforce Analytics
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-analytics" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="dashboard">HR Dashboard</a>
          <a href="#" class="submenu-item" data-view="attrition">Attrition & Turnover</a>
          <a href="#" class="submenu-item" data-view="diversity">Diversity & Inclusion</a>
          <a href="#" class="submenu-item" data-view="predictive">Predictive Analytics</a>
          <a href="#" class="submenu-item" data-view="custom-reports">Custom Reports</a>
        </div>
      </div>

      <!-- Succession -->
      <div class="menu-block">
        <button class="menu-item toggle-sub" aria-expanded="false" aria-controls="submenu-succession">
          10. Succession & Career
          <span class="chev" aria-hidden="true">▸</span>
        </button>
        <div id="submenu-succession" class="submenu" hidden>
          <a href="#" class="submenu-item" data-view="talent-pool">Talent Pool</a>
          <a href="#" class="submenu-item" data-view="career-paths">Career Paths</a>
          <a href="#" class="submenu-item" data-view="hipo">HiPo Tracking</a>
          <a href="#" class="submenu-item" data-view="leadership">Leadership Dev</a>
          <a href="#" class="submenu-item" data-view="transitions">Role Transitions</a>
        </div>
      </div>

    </nav>
  </aside>

  <main class="content" id="main">
    <header class="topbar">
      <h1>HRMS Dashboard</h1>
      <div class="spacer"></div>
      <div class="user-chip">
        <div class="avatar"><?php echo strtoupper(substr($_SESSION["admin_name"], 0, 1)); ?></div>
        <span class="name"><?php echo htmlspecialchars($_SESSION["admin_name"]); ?></span>
      </div>
    </header>

    <!-- Overview -->
    <section id="view-overview" class="view active">
      <div class="cards">
        <div class="card"><h3>Total Employees</h3><p class="metric">214</p></div>
        <div class="card"><h3>Open Roles</h3><p class="metric">12</p></div>
        <div class="card"><h3>Pending Leaves</h3><p class="metric">7</p></div>
        <div class="card"><h3>Grievances</h3><p class="metric">3</p></div>
      </div>
      <div class="panel">
        <h2>Quick Links</h2>
        <div class="quick">
          <button class="btn" data-view="employee-db">Add Employee</button>
          <button class="btn" data-view="job-posting">Post a Job</button>
          <button class="btn" data-view="leave">Approve Leave</button>
          <button class="btn" data-view="surveys">Create Survey</button>
        </div>
      </div>
    </section>

    <!-- Example submodule views (placeholders). Add more if needed. -->
    <section id="view-employee-db" class="view"><h2>Employee Database</h2><p>Placeholder for employee list/CRUD.</p></section>
    <section id="view-personal-info" class="view"><h2>Personal Information</h2><p>Profile editing and personal details.</p></section>
    <section id="view-employment-history" class="view"><h2>Employment History</h2><p>Roles, promotions, tenure.</p></section>
    <section id="view-documents" class="view"><h2>Document Management</h2><p>Upload/download HR documents.</p></section>
    <section id="view-self-service" class="view"><h2>Employee Self-Service</h2><p>Self-service features.</p></section>

    <section id="view-job-posting" class="view"><h2>Job Posting & ATS</h2></section>
    <section id="view-resume-parsing" class="view"><h2>Resume Parsing</h2></section>
    <section id="view-interviews" class="view"><h2>Interview Scheduling</h2></section>
    <section id="view-offers" class="view"><h2>Offer Management</h2></section>
    <section id="view-onboarding" class="view"><h2>New Hire Onboarding</h2></section>

    <section id="view-salary" class="view"><h2>Salary Calculation</h2></section>
    <section id="view-tax" class="view"><h2>Tax & Deductions</h2></section>
    <section id="view-benefits" class="view"><h2>Benefits & Allowances</h2></section>
    <section id="view-payslips" class="view"><h2>Payslip Generation</h2></section>
    <section id="view-compliance-payroll" class="view"><h2>Payroll Compliance</h2></section>

    <section id="view-shifts" class="view"><h2>Shift Scheduling</h2></section>
    <section id="view-attendance" class="view"><h2>Attendance Tracking</h2></section>
    <section id="view-leave" class="view"><h2>Leave Management</h2></section>
    <section id="view-overtime" class="view"><h2>Overtime & Absence</h2></section>
    <section id="view-calendar" class="view"><h2>Holiday & Calendar</h2></section>

    <section id="view-goals" class="view"><h2>Goals & KPIs</h2></section>
    <section id="view-appraisals" class="view"><h2>Appraisals</h2></section>
    <section id="view-feedback360" class="view"><h2>360° Feedback</h2></section>
    <section id="view-perf-reports" class="view"><h2>Performance Reports</h2></section>
    <section id="view-training-reco" class="view"><h2>Training Recommendations</h2></section>

    <section id="view-programs" class="view"><h2>Training Programs</h2></section>
    <section id="view-enrollment" class="view"><h2>Course Enrollment</h2></section>
    <section id="view-certs" class="view"><h2>Certification Management</h2></section>
    <section id="view-elearning" class="view"><h2>E-Learning</h2></section>
    <section id="view-skills-gap" class="view"><h2>Skills Gap Analysis</h2></section>

    <section id="view-surveys" class="view"><h2>Surveys & Feedback</h2></section>
    <section id="view-rewards" class="view"><h2>Recognition & Rewards</h2></section>
    <section id="view-grievances" class="view"><h2>Grievance Handling</h2></section>
    <section id="view-portal" class="view"><h2>Communication Portal</h2></section>
    <section id="view-collab" class="view"><h2>Social Collaboration</h2></section>

    <section id="view-labor-law" class="view"><h2>Labor Law Compliance</h2></section>
    <section id="view-policy" class="view"><h2>Policy Documentation</h2></section>
    <section id="view-incidents" class="view"><h2>Incident Reporting</h2></section>
    <section id="view-risks" class="view"><h2>Risk Assessment</h2></section>
    <section id="view-audits" class="view"><h2>Audits & Reporting</h2></section>

    <section id="view-dashboard" class="view"><h2>HR Dashboard</h2></section>
    <section id="view-attrition" class="view"><h2>Attrition & Turnover</h2></section>
    <section id="view-diversity" class="view"><h2>Diversity & Inclusion</h2></section>
    <section id="view-predictive" class="view"><h2>Predictive Analytics</h2></section>
    <section id="view-custom-reports" class="view"><h2>Custom Reports</h2></section>

    <section id="view-talent-pool" class="view"><h2>Talent Pool</h2></section>
    <section id="view-career-paths" class="view"><h2>Career Paths</h2></section>
    <section id="view-hipo" class="view"><h2>HiPo Tracking</h2></section>
    <section id="view-leadership" class="view"><h2>Leadership Development</h2></section>
    <section id="view-transitions" class="view"><h2>Role Transitions</h2></section>

  </main>

  <script src="js/dashboard.js?ts=<?php echo time(); ?>"></script>
</body>
</html>