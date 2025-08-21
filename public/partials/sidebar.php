<?php

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="/hrms/public/styles/sidebar.css"> 
    <script src="/hrms/public/js/sidebar.js" defer></script>
    <title>Sidebar Dropdown</title>
</head>
<body>
    
    <button id="sidebarToggle" class="burger" aria-label="Toggle navigation" aria-expanded="false">
        <i class='bx bx-menu'></i>
    </button>
    <div class="sidebar" id="sidebar">
        <div class="logo-details">
            <div class="logo-img"><img src="/hrms/public/img/k.png" alt=""></div>
            <span class="logo_name">Kupal University</span>

             
        </div>
        <ul class="nav-links">
            <li>
                <a href="#">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Dashboard</span>
                </a>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-user'></i>
                        <span class="employee-management">Employee Management</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Employee Database</a></li>
                    <li><a href="#">Personal Information Management</a></li>
                    <li><a href="#">Employment History</a></li>
                    <li><a href="#">Document Management</a></li>
                    <li><a href="#">Employee Self Service</a></li>
                </ul>
            </li>
             <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-briefcase'></i>
                        <span class="recruitment-and-onboarding">Recruitment</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Job Posting</a></li>
                    <li><a href="#">Applicant Tracking</a></li>
                    <li><a href="#">Resume Parsing</a></li>
                    <li><a href="#">Screening</a></li>
                    <li><a href="#">Interview Scheduling</a></li>
                    <li><a href="#">Offer Management</a></li>
                    <li><a href="#">New Hire Onboarding</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-dollar'></i>
                        <span class="payroll-and-compensation">Payroll</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Salary Calculation</a></li>
                    <li><a href="#">Tax Management</a></li>
                    <li><a href="#">Deductions Management</a></li>
                    <li><a href="#">Benefits</a></li>
                    <li><a href="#">Allowance</a></li>
                    <li><a href="#">Payslip Generation</a></li>
                    <li><a href="#">Compliance Reporting</a></li>
                    <li><a href="#">Statutory Reporting</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-time'></i>
                        <span class="time-and-attendance">Attendance</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Shift Scheduling</a></li>
                    <li><a href="#">Attendance Tracking</a></li>
                    <li><a href="#">Leave Management</a></li>
                    <li><a href="#">Overtime</a></li>
                    <li><a href="#">Absence</a></li>
                    <li><a href="#">Holiday</a></li>
                    <li><a href="#">Calendar</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-line-chart'></i>
                        <span class="performance-management">Performance</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Goal Setting</a></li>
                    <li><a href="#">Kpi Tracking</a></li>
                    <li><a href="#">Appraisals</a></li>
                    <li><a href="#">Review</a></li>
                    <li><a href="#">360-Feedback</a></li>
                    <li><a href="#">Performance Reports</a></li>
                    <li><a href="#">Training Recommendations</a></li>
                    <li><a href="#">Development Recommendtions</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-book'></i>
                        <span class="learning-and-development">Learning</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Training Program</a></li>
                    <li><a href="#">Course Enrollment</a></li>
                    <li><a href="#">Course Tracking</a></li>
                    <li><a href="#">Certification Management</a></li>
                    <li><a href="#">E-Learning</a></li>
                    <li><a href="#">Virtual Training</a></li>
                    <li><a href="#">Skill Gap Analysis</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-heart'></i>
                        <span class="employee-engagement-and-relations">Engagement</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Surveys</a></li>
                    <li><a href="#">Feedback</a></li>
                    <li><a href="#">Recognition</a></li>
                    <li><a href="#">Rewards</a></li>
                    <li><a href="#">Grievance Handling</a></li>
                    <li><a href="#">Communication Portals</a></li>
                    <li><a href="#">Socials</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-shield'></i>
                        <span class="compliance-and-legal-management">Compliance</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Labor Law Compliance</a></li>
                    <li><a href="#">Policy Documentation</a></li>
                    <li><a href="#">Incident Reporting</a></li>
                    <li><a href="#">Risk Assessment</a></li>
                    <li><a href="#">Audits and Reporting</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-bar-chart-alt-2'></i>
                        <span class="workforce-analytics-and-reporting">Workforce</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Metrics</a></li>
                    <li><a href="#">Attrition Analysis</a></li>
                    <li><a href="#">Turnover Analysis</a></li>
                    <li><a href="#">Diversity Reports</a></li>
                    <li><a href="#">Inclusion Reports</a></li>
                    <li><a href="#">Predictive Analytics</a></li>
                    <li><a href="#">Custom HR Reports</a></li>
                </ul>
            </li>
            <li>
                <div class="icon-link">
                    <a href="#">
                        <i class='bx bx-briefcase-alt-2'></i>
                        <span class="succession-planning-and-career-development">Career Development</span>
                        <i class='bx bx-chevron-down arrow'></i>
                    </a>
                </div>
                <ul class="sub-menu">
                    <li><a href="#">Talent Pool Identification</a></li>
                    <li><a href="#">Career Path Mapping</a></li>
                    <li><a href="#">High-Potential Employee Tracking</a></li>
                    <li><a href="#">Leadership Development Programs</a></li>
                    <li><a href="#">Role Transition Planning</a></li>
                </ul>
            </li>
            <li class="logout">
                <form action="/hrms/public/login.php" method="post" class="logout-form" aria-label="Logout">
                    <button type="submit" class="logout-btn">
                        <i class='bx bx-log-out'></i>
                        <span class="link_name">Logout</span>
                    </button>
                </form>
            </li>
        </ul>
        </section>
    </div>
        

</body>
</html>