<?php
require 'config/db.php';

// ADD
if(isset($_POST['add'])){
    $name = $_POST['employee_name'];
    $emp_id = $_POST['employee_id'];
    $dept = $_POST['department'];
    $score = $_POST['potential_score'];
    $last = $_POST['last_review_date'];
    $next = $_POST['next_review_date'];

    if(!$conn->query("INSERT INTO spcd_high_potential (employee_name, employee_id, department, potential_score, last_review_date, next_review_date)
        VALUES ('$name','$emp_id','$dept','$score','$last','$next')")){
        die("Insert failed: " . $conn->error);
    }
    header("Location: high_potential.php");
    exit;

     // Validate employee name (letters and spaces only)
    if (!preg_match("/^[a-zA-Z\s]+$/", $employee_name)) {
    echo "Error: Employee name can only contain letters and spaces.";
    exit();  // Stop execution if validation fails
    }

    // ✅ Validate potential score (1–3 digits, must be 1–100)
    if (!preg_match("/^[0-9]{1,3}$/", $score) || $score < 1 || $score > 100) {
    echo "Error: Potential score must be a number between 1 and 100.";
    exit();
    }
}

// UPDATE
if(isset($_POST['update'])){
    $id = $_POST['id'];
    $name = $_POST['employee_name'];
    $emp_id = $_POST['employee_id'];
    $dept = $_POST['department'];
    $score = $_POST['potential_score'];
    $last = $_POST['last_review_date'];
    $next = $_POST['next_review_date'];

    if(!$conn->query("UPDATE spcd_high_potential SET 
        employee_name='$name', 
        employee_id='$emp_id', 
        department='$dept', 
        potential_score='$score', 
        last_review_date='$last', 
        next_review_date='$next' 
        WHERE id=$id")){
        die("Update failed: " . $conn->error);
    }
    header("Location: high_potential.php");
    exit;
}

// DELETE
if(isset($_GET['delete'])){
    $id = $_GET['delete'];
    if(!$conn->query("DELETE FROM spcd_high_potential WHERE id=$id")){
        die("Delete failed: " . $conn->error);
    }
    header("Location: high_potential.php");
    exit;
}

// READ
$result = $conn->query("SELECT * FROM spcd_high_potential");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>High Potential Employees</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css"> 
    <script src="assets/js/bootstrap.bundle.min.js"></script>
</head>
<body style="background-color: #1e3c72">

<div class="container mt-5">
    <h2 style="color: #fff">High-Potential Employee Tracking</h2>
    <br>
    <button class="btn btn-secondary mb-3"><a href="dashboard.php" style="color:white;text-decoration:none;">Back</a></button>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#highModal" onclick="openAddModal()">Add Employee</button>

    <!-- Search -->
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search...">

    <!-- Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Employee Name</th>
                <th>Employee ID</th>
                <th>Department</th>
                <th>Potential Score</th>
                <th>Last Review</th>
                <th>Next Review</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="highTable">
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['employee_name'] ?></td>
                <td><?= $row['employee_id'] ?></td>
                <td><?= $row['department'] ?></td>
                <td><?= $row['potential_score'] ?></td>
                <td><?= $row['last_review_date'] ?></td>
                <td><?= $row['next_review_date'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal" 
                        data-bs-target="#highModal"
                        onclick="openEditModal(
                            '<?= $row['id'] ?>',
                            '<?= $row['employee_name'] ?>',
                            '<?= $row['employee_id'] ?>',
                            '<?= $row['department'] ?>',
                            '<?= $row['potential_score'] ?>',
                            '<?= $row['last_review_date'] ?>',
                            '<?= $row['next_review_date'] ?>'
                        )">Edit</button>
                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="highModal" tabindex="-1">
  <div class="modal-dialog">
    <form method="POST" class="modal-content" id="employeeForm">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">Add Employee</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="emp_id">
        <input type="text" name="employee_name" id="emp_name" class="form-control mb-2" placeholder="Employee Name" minlength="2" maxlength="100" required>
        <input type="text" name="employee_id" id="emp_code" class="form-control mb-2" placeholder="Employee ID" minlength="2" maxlength="20" required>
        <input type="text" name="department" id="emp_dept" class="form-control mb-2" placeholder="Department" minlength="2" maxlength="100" required>
        <input type="number" name="potential_score" id="emp_score" class="form-control mb-2" placeholder="Potential Score" min="1" max="100" minlength="1" maxlength="3" title="Put the Number of Potential Score" required>
        <input type="date" name="last_review_date" id="emp_last" class="form-control mb-2" title="Last Review Date" required>
        <input type="date" name="next_review_date" id="emp_next" class="form-control mb-2" title="Next Review Date" required>
      </div>
      <div class="modal-footer">
        <button type="submit" name="add" id="addBtn" class="btn btn-primary">Add</button>
        <button type="submit" name="update" id="updateBtn" class="btn btn-success d-none">Update</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </form>
  </div>
</div>

<script>
// Open modal for Add
function openAddModal() {
    document.getElementById("modalTitle").innerText = "Add Employee";
    document.getElementById("addBtn").classList.remove("d-none");
    document.getElementById("updateBtn").classList.add("d-none");
    document.getElementById("emp_id").value = "";
    document.getElementById("emp_name").value = "";
    document.getElementById("emp_code").value = "";
    document.getElementById("emp_dept").value = "";
    document.getElementById("emp_score").value = "";
    document.getElementById("emp_last").value = "";
    document.getElementById("emp_next").value = "";
}

// Open modal for Edit
function openEditModal(id, name, emp_id, dept, score, last, next) {
    document.getElementById("modalTitle").innerText = "Edit Employee";
    document.getElementById("addBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
    document.getElementById("emp_id").value = id;
    document.getElementById("emp_name").value = name;
    document.getElementById("emp_code").value = emp_id;
    document.getElementById("emp_dept").value = dept;
    document.getElementById("emp_score").value = score;
    document.getElementById("emp_last").value = last;
    document.getElementById("emp_next").value = next;
}

// Simple search filter
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#highTable tr");
    rows.forEach(r => {
        let text = r.innerText.toLowerCase();
        r.style.display = text.includes(filter) ? "" : "none";
    });
});

// Validate
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('employeeForm');
    const empnameInput = document.getElementById('emp_name');
    const scoreInput = document.getElementById('emp_score');

    form.addEventListener('submit', function(event) {
        // ✅ Validate Employee Name
        if (!/^[a-zA-Z\s]+$/.test(empnameInput.value)) {
            event.preventDefault();
            alert('Employee name can only contain letters and spaces.');
            empnameInput.focus();
            return;
        }

        // ✅ Validate Potential Score
        const score = parseInt(scoreInput.value);
        if (isNaN(score) || score < 1 || score > 100) {
            event.preventDefault();
            alert('Potential score must be between 1 and 100.');
            scoreInput.focus();
            return;
        }
    });

    // ✅ Prevent typing invalid characters in Employee Name
    empnameInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^a-zA-Z\s]/g, '');
    });

    // ✅ Prevent typing more than 3 digits in Potential Score
    scoreInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '').slice(0, 3);
    });
});


</script>

</body>
</html>
