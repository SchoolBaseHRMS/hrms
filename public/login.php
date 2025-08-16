<?php
session_start();

$servername = "localhost";
$db_user = "root";
$db_pass = "";
$dbname = "hrms";

$conn = new mysqli($servername, $db_user, $db_pass, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Config
$max_attempts = 3;
$cooldown_seconds = 10; // 10 second cooldown

// Initialize session counters
if (!isset($_SESSION['login_attempts'])) {
    $_SESSION['login_attempts'] = 0;
}
if (!isset($_SESSION['last_attempt_time'])) {
    $_SESSION['last_attempt_time'] = 0;
}

$now = time();

// If cooldown expired, reset counters
if ($_SESSION['last_attempt_time'] > 0 && ($now - $_SESSION['last_attempt_time'] >= $cooldown_seconds)) {
    $_SESSION['login_attempts'] = 0;
    $_SESSION['last_attempt_time'] = 0;
}

$locked = ($_SESSION['login_attempts'] >= $max_attempts) && ($_SESSION['last_attempt_time'] > 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($locked) {
        $remaining = $cooldown_seconds - ($now - $_SESSION['last_attempt_time']);
        if ($remaining < 0) $remaining = 0;
        $error = "Too many attempts. Try again in {$remaining} second(s).";
    } else {
        $username = trim($_POST['username'] ?? '');
        $password = $_POST['password'] ?? '';

        $stmt = $conn->prepare("SELECT id, username, password_hash, role FROM users WHERE username = ? LIMIT 1");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        // Use password_verify for hashed passwords; if using plain text temporarily, replace with ($password === $user['password_hash'])
        if ($user && $password === $user['password_hash']) {
            // success
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['login_attempts'] = 0;
            $_SESSION['last_attempt_time'] = 0;
            $conn->close();
            header("Location: dashboard.php");
            exit();
        } else {
            // failed attempt
            $_SESSION['login_attempts']++;

            if ($_SESSION['login_attempts'] >= $max_attempts) {
                // start cooldown
                $_SESSION['last_attempt_time'] = $now;
                $error = "Maximum login attempts exceeded. Try again in {$cooldown_seconds} second(s).";
            } else {
                $remaining_attempts = $max_attempts - $_SESSION['login_attempts'];
                $error = "Invalid username or password. Attempts left: {$remaining_attempts}";
            }
        }
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="img/k (1).png" type="image/x-icon">
    <link rel="stylesheet" href="styles/login.css">
    <title>Login Page</title>
</head>
<body>
   <div class="login-bg">
        <div class="login-container">
            <div class="login-header">
                <img src="img/k.png" alt="Kupal University Logo" class="login-logo">
                <h2>Admin Portal</h2>
                <p>Welcome to Kupal University</p>
            </div>
            <?php if (isset($error)): ?>
                <div class="error-message" style="color: #d32f2f; margin-bottom: 12px;">
                    <?php echo $error; ?>
                </div>
            <?php endif; ?>
            <form action="login.php" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required autocomplete="username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required autocomplete="current-password">
                </div>
                <button type="submit" class="login-btn">Login</button>
            </form>
            <div class="login-footer">
                <a href="#">Forgot password?</a>
            </div>
        </div>
    </div>
</body>  
</html>


